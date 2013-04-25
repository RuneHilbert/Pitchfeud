//
//  BetsViewController.m
//  PitchFeudV2
//
//  Created by Rune on 08/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "BetsViewController.h"

@interface BetsViewController ()

@end

@implementation BetsViewController
@synthesize popularView = _popularView, latestView = _latestView, highrollerView = _highrollerView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)revealChat:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECLeft];
}

- (IBAction)showPopularView:(id)sender
{
    [self.view bringSubviewToFront:_popularView];
}

- (IBAction)showLatestView:(id)sender
{
    [self.view bringSubviewToFront:_highrollerView];
}

- (IBAction)showHighrollerView:(id)sender
{
    [self.view bringSubviewToFront:_latestView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
