//
//  BetsViewController.h
//  PitchFeudV2
//
//  Created by Rune on 08/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "ECSlidingViewController.h"

@interface BetsViewController : ECSlidingViewController

@property (nonatomic, strong) IBOutlet UIView *latestView;
@property (nonatomic, strong) IBOutlet UIView *highrollerView;
@property (nonatomic, strong) IBOutlet UIView *popularView;

- (IBAction)revealMenu:(id)sender;
- (IBAction)revealChat:(id)sender;
- (IBAction)showPopularView:(id)sender;
- (IBAction)showLatestView:(id)sender;
- (IBAction)showHighrollerView:(id)sender;

@end
