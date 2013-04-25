//
//  CreateBetViewController.m
//  PitchFeudV2
//
//  Created by Rune on 15/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "CreateBetViewController.h"

@interface CreateBetViewController ()

@end

@implementation CreateBetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)modalBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
