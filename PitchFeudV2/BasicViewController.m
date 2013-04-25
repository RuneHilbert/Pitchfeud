//
//  BasicViewController.m
//  PitchFeudV2
//
//  Created by Rune Hilbert on 23/03/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "BasicViewController.h"
#import "ECSlidingViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

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

- (IBAction)navBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)modalBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)removeFromView:(id)sender
{
    [self.view removeFromSuperview];
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)revealChat:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECLeft];
}

- (IBAction)goToMain:(id)sender
{
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView]
       ;}];
    
    //This is done because it for some reason doesn't want to reset it from above. Feel free to fix.
    [self.slidingViewController resetTopView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

