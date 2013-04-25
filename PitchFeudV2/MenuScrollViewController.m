//
//  MenuScrollViewController.m
//  PitchFeudV2
//
//  Created by Rune on 11/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "MenuScrollViewController.h"
#import "ECSlidingViewController.h"

@interface MenuScrollViewController ()

@end

@implementation MenuScrollViewController

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

- (IBAction)goToMain:(id)sender
{
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];}];
}

- (IBAction)goToBets:(id)sender
{
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"betsView"];
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];}];
}

- (IBAction)goToFriends:(id)sender
{
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"friendsView"];
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];}];
}

- (IBAction)goToShop:(id)sender
{
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"shopView"];
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];}];
}

- (IBAction)goToMatches:(id)sender
{
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"matchesView"];
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];}];
}

- (IBAction)goToLeagues:(id)sender
{
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leaguesView"];
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];}];
}

- (IBAction)goToLeaderboards:(id)sender
{
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leaderboardsView"];
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
