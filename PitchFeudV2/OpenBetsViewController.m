//
//  OpenBetsViewController.m
//  PitchFeudV2
//
//  Created by Rune on 15/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "OpenBetsViewController.h"

@interface OpenBetsViewController ()

@end

@implementation OpenBetsViewController
@synthesize popUpView = _popUpView;


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

-(IBAction)showPopUp:(id)sender{
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        self.popUpView = [storyboard instantiateViewControllerWithIdentifier:@"betsPopUp"];
        
        CGRect frame = self.popUpView.view.frame;
        frame.origin.y = self.view.frame.size.height;
        self.popUpView.view.frame = frame;
        [self.view addSubview:self.popUpView.view];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            CGRect frame = self.popUpView.view.frame;
            frame.origin.y = 0;
            self.popUpView.view.frame = frame;
            
        }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
