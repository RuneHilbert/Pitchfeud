//
//  MainViewController.m
//  PitchFeudV2
//
//  Created by Rune Hilbert on 22/03/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "MainViewController.h"
#import "ECSlidingViewController.h"
#import "MenuNavViewController.h"
#import "ChatNavViewController.h"
#import "ConnectionManager.h"

@interface MainViewController ()
@end
@implementation MainViewController

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
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuNavViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"navigationMenu"];
    }
    
    if (![self.slidingViewController.underRightViewController isKindOfClass:[ChatNavViewController class]]) {
        self.slidingViewController.underRightViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"navigationChat"];
    }
    
    [self.scrollView setPagingEnabled:YES];
	[self.scrollView setScrollEnabled:YES];
	[self.scrollView setShowsHorizontalScrollIndicator:NO];
	[self.scrollView setShowsVerticalScrollIndicator:NO];
    
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"mainPlayersScroll"]];
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"mainBetsScroll"]];
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"mainPitchScroll"]];
    
    
}


- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers {
	return NO;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
    for (NSUInteger i = 0; i < [self.childViewControllers count]; i++) {
		[self loadScrollViewWithPage:i];
	}
	
	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [self.childViewControllers count], self.scrollView.frame.size.height );
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
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [self.scrollView addSubview:controller.view];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)revealChat:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECLeft];
}


@end
