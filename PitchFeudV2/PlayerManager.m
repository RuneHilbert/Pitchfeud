//
//  PlayerManager.m
//  PitchFeudV2
//
//  Created by Michael Godlowski-Maryniak on 25/03/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "PlayerManager.h"

@implementation PlayerManager

@synthesize allTeams = _allTeams, homeTeam = _homeTeam, awayTeam = _awayTeam, points = _points, playersView = _playersView;

static PlayerManager *instance = nil;

+(PlayerManager*)Instance{
    
    @synchronized(self){
        
        if(instance == nil){
            instance = [[self alloc]initWithVariables];
        }
    }
    
    return instance;
}

-(id)initWithVariables{
    
    if (self = [super init]){
        
        self.allTeams = [[NSMutableArray alloc]init];
        self.homeTeam = [[NSMutableArray alloc]init];
        self.awayTeam = [[NSMutableArray alloc]init];
        
        for(int i = 0; i < 51; i++){
            
            [self.allTeams addObject:[NSNull null]];
            
        }
        
        for(int i = 0; i < 25; i++){
            
            Player *testPlayer = [[Player alloc]init];
            testPlayer.playerImage.tag = i;
            [self.allTeams replaceObjectAtIndex:i withObject:testPlayer];
            
        }
        
        for(int i = 26; i < 51; i++){
            
            Player *testPlayer = [[Player alloc]init];
            testPlayer.playerImage.tag = i;
            [self.allTeams replaceObjectAtIndex:i withObject:testPlayer];
        }
        
        /*
        NSMutableDictionary *player = [[NSMutableDictionary alloc]init];
        
        [player setObject:@"28" forKey:@"team_id"];
        [player setObject:@"33963" forKey:@"player_id"];
        [player setObject:@"Leighton" forKey:@"first_name"];
        [player setObject:@"Baines" forKey:@"last_name"];
        [player setObject:@"Baines" forKey:@"shirt_name"];
        [player setObject:@"1" forKey:@"price"];
        [player setObject:@"PlayerCampbell.png" forKey:@"image"];
        
        [player setObject:@"0" forKey:@"cashGenerated"];
        [player setObject:[player objectForKey:@"price"] forKey:@"currentScore"];
        [self.myPlayers addObject:[player copy]];
        */
        
    }
    
    return self;
}

-(void)CheckForPointsWithName:(NSString*)playerFirstName AndLastName:(NSString*)playerLastName AndPoints:(NSInteger) points{
    
    if(playerFirstName != nil && playerLastName != nil){
        
        for(NSMutableDictionary *player in self.homeTeam){
            
            NSString *firstName = [player valueForKey:@"first_name"];
            NSString *lastName = [player valueForKey:@"last_name"];
            
            
            if([firstName isEqualToString:playerFirstName] && [lastName isEqualToString:playerLastName]){
                
                self.points += points;
                NSLog(@"Got %d points", points);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdatePointsLabel" object:self];
                
                break;
            }
            
            NSLog(@"Player not bought!");
        }
    }else{
        
        NSLog(@"Player is nil!");
    }
}


@end
