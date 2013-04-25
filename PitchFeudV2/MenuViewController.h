//
//  MenuViewController.h
//  PitchFeudV2
//
//  Created by Rune on 08/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

- (IBAction)goToMain:(id)sender;
- (IBAction)goToBets:(id)sender;
- (IBAction)goToFriends:(id)sender;
- (IBAction)goToMatches:(id)sender;
- (IBAction)goToLeagues:(id)sender;
- (IBAction)goToLeaderboards:(id)sender;


- (IBAction)navBack:(id)sender;


@end
