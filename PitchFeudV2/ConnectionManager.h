//
//  ConnectionManager.h
//  PitchFeudV2
//
//  Created by Michael Godlowski-Maryniak on 22/03/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSURLConnectionWithTag.h"

@interface ConnectionManager : NSObject <NSURLConnectionDelegate>

typedef enum{
    
    Events
    
}Tag;

@property (nonatomic, strong) NSMutableDictionary *receivedData, *timers;
+(ConnectionManager*)Instance;
-(NSDictionary*)GetJSONDictionaryFromTag:(Tag)tag;
-(NSString*)StringFromEnum:(NSInteger)tag;
-(void)GetEventsWithMatchID: (NSInteger)matchId AndOffsetTimestamp:(NSInteger)offsetTimestamp AndLimitTimestamp:(NSInteger)limitTimestamp;

@end
