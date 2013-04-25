//
//  LeagueViewController.h
//  PitchFeudV2
//
//  Created by Rune on 12/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeagueViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

- (IBAction)revealMenu:(id)sender;
- (IBAction)revealChat:(id)sender;

@end
