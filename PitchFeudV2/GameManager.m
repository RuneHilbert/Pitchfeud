//
//  GameManager.m
//  PitchFeudV2
//
//  Created by Michael Godlowski-Maryniak on 29/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "GameManager.h"

@implementation GameManager

static GameManager *instance = nil;

+(GameManager*)Instance{
    
    @synchronized(self){
        
        if(instance == nil){
            instance = [[self alloc]init];
        }
    }
    
    return instance;
}

-(NSInteger)Bank{
    
    return [[[NSUserDefaults standardUserDefaults]valueForKey:@"Bank"]integerValue];
}

-(void)setBank:(NSInteger)newBankValue{
    
    [[NSUserDefaults standardUserDefaults]setInteger:newBankValue forKey:@"Bank"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(void)StartNewMatch{
    
    self.Bank = 1000;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NewMatchStarted" object:nil];
}


@end
