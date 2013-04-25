//
//  MainViewController.h
//  PitchFeudV2
//
//  Created by Rune Hilbert on 22/03/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerManager.h"
@interface MainViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

- (IBAction)revealMenu:(id)sender;
- (IBAction)revealChat:(id)sender;

@end