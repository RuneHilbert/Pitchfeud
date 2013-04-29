//
//  PlayersViewController.h
//  PitchFeudV2
//
//  Created by Michael Godlowski-Maryniak on 25/03/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PlayerManager.h"
#import "GameManager.h"
#import "BuyPlayersViewController.h"
#import "MainViewController.h"

@interface PlayersViewController : UIViewController<UIAlertViewDelegate, UIGestureRecognizerDelegate>{
    
    BOOL buyPlayerViewIsUp;
    BOOL isDraggingPlayer;
    Player *currentPlayer;
    CGRect currentPlayerCenter;
    CGPoint _priorPoint;
    CGPoint buyPointLocation;
    UIImageView *playerClone;
}

@property (nonatomic, strong) IBOutlet UILabel *pointsLabel, *scoreLabel, *bankLabel;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollViewParent;
@property (nonatomic, strong) BuyPlayersViewController *buyPlayersView;
@property (nonatomic, strong) NSMutableArray *playerDropableLocations;
-(IBAction)ShowBuyPlayer:(id)sender;
@end
