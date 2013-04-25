//
//  Player.h
//  PitchFeudV2
//
//  Created by Michael Godlowski-Maryniak on 02/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *playerImage;
@property (nonatomic, strong) UIButton *playerButton;
@property (nonatomic, strong) NSString *firstName, *lastName, *shirtName;
@property (assign) NSInteger teamId, playerId, price, cashGenerated;
@property (assign) BOOL bought;
@property (assign) CGPoint positionInView;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end
