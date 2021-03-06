//
//  Player.m
//  PitchFeudV2
//
//  Created by Michael Godlowski-Maryniak on 02/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize playerImage = _playerImage, firstName = _firstName, lastName = _lastName, team = _team, playerNumber = _playerNumber, bought = _bought, positionInView = _positionInView;


-(id) init{
    
    if(self = [super init]){
        
        
    }
    
    return self;
}

-(id) initWithJSON:(NSDictionary*)JSONdictioary{
    
    if(self = [super init]){
        
        self.firstName = [JSONdictioary objectForKey:@"firstName"];
        self.lastName = [JSONdictioary objectForKey:@"lastName"];
        self.team = [JSONdictioary objectForKey:@"team"];
        self.playerNumber = [[JSONdictioary objectForKey:@"PlayerNumber"]integerValue];
        self.bought = NO;
        self.playerImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PlayerBWBlack.png"]];
        self.price = 100;
        
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
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.playerImage.frame.size.height - 15, self.playerImage.frame.size.width, 15)];
        nameLabel.text = self.lastName;
        [nameLabel setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f]];
        [nameLabel setTextColor:[UIColor whiteColor]];
        [nameLabel setFont: [UIFont fontWithName:@"Arial" size:12.0]];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.playerImage.frame.size.width/4, 15)];
        numberLabel.text = [NSString stringWithFormat:@"%d", self.playerNumber];
        [numberLabel setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f]];
        [numberLabel setTextColor:[UIColor whiteColor]];
        [numberLabel setFont: [UIFont fontWithName:@"Arial" size:14.0]];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.playerImage addSubview:nameLabel];
        [self.playerImage addSubview:numberLabel];
        
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
    self.playerImage.transform = CGAffineTransformMakeRotation(M_PI_2);
    
}

// Delegate method - return YES to allow 2 different gesture recognizers at once
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}



@end
