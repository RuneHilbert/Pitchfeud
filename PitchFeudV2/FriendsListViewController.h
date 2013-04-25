//
//  FriendsListViewController.h
//  PitchFeudV2
//
//  Created by Rune on 11/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsListViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

- (IBAction)navBack:(id)sender;
- (IBAction)goToFriends:(id)sender;

@end
