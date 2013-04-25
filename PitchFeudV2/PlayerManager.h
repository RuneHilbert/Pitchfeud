//
//  PlayerManager.h
//  PitchFeudV2
//
//  Created by Michael Godlowski-Maryniak on 25/03/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface PlayerManager : NSObject

@property (nonatomic, strong) NSMutableArray *allTeams;
@property (nonatomic, strong) NSMutableArray *homeTeam;
@property (nonatomic, strong) NSMutableArray *awayTeam;
@property (assign) NSInteger points;
@property (nonatomic, strong) UIView *playersView;

+(PlayerManager*)Instance;
-(void)CheckForPointsWithName:(NSString*)playerFirstName AndLastName:(NSString*)playerLastName AndPoints:(NSInteger) points;
@end
