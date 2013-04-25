//
//  PitchViewController.m
//  PitchFeudV2
//
//  Created by Michael Godlowski-Maryniak on 24/03/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "PitchViewController.h"

@interface PitchViewController ()
{
    int minutes;
    int seconds;
    bool prevRequestSucceed;
    int eventNumber;
    UIImageView *eventImageView1;
    UILabel *eventLabel1;
    LineView *lineView1;
    UIImageView *eventImageView2;
    UILabel *eventLabel2;
    LineView *lineView2;
    UIImageView *eventImageView3;
    UILabel *eventLabel3;
    LineView *lineView3;
    UIImageView *eventImageView4;
    UILabel *eventLabel4;
    LineView *lineView4;
    
}

@property(nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) BOOL isAwayTeam;

@property (nonatomic, assign) int ballPossesionCountAway;
@property (nonatomic, assign) int ballPossesionCountHome;
@property (nonatomic, assign) int shotOffTargetCountAway;
@property (nonatomic, assign) int shotOffTargetCountHome;
@property (nonatomic, assign) int shotOnTargetCountAway;
@property (nonatomic, assign) int shotOnTargetCountHome;
@property (nonatomic, assign) int cornersCountAway;
@property (nonatomic, assign) int cornersCountHome;

@property(nonatomic, strong) NSTimer *timeDateTimer;

@property(nonatomic, strong) NSDictionary *events;

@property (nonatomic, retain) NSMutableArray* playsTableData;
@end

@implementation PitchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Michaels code
    minutes = 1; //the match always starts at 1 minute?
    seconds = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EventDataReceived) name: [[ConnectionManager Instance]StringFromEnum:Events] object:nil];
    [self ReceiveEventData];
}

