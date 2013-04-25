//
//  FriendsListViewController.m
//  PitchFeudV2
//
//  Created by Rune on 11/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "FriendsListViewController.h"
#import "ECSlidingViewController.h"

@interface FriendsListViewController ()

@end

@implementation FriendsListViewController

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
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"menuScroll2"]];
}

- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers {
	return NO;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
    for (NSUInteger i = 0; i < [self.childViewControllers count]; i++) {
		[self loadScrollViewWithPage:i];
	}
	
	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height * [self.childViewControllers count] );
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
        frame.origin.y = frame.size.height * page;
        frame.origin.x = 0;
        controller.view.frame = frame;
        [self.scrollView addSubview:controller.view];
    }
}

- (IBAction)navBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goToFriends:(id)sender
{
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"friendsView"];
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
