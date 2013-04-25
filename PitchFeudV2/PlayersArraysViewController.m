//
//  PlayersArraysViewController.m
//  PitchFeudV2
//
//  Created by Rune on 27/03/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "PlayersArraysViewController.h"

@interface PlayersArraysViewController ()

@end

@implementation PlayersArraysViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        for(UIView *view in self.view.subviews){
            
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
    }
    return self;
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