- (void)timeDateTimerFireMethod:(NSTimer*)theTimer
{
    seconds++;
    if(seconds==60)
    {
        minutes++;
        seconds = 0;
        [self.timeDateTimer invalidate];
        self.timeDateTimer = nil;
        [self ReceiveEventData];
    }
    
    //NSLog(@"timeDateTimerFireMethod %@", [NSString stringWithFormat:@"%d:%d", minutes, seconds]);
    
    //Check event data for the event which happens at this exact time
    NSDictionary *event = [self.events objectForKey:[NSString stringWithFormat:@"%d:%d", minutes, seconds]];
    
    if(event)
    {
        NSLog(@"event");
        //is Away team?
        if([[event objectForKey:@"team_id"] isEqualToString:@"28"])
        {
            self.isAwayTeam = YES;
            
        } else {
            
            self.isAwayTeam = NO;
        }
        
        
        
        UIImage *icon;
        NSString *title;
        
        NSString *minutesStr = [NSString stringWithFormat:@"%@'", [NSNumber numberWithInt:([[event objectForKey:@"minutes"] intValue])]];
        
        /*
         
         Check for events
         
         event_number => event_text
         2   Caution
         5   Corner Kick
         6   Cross
         7   Expulsion (Red Card)?
         8   Foul
         9   Free Kick
         10  Game Over
         11  Goal
         13  Half Over
         16  Offside
         17  Penalty Kick - Good
         18  Penalty Kick - No Good
         19  Shot
         20  Shot on Goal
         21  Start Half
         22  Substitution
         28  Own Goal
         30  ShootOut Goal
         31  ShootOut Save
         32  Hand Ball Foul
         41  ShootOut Miss
         46  Goal Kick
         47  Throw-In
         */
        
        //----------ICONS----------------------
        
        if([[event objectForKey:@"event_number"] isEqualToString:@"11"])//Goal
        {
            NSLog(@"Goal: %@", [event objectForKey:@"event_number"]);
            title = [event objectForKey:@"offensive_player_shirt_name"];
            if([title isEqualToString:@""])
                title = [event objectForKey:@"offensive_player_full_last_name"];
            icon = [UIImage imageNamed:@"ticker_goal.png"];
        } else if([[event objectForKey:@"event_number"] isEqualToString:@"2"]) {//Caution (Yellow Card)?
            NSLog(@"Yellow Card: %@", [event objectForKey:@"event_number"]);
            title = [event objectForKey:@"offensive_player_shirt_name"];
            if([title isEqualToString:@""])
                title = [event objectForKey:@"offensive_player_full_last_name"];
            icon = [UIImage imageNamed:@"ticker_yellow_card.png"];
        } else if([[event objectForKey:@"event_number"] isEqualToString:@"7"]) {//Expulsion (Red Card)?
            NSLog(@"Red Card: %@", [event objectForKey:@"event_number"]);
            title = [event objectForKey:@"offensive_player_shirt_name"];
            if([title isEqualToString:@""])
                title = [event objectForKey:@"offensive_player_full_last_name"];
            icon = [UIImage imageNamed:@"ticker_red_card.png"];
        } else {
            title = [event objectForKey:@"ticker_red_card"];
            icon = [UIImage imageNamed:@"ButtonChat.png"];
            NSLog(@"title (icon) %@: %@", title, [event objectForKey:@"event_number"]);
        }
        
   
        //--------------POINTS----------------
        
        /*
         Main Screen pitch display
         
         Shots + Shot on Goal
         Goal (assist)
         Red Card
         Yellow Card
         Foul
         Offside
         Own Goal
         Penalty
         Throw-in
         Corner
         Goal Kick
         */
        
        NSNumber* pointsCommited = [NSNumber numberWithInt:0];
        NSNumber* pointsCommitedAgainst = [NSNumber numberWithInt:0];
        NSNumber* eventRevenue = [NSNumber numberWithInt:0];
        NSString *pointsReason = @"";
        
        
        //FIXME: shots and shot on goal
        if([[event objectForKey:@"event_number"] isEqualToString:@"19"])//Shots
        {
            pointsReason = @"Shots";
            eventRevenue = [NSNumber numberWithInt:30];
            pointsCommited = [NSNumber numberWithInt:20];
            pointsCommitedAgainst = [NSNumber numberWithInt:0];
            
            if(self.isAwayTeam)
            {
                self.shotOnTargetCountAway++;
            } else {
                self.shotOnTargetCountHome++;
            }
          //  self.shotOnTargetProgressView.progress = [self getProgressValueWithAwayScore:self.shotOnTargetCountAway homeScore:self.shotOnTargetCountHome];
        }
        
        if([[event objectForKey:@"event_number"] isEqualToString:@"20"])//Shot on Goal
        {
            pointsReason = @"Shot on Goal";
            eventRevenue = [NSNumber numberWithInt:70];
            pointsCommited = [NSNumber numberWithInt:40];
            pointsCommitedAgainst = [NSNumber numberWithInt:0];
            
            if(self.isAwayTeam)
            {
                self.shotOffTargetCountAway++;
            } else {
                self.shotOffTargetCountHome++;
            }
        //    self.shotOffTargetProgressView.progress = [self getProgressValueWithAwayScore:self.shotOffTargetCountAway homeScore:self.shotOffTargetCountHome];
            
        }
        
        if([[event objectForKey:@"event_number"] isEqualToString:@"11"])//Goal
        {
            pointsReason = @"Goal";
            eventRevenue = [NSNumber numberWithInt:200];
            pointsCommited = [NSNumber numberWithInt:300];
            pointsCommitedAgainst = [NSNumber numberWithInt:0];
            NSLog(@"Goal eventRevenue: %@", eventRevenue);
        }
        
        if([[event objectForKey:@"event_number"] isEqualToString:@"7"])//Expulsion (Red Card)?
        {
            pointsReason = @"Expulsion";
            eventRevenue = [NSNumber numberWithInt:500];
            pointsCommited = [NSNumber numberWithInt:-100];
            pointsCommitedAgainst = [NSNumber numberWithInt:100];
        }
        
        if([[event objectForKey:@"event_number"] isEqualToString:@"2"])//Caution (Yellow Card)?
        {
            pointsReason = @"Caution";
            eventRevenue = [NSNumber numberWithInt:100];
            pointsCommited = [NSNumber numberWithInt:-25];
            pointsCommitedAgainst = [NSNumber numberWithInt:25];
            NSLog(@"Yellow Card eventRevenue: %@", eventRevenue);
        }
        
        if([[event objectForKey:@"event_number"] isEqualToString:@"8"])//Foul
        {
            pointsReason = @"Foul";
            eventRevenue = [NSNumber numberWithInt:20];
            pointsCommited = [NSNumber numberWithInt:-6];
            pointsCommitedAgainst = [NSNumber numberWithInt:6];
        }
        
        if([[event objectForKey:@"event_number"] isEqualToString:@"16"])//Offside
        {
            pointsReason = @"Offside";
            eventRevenue = [NSNumber numberWithInt:20];
            pointsCommited = [NSNumber numberWithInt:0];
            pointsCommitedAgainst = [NSNumber numberWithInt:-6];
        }
        
        if([[event objectForKey:@"event_number"] isEqualToString:@"28"])//Own Goal
        {
            pointsReason = @"Own Goal";
            eventRevenue = [NSNumber numberWithInt:1000];
            pointsCommited = [NSNumber numberWithInt:-200];
            pointsCommitedAgainst = [NSNumber numberWithInt:0];
        }
        
        //FIXME: Could be "Penalty Kick - No Good" too?
        if([[event objectForKey:@"event_number"] isEqualToString:@"17"])//Penalty Kick - Good
        {
            pointsReason = @"Penalty Kick - Good";
            eventRevenue = [NSNumber numberWithInt:500];
            pointsCommited = [NSNumber numberWithInt:-150];
            pointsCommitedAgainst = [NSNumber numberWithInt:100];
        }
        
        if([[event objectForKey:@"event_number"] isEqualToString:@"47"])//Throw-In
        {
            pointsReason = @"Throw-In";
            eventRevenue = [NSNumber numberWithInt:20];
            pointsCommited = [NSNumber numberWithInt:6];
            pointsCommitedAgainst = [NSNumber numberWithInt:0];
        }
        
        if([[event objectForKey:@"event_number"] isEqualToString:@"5"])//Corner Kick
        {
            pointsReason = @"Corner Kick";
            eventRevenue = [NSNumber numberWithInt:30];
            pointsCommited = [NSNumber numberWithInt:0];
            pointsCommitedAgainst = [NSNumber numberWithInt:0];
            
            if(self.isAwayTeam)
            {
                self.cornersCountAway++;
            } else {
                self.cornersCountHome++;
            }
         //   self.cornertsProgressView.progress = [self getProgressValueWithAwayScore:self.cornersCountAway homeScore:self.cornersCountHome];
        }
        
        if([[event objectForKey:@"event_number"] isEqualToString:@"46"])//Goal Kick
        {
            pointsReason = @"Goal Kick";
            eventRevenue = [NSNumber numberWithInt:20];
            pointsCommited = [NSNumber numberWithInt:0];
            pointsCommitedAgainst = [NSNumber numberWithInt:0];
        }
        
        if(![pointsReason isEqualToString:@""])
        {
            
            [[PlayerManager Instance]CheckForPointsWithName:[event objectForKey:@"offensive_player_first_name"] AndLastName:[event objectForKey:@"offensive_player_last_name"] AndPoints:[pointsCommited integerValue]];
            
            [self.playsTableData addObject:@{ @"time" : minutesStr, @"desc" : pointsReason, @"image" : @"Football.png" }];
            
            if([[event objectForKey:@"event_number"] isEqualToString:@"10"])//Game Over
            {
                [self.playsTableData addObject:@{ @"time" : minutesStr, @"desc" : @"Game Over", @"image" : @"Football.png" }];
                NSLog(@"event_number is 10. Game Over. Stop the timer");
                [self.timer invalidate];
                self.timer = nil;
            }
            [self.playsTable reloadData];
            
            //"zone":"Top\/Right","zone_id":"3"
            
            if(![[event objectForKey:@"x_coord"] isEqualToString:@"0"] || ![[event objectForKey:@"y_coord"] isEqualToString:@"0"])
            {
                //------------------Drawing event on the pitch------------------------
                //TODO: check these numbers
                float x = ([[event objectForKey:@"x_coord"] floatValue]*(310-7.5))/105;
                float y = ([[event objectForKey:@"y_coord"] floatValue]*(204-7.5))/70;
                //NSLog(@"y1 %f, y2 %f", [[event objectForKey:@"y_coord"] floatValue], y);
                //NSLog(@"x1 %f, x2 %f", [[event objectForKey:@"x_coord"] floatValue], x);
                
                eventNumber++;
                
                UIImageView *eventImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, 15, 15)];
                eventImageView.image = [UIImage imageNamed:@"EventOnPitch.png"];
                
                int eventLabelYOffset = 0;
                
                if(y < 13){
                    eventLabelYOffset = 13;
                }else{
                    eventLabelYOffset = -12;
                }
                
                UILabel *eventLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y + eventLabelYOffset, 50, 12)];
                eventLabel.textAlignment = NSTextAlignmentCenter;
                eventLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:12];
                eventLabel.textColor = [UIColor whiteColor];
                eventLabel.backgroundColor = [UIColor clearColor];
                eventLabel.text = pointsReason;
                
                
                //Display on the pitch
                
                if(eventNumber==1)
                {
                    NSLog(@"eventNumber 1");
                    eventImageView1 = eventImageView;
                    eventImageView1.alpha = 1.0f;
                    eventLabel1 = eventLabel;
                    eventLabel1.alpha = 1.0f;
                    [self.pitchView addSubview:eventImageView1];
                    [self.pitchView addSubview:eventLabel1];
                    
                } else if(eventNumber==2)
                {
                    NSLog(@"eventNumber 2");
                    eventImageView2 = eventImageView;
                    eventImageView2.alpha = 1.0f;
                    eventLabel2 = eventLabel;
                    eventLabel2.alpha = 1.0f;
                    
                    lineView1 = [[LineView alloc] initWithFrame:CGRectMake(0, 0, self.pitchView.frame.size.width, self.pitchView.frame.size.height)];
                    lineView1.alpha = 1.0f;
                    lineView1.startPoint = eventImageView1.center;
                    lineView1.finishPoint = eventImageView2.center;
                    [self.pitchView addSubview:eventImageView2];
                    [self.pitchView addSubview:eventLabel2];
                    [self.pitchView addSubview:lineView1];
                    
                } else if(eventNumber==3)
                {
                    NSLog(@"eventNumber 3");
                    eventImageView3 = eventImageView;
                    eventImageView3.alpha = 1.0f;
                    eventLabel3 = eventLabel;
                    eventLabel3.alpha = 1.0f;
                    lineView2 = [[LineView alloc] initWithFrame:CGRectMake(0, 0, self.pitchView.frame.size.width, self.pitchView.frame.size.height)];
                    lineView2.alpha = 1.0f;
                    lineView2.startPoint = eventImageView2.center;
                    lineView2.finishPoint = eventImageView3.center;
                    [UIView animateWithDuration:2.0f animations:^{
                        lineView1.alpha = 0.6f;
                        eventImageView1.alpha = 0.6f;
                        eventLabel1.alpha = 0.6f;
                    }];
                    [self.pitchView addSubview:eventImageView3];
                    [self.pitchView addSubview:eventLabel3];
                    [self.pitchView addSubview:lineView2];
                } else if(eventNumber==4)
                {
                    NSLog(@"eventNumber 4");
                    eventImageView4 = eventImageView;
                    eventImageView4.alpha = 1.0f;
                    eventLabel4 = eventLabel;
                    eventLabel4.alpha = 1.0f;
                    lineView3 = [[LineView alloc] initWithFrame:CGRectMake(0, 0, self.pitchView.frame.size.width, self.pitchView.frame.size.height)];
                    lineView3.alpha = 1.0f;
                    lineView3.startPoint = eventImageView3.center;
                    lineView3.finishPoint = eventImageView4.center;
                    
                    [self.pitchView addSubview:eventImageView4];
                    [self.pitchView addSubview:eventLabel4];
                    [self.pitchView addSubview:lineView3];
                    
                    [UIView animateWithDuration:2.0f animations:^{
                        lineView1.alpha = 0.0f;
                        eventImageView1.alpha = 0.0f;
                        eventLabel1.alpha = 0.0f;
                        
                        lineView2.alpha = 0.6f;
                        eventImageView2.alpha = 0.6f;
                        eventLabel2.alpha = 0.6f;
                    }];
                    
                } else {
                    NSLog(@"eventNumber 4+");
                    
                    //[eventImageView1 removeFromSuperview];
                    //[eventLabel1 removeFromSuperview];
                    //[lineView1 removeFromSuperview];
                    
                    eventLabel1 = eventLabel2;
                    eventLabel1.alpha = 0.6f;
                    eventImageView1 = eventImageView2;
                    eventImageView1.alpha = 0.6f;
                    
                    eventLabel2 = eventLabel3;
                    eventLabel2.alpha = 1.0f;
                    eventImageView2 = eventImageView3;
                    eventImageView2.alpha = 1.0f;
                    
                    [lineView1 removeFromSuperview];
                    lineView1 = nil;
                    lineView1 = [[LineView alloc] initWithFrame:CGRectMake(0, 0, self.pitchView.frame.size.width, self.pitchView.frame.size.height)];
                    lineView1.startPoint = eventImageView1.center;
                    lineView1.finishPoint = eventImageView2.center;
                    lineView1.alpha = 0.6f;
                    [self.pitchView addSubview:lineView1];
                    
                    eventLabel3 = eventLabel4;
                    eventLabel3.alpha = 1.0f;
                    eventImageView3 = eventImageView4;
                    eventImageView3.alpha = 1.0f;
                    
                    [lineView2 removeFromSuperview];
                    lineView2 = nil;
                    lineView2 = [[LineView alloc] initWithFrame:CGRectMake(0, 0, self.pitchView.frame.size.width, self.pitchView.frame.size.height)];
                    lineView2.alpha = 1.0f;
                    lineView2.startPoint = eventImageView2.center;
                    lineView2.finishPoint = eventImageView3.center;
                    [self.pitchView addSubview:lineView2];
                    
                    eventLabel4 = nil;
                    eventLabel4 = eventLabel;
                    eventLabel4.alpha = 1.0f;
                    eventImageView4 = nil;
                    eventImageView4 = eventImageView;
                    eventImageView4.alpha = 1.0f;
                    
                    [lineView3 removeFromSuperview];
                    lineView3 = nil;
                    lineView3 = [[LineView alloc] initWithFrame:CGRectMake(0, 0, self.pitchView.frame.size.width, self.pitchView.frame.size.height)];
                    lineView3.alpha = 1.0f;
                    lineView3.startPoint = eventImageView3.center;
                    lineView3.finishPoint = eventImageView4.center;
                    
                    //[eventImageView4 removeFromSuperview];
                    //[eventLabel4 removeFromSuperview];
                    //[lineView3 removeFromSuperview];
                    
                    [self.pitchView addSubview:eventImageView4];
                    [self.pitchView addSubview:eventLabel4];
                    [self.pitchView addSubview:lineView3];
                    
                    [UIView animateWithDuration:2.0f animations:^{
                        eventImageView1.alpha = 0.0f;
                        eventLabel1.alpha = 0.0f;
                        lineView1.alpha = 0.0f;
                        
                        eventImageView2.alpha = 0.6f;
                        eventLabel2.alpha = 0.6f;
                        lineView2.alpha = 0.6f;
                    }];
                }
                
                
            } else {
                NSLog(@"no coordinates %@, %@", [event objectForKey:@"x_coord"], [event objectForKey:@"y_coord"]);
            }
        }
        
        //FIXME: Tackle, Blocking, Interception, Defend Goal, Passing is missing
        
        
        //goal check start
        if([[event objectForKey:@"event_number"] isEqualToString:@"11"] || [[event objectForKey:@"event_number"] isEqualToString:@"28"])//goal or own goal
        {
            //is Away team?
            if(self.isAwayTeam)
            {
                self.awayScoreLabel.text = [[NSNumber numberWithInt:([self.awayScoreLabel.text intValue] + 1)] stringValue];
                [[NSUserDefaults standardUserDefaults] setObject:self.awayScoreLabel.text forKey:@"awayScore"];
            } else {
                self.homeScoreLabel.text = [[NSNumber numberWithInt:([self.homeScoreLabel.text intValue] + 1)] stringValue];
                [[NSUserDefaults standardUserDefaults] setObject:self.homeScoreLabel.text forKey:@"homeScore"];
            }
        }
    }
}

