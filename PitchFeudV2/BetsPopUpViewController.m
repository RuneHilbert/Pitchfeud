//
//  BetsPopUpViewController.m
//  PitchFeudV2
//
//  Created by Rune on 15/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "BetsPopUpViewController.h"

@interface BetsPopUpViewController ()

@end

@implementation BetsPopUpViewController

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

- (IBAction)removeFromView:(id)sender
{
        [UIView animateWithDuration:0.2 animations:^{
            
            CGRect frame = self.view.frame;
            frame.origin.y = self.view.frame.size.height;
            self.view.frame = frame;
            
        }completion:^(BOOL finished){
            
            [self.view removeFromSuperview];
        }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
