;//
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
        
        for(int i = 0; i < 51; i++){
            
            [self.allTeams addObject:[NSNull null]];
            
        }
        
        self.homeTeam = [[NSMutableArray alloc]init];
        self.awayTeam = [[NSMutableArray alloc]init];
        /*
        self.homeTeam = [[NSMutableArray alloc]init];
        self.awayTeam = [[NSMutableArray alloc]init];
        
        for(int i = 0; i < 51; i++){
            
            [self.allTeams addObject:[NSNull null]];
            
        }
        
        for(int i = 0; i < 25; i++){
            
            Player *testPlayer = [[Player alloc]init];
            testPlayer.playerImage.tag = i;
            testPlayer.price = 100;
            [self.allTeams replaceObjectAtIndex:i withObject:testPlayer];
            
        }
        
        for(int i = 26; i < 51; i++){
            
            Player *testPlayer = [[Player alloc]init];
            testPlayer.playerImage.tag = i;
            testPlayer.price = 200;
            [self.allTeams replaceObjectAtIndex:i withObject:testPlayer];
        }
        */
        
        
        NSMutableArray *players = [[NSMutableArray alloc]initWithObjects:
                                   [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"John",@"firstName",
                                    @"Johnson",@"lastName",
                                    @"team 1", @"team",
                                    [NSNumber numberWithInteger:1], @"PlayerNumber",
                                    [NSNumber numberWithBool:YES], @"isHome",  nil]
                                   ,
                                   [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"John2",@"firstName",
                                      @"Johnson",@"lastName",
                                      @"team 1", @"team",
                                      [NSNumber numberWithInteger:2], @"PlayerNumber",
                                      [NSNumber numberWithBool:YES], @"isHome",  nil]
                                   ,
                                   [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"John3",@"firstName",
                                    @"Johnson",@"lastName",
                                    @"team 1", @"team",
                                    [NSNumber numberWithInteger:3], @"PlayerNumber",
                                    [NSNumber numberWithBool:YES], @"isHome",  nil]
                                   ,
                                   [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"John",@"firstName",
                                    @"Johnson",@"lastName",
                                    @"team 1", @"team",
                                    [NSNumber numberWithInteger:6], @"PlayerNumber",
                                    [NSNumber numberWithBool:NO], @"isHome",  nil]
                                   ,
                                   nil];
     
       
        for(NSDictionary *p in players){
            
            /*
             NSInteger index = [[p objectForKey:@"PlayerNumber"]integerValue] - 1;
             
             if(![[p objectForKey:@"isHome"]boolValue]){
             
             index += 25;
             }
             Player *newPlayer = [[Player alloc]initWithJSON:p];
             [self.allTeams replaceObjectAtIndex:index withObject: newPlayer];
             */
        
        if([[p objectForKey:@"isHome"]boolValue]){
            
            [self.homeTeam addObject:[[Player alloc]initWithJSON:p]];
            
        }else{
            
            [self.awayTeam addObject:[[Player alloc]initWithJSON:p]];
        }
    }
    
    NSArray *sortedArrayHome;
    sortedArrayHome = [self.homeTeam sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        
        NSNumber *playerNumber1 = [NSNumber numberWithInteger:[(Player*)a playerNumber]];
        NSNumber *playerNumber2 = [NSNumber numberWithInteger:[(Player*)b playerNumber]];
        
        return [playerNumber1 compare:playerNumber2];
    }];
    
    NSArray *sortedArrayAway;
    sortedArrayAway = [self.homeTeam sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        
        NSNumber *playerNumber1 = [NSNumber numberWithInteger:[(Player*)a playerNumber]];
        NSNumber *playerNumber2 = [NSNumber numberWithInteger:[(Player*)b playerNumber]];
        
        return [playerNumber1 compare:playerNumber2];
    }];
    
    
    for(int i = 0; i < self.homeTeam.count; i++){
        
        ((Player*)[self.homeTeam objectAtIndex:i]).playerImage.tag = i;
    }
    
    for(int i = 0; i < self.awayTeam.count; i++){
        
        ((Player*)[self.awayTeam objectAtIndex:i]).playerImage.tag = i + 26;
    }
    
    NSArray *sortedArrayAll = [self.homeTeam arrayByAddingObjectsFromArray:self.awayTeam];
    
    for(Player *p in sortedArrayAll){
        
        [self.allTeams replaceObjectAtIndex:p.playerImage.tag withObject: p];
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



@end