-(void)ReceiveEventData{
    
    NSNumber *offsetTimestamp;
    NSNumber *limitTimestamp;
    offsetTimestamp = [[NSUserDefaults standardUserDefaults] objectForKey:@"offsetTimestamp"];
    
    if(offsetTimestamp==nil){//if no previous time was saved, start from 0
        offsetTimestamp = [NSNumber numberWithInt:0];
        prevRequestSucceed = NO;
    } else if (prevRequestSucceed) {//only save the new time if we actually got data for the previous time
        offsetTimestamp = [NSNumber numberWithInt:([offsetTimestamp intValue]+60)];
    }
    [[NSUserDefaults standardUserDefaults] setObject:offsetTimestamp forKey:@"offsetTimestamp"];
    
    limitTimestamp = [[NSUserDefaults standardUserDefaults] objectForKey:@"limitTimestamp"];
    
    if(limitTimestamp==nil){//if no previous time was saved we only want the first minute
        limitTimestamp = [NSNumber numberWithInt:60];
    } else if (prevRequestSucceed) {
        limitTimestamp = [NSNumber numberWithInt:([limitTimestamp intValue]+60)];
    }
    [[NSUserDefaults standardUserDefaults] setObject:limitTimestamp forKey:@"limitTimestamp"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[ConnectionManager Instance]GetEventsWithMatchID:1 AndOffsetTimestamp:[offsetTimestamp integerValue] AndLimitTimestamp:[limitTimestamp integerValue]];
}

