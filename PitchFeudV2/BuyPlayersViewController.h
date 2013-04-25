//
//  BuyPlayersViewController.h
//  PitchFeudV2
//
//  Created by Rune on 27/03/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PlayerManager.h"

@interface BuyPlayersViewController : UIViewController{
    
    CABasicAnimation *anim;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *playerPositions;

-(CGPoint)FindCenterPointInBuyView:(Player*)p;
- (IBAction)removeFromView:(id)sender;
- (IBAction)modalBack:(id)sender;
-(IBAction)DoneBuying:(id)sender;

@end
