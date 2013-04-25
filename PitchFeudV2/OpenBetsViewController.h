//
//  OpenBetsViewController.h
//  PitchFeudV2
//
//  Created by Rune on 15/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BetsPopUpViewController.h"


@interface OpenBetsViewController : UIViewController

@property (nonatomic, strong) BetsPopUpViewController *popUpView;

-(IBAction)showPopUp:(id)sender;
-(IBAction)modalBack:(id)sender;

@end
