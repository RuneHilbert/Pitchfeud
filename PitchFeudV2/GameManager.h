//
//  GameManager.h
//  PitchFeudV2
//
//  Created by Michael Godlowski-Maryniak on 29/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameManager : NSObject

@property NSInteger Bank;

+(GameManager*)Instance;
-(void)StartNewMatch;
@end
