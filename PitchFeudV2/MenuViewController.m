//
//  MenuViewController.m
//  PitchFeudV2
//
//  Created by Rune on 08/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "MenuViewController.h"
#import "ECSlidingViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize scrollView = _scrollView;

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
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"menuScroll"]];
}

- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers {
	return NO;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
    for (NSUInteger i = 0; i < [self.childViewControllers count]; i++) {
		[self loadScrollViewWithPage:i];
	}
	
	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 715);
}

- (void)loadScrollViewWithPage:(NSInteger)page {
    if (page < 0)
        return;
    if (page >= [self.childViewControllers count])
        return;
    
	// replace the placeholder if necessary
    UIViewController *controller = [self.childViewControllers objectAtIndex:page];
    if (controller == nil) {
		return;
    }
	
	// add the controller's view to the scroll view
    if (controller.view.superview == nil) {
        CGRect frame = self.scrollView.frame;
        frame.size.height = 715;
        frame.origin.y = frame.size.height * page;
        frame.origin.x = 0;
        controller.view.frame = frame;
        [self.scrollView addSubview:controller.view];
    }
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

- (IBAction)navBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
