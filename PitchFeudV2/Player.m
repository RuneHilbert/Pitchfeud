//
//  Player.m
//  PitchFeudV2
//
//  Created by Michael Godlowski-Maryniak on 02/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize playerImage = _playerImage, firstName = _firstName, lastName = _lastName, shirtName = _shirtName, teamId = _teamId, playerId = _playerId, price = _price, cashGenerated = _cashGenerated, bought = _bought, positionInView = _positionInView;

// Jeg ville hellere danse....så dans :)...........

-(id) init{
    
    if(self = [super init]){
        
        self.playerImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PlayerBWBlack.png"]];
        
        //Under construction...
        /*
         
         [player setObject:@"28" forKey:@"team_id"];
         [player setObject:@"33963" forKey:@"player_id"];
         [player setObject:@"Leighton" forKey:@"first_name"];
         [player setObject:@"Baines" forKey:@"last_name"];
         [player setObject:@"Baines" forKey:@"shirt_name"];
         [player setObject:@"1" forKey:@"price"];
         [player setObject:@"PlayerCampbell.png" forKey:@"image"];
         
         [player setObject:@"0" forKey:@"cashGenerated"];
         [player setObject:[player objectForKey:@"price"] forKey:@"currentScore"];
         */
        
        //TEST - later set gestures on all players
        
        self.playerImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PlayerBWBlack"]];
        CGRect frame = self.playerImage.frame;
        frame.size.height = frame.size.height / 2;
        frame.size.width = frame.size.width / 2;
        self.playerImage.frame = frame;
        self.playerImage.userInteractionEnabled = YES;
        
        /*
         self.panGesture = [[UIPanGestureRecognizer alloc] init];
         [self.panGesture setMaximumNumberOfTouches:2];
         //[self.playerImage addGestureRecognizer:self.panGesture];
         */
        
        self.longPressGesture = [[UILongPressGestureRecognizer alloc] init];
        [self.longPressGesture setMinimumPressDuration:0.08];
        [self.playerImage addGestureRecognizer:self.longPressGesture];
        
        self.tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShowInfo:)];
        [self.tapGesture setNumberOfTapsRequired:1];
        [self.tapGesture setNumberOfTouchesRequired:1];
        [self.playerImage addGestureRecognizer:self.tapGesture];
        
    }
    
    return self;
}

-(void)ShowInfo:(UITapGestureRecognizer *)gestureRecognizer{
    
    
    NSLog(@"INFO");
    
}

// Delegate method - return YES to allow 2 different gesture recognizers at once
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}

-(void)SetDelegateForGestures:(id<UIGestureRecognizerDelegate>)delegate
{
    
    
    
}


@end
