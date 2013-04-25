//
//  ChatNavViewController.m
//  PitchFeudV2
//
//  Created by Rune Hilbert on 23/03/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "ChatNavViewController.h"
#import "ECSlidingViewController.h"

@interface ChatNavViewController ()

@end

@implementation ChatNavViewController

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
    [self.slidingViewController setAnchorLeftRevealAmount:270.0f];
    self.slidingViewController.underRightWidthLayout = ECFullWidth;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
