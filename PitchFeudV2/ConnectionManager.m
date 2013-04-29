//
//  ConnectionManager.m
//  PitchFeudV2
//
//  Created by Michael Godlowski-Maryniak on 22/03/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "ConnectionManager.h"

@implementation ConnectionManager

@synthesize receivedData = _receivedData, timers = _timers;

static ConnectionManager *instance = nil;
NSString *webserviceLocation = @"http://pitchfeud.astdev.lt/api/";

+(ConnectionManager*)Instance{
    
    @synchronized(self){
        
        if(instance == nil){
            instance = [[self alloc]initWithDictionary];
        }
    }
    
    return instance;
}

-(id)initWithDictionary{
    
    if (self = [super init]){
        
        self.receivedData = [[NSMutableDictionary alloc]init];
        self.timers = [[NSMutableDictionary alloc]init];
    }
    
    return self;
}

-(void)PostNotificationWithName:(NSString*)notificationName{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:notificationName object:self];
}

-(NSDictionary*)GetJSONDictionaryFromTag:(Tag)tag{
    NSData *JSONData = [self.receivedData objectForKey:[self StringFromEnum:tag]];
    NSError *error;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:&error];
    return jsonDictionary;
}

//-----------Webservice calls-------------

-(void)GetEventsWithMatchID: (NSInteger)matchId AndOffsetTimestamp:(NSInteger)offsetTimestamp AndLimitTimestamp:(NSInteger)limitTimestamp{
  
    NSString *urlString = [NSString stringWithFormat:@"events?offsetTimestamp=%d&limitTimestamp=%d&matchId=%d",offsetTimestamp,limitTimestamp,matchId];
    [self StartGETConnectionWithWebserviceLocation: webserviceLocation AndURLString: urlString AndTag:Events];
    
}

-(void)GetMinorEventsWithMatchID:(NSInteger)matchId AndOffsetTimestamp:(NSInteger)offsetTimestamp AndLimitTimestamp:(NSInteger)limitTimestamp{
    
    NSString *urlString = [NSString stringWithFormat:@"touches?offsetTimestamp=%d&limitTimestamp=%d&matchId=%d",offsetTimestamp,limitTimestamp,matchId];
    [self StartGETConnectionWithWebserviceLocation: webserviceLocation AndURLString: urlString AndTag:MinorEvents];
}

-(NSURLConnectionWithTag*)StartGETConnectionWithWebserviceLocation: (NSString*)location AndURLString:(NSString*)urlString AndTag:(Tag)tag{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[location stringByAppendingString:urlString]]];
    [request setHTTPMethod:@"GET"];
    
    NSURLConnectionWithTag *connection = [[NSURLConnectionWithTag alloc] initWithRequest: request delegate:self startImmediately:YES WithTag:tag];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:30.0f target:self selector:@selector(ConnectionProblems:) userInfo:connection repeats:NO];
    
    [self.timers setObject:timer forKey:[self StringFromEnum:connection.tag]];
    
    return connection;
}

-(NSURLConnectionWithTag*)StartPOSTConnectionWithWebserviceLocation: (NSString*)location AndName:(NSString*)name AndJSONObj:(NSMutableDictionary*)JSONObj AndTag:(Tag)tag{
    
    NSError *error;
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:JSONObj options:NSJSONWritingPrettyPrinted error:&error];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[location stringByAppendingString:name]]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [JSONData length]] forHTTPHeaderField:@"Content-Length"] ;
    [request setHTTPBody: JSONData];
    
    NSURLConnectionWithTag *connection = [[NSURLConnectionWithTag alloc] initWithRequest: request delegate:self startImmediately:YES WithTag:tag];
    
    //Run a timer and check after x seconds if a connection has been established, if not, inform the user and cancel the connection
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:30.0f target:self selector:@selector(ConnectionProblems:) userInfo:connection repeats:NO];
    
    [self.timers setObject:timer forKey:[self StringFromEnum:connection.tag]];
    
    return connection;
}

-(void)ConnectionProblems:(NSTimer*)timer{
    NSURLConnectionWithTag *connection = [timer userInfo];
    [connection cancel];
    [timer invalidate];
    [self.timers removeObjectForKey:[self StringFromEnum:connection.tag]];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Connection error" message: [NSString stringWithFormat:@"A connection error occured with the call to %@, please try again...", [self StringFromEnum:connection.tag]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    
    
}


- (void)connection:(NSURLConnectionWithTag *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    if([self.receivedData objectForKey:[self StringFromEnum:(connection.tag)]] != nil){
        [[self.receivedData valueForKey:[self StringFromEnum:connection.tag]] setLength:0];
    }
    
}

- (void)connection:(NSURLConnectionWithTag *)connection didReceiveData:(NSData *)data
{
    //Stop the timer for this connection check, since it is receiving data
    NSTimer *timer = [self.timers objectForKey:[self StringFromEnum:connection.tag]];
    [timer invalidate];
    [self.timers removeObjectForKey:[self StringFromEnum:connection.tag]];
    
    if([self.receivedData objectForKey:[self StringFromEnum:(connection.tag)]] == nil){
        [self.receivedData setObject:[[NSMutableData alloc]initWithData:data] forKey:[self StringFromEnum:connection.tag]];
    }else{
        
        NSMutableData *oldData = [self.receivedData objectForKey:[self StringFromEnum:(connection.tag)]];
        [oldData appendData:data];
        
    }
}

- (void)connection:(NSURLConnectionWithTag *)connection didFailWithError:(NSError *)error
{
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Connection error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    
    //stop the timer for the current connection check, since we already know it failed
    NSTimer *timer = [self.timers objectForKey:[self StringFromEnum:connection.tag]];
    [timer invalidate];
    [self.timers removeObjectForKey:[self StringFromEnum:connection.tag]];
}

- (void)connectionDidFinishLoading:(NSURLConnectionWithTag *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    
    NSMutableData *data = [self.receivedData objectForKey:[self StringFromEnum:(connection.tag)]];
    
    NSDictionary *currentJSONData = [self GetJSONDictionaryFromTag:connection.tag];
    NSLog([currentJSONData debugDescription]);
    
    //NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(text);
    NSLog(@"Succeeded! Received %d bytes of data", data.length);
    
    [self PostNotificationWithName: [self StringFromEnum:connection.tag]];
}

-(NSString*)StringFromEnum:(NSInteger)tag{
    NSString *s;
    
    switch (tag) {
        case Events:
            s = @"Events";
            break;
        case MinorEvents:
            s = @"MinorEvents";
            break;
        default:
            break;            
    }
    
    return s;
}


@end