-(void)EventDataReceived{
    
    prevRequestSucceed = YES;
    NSDictionary *eventsDictionary = [[ConnectionManager Instance]GetJSONDictionaryFromTag:Events];
    NSMutableArray *events = [eventsDictionary valueForKey:@"events"];
    
    if(events != nil)
    {
        NSNumber *limitTimestamp = [[NSUserDefaults standardUserDefaults] objectForKey:@"limitTimestamp"];
        NSNumber *gameMinutes = [NSNumber numberWithInt:([limitTimestamp intValue]/60)];
        self.gameMinutesLabel.text = [NSString stringWithFormat:@"%@ min", gameMinutes];
        [[NSUserDefaults standardUserDefaults] setObject:self.gameMinutesLabel.text forKey:@"gameMinutes"];
        
        
        if(self.timeDateTimer==nil)
        {
            self.timeDateTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                  target:self
                                                                selector:@selector(timeDateTimerFireMethod:)
                                                                userInfo:nil
                                                                 repeats:YES];
        }
        
        NSMutableDictionary *mEvent = [[NSMutableDictionary alloc] init];
        NSMutableArray *events = [eventsDictionary valueForKey:@"events"];
        for (NSDictionary *event in events)
        {
            //"minutes":"1","seconds":"0",
            //"minutes":"18","seconds":"4"
            //"minutes":"90","seconds":"37"
            [mEvent setObject:event forKey:[NSString stringWithFormat:@"%@:%@", [event objectForKey:@"minutes"], [event objectForKey:@"seconds"]] ];
            
            //NSLog(@"event %@", [NSString stringWithFormat:@"%@:%@", [event objectForKey:@"minutes"], [event objectForKey:@"seconds"]] );
            
        }
        self.events = [mEvent copy];
        
    }else {
        NSLog(@"event is nil. Stop the timer");
        [self.timer invalidate];
        self.timer = nil;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
