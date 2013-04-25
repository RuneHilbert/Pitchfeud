//
//  PitchViewController.h
//  PitchFeudV2
//
//  Created by Michael Godlowski-Maryniak on 24/03/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionManager.h"
#import "PlayerManager.h"
#import "LineView.h"

@interface PitchViewController : UIViewController{
    
    NSNumber *offsetTimestamp;
    NSNumber *limitTimestamp;
}

@property (nonatomic, strong) IBOutlet UIView *pitchView;
@property (nonatomic, strong) IBOutlet UIView *statsView;
@property (nonatomic, strong) IBOutlet UIView *playsView;

@property (nonatomic, strong) IBOutlet UIButton *pitchButton;
@property (nonatomic, strong) IBOutlet UIButton *statsButton;
@property (nonatomic, strong) IBOutlet UIButton *playsButton;

@property (strong, nonatomic) IBOutlet UILabel *gameMinutesLabel;//Starts in 1h 12min

@property (strong, nonatomic) IBOutlet UILabel *tokensLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) IBOutlet UILabel *homeScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *homeCountryLabel;
@property (strong, nonatomic) IBOutlet UILabel *awayScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *awayCountryLabel;

@property (strong, nonatomic) IBOutlet UITableView *playsTable;

@property (strong, nonatomic) IBOutlet UIProgressView *ballPossessionProgressView;
@property (strong, nonatomic) IBOutlet UILabel *ballPossessionHomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *ballPossessionAwayLabel;

@property (strong, nonatomic) IBOutlet UIProgressView *shotOffTargetProgressView;
@property (strong, nonatomic) IBOutlet UILabel *shotOffTargetHomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *shotOffTargetAwayLabel;

@property (strong, nonatomic) IBOutlet UIProgressView *shotOnTargetProgressView;
@property (strong, nonatomic) IBOutlet UILabel *shotOnTargetHomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *shotOnTargetAwayLabel;

@property (strong, nonatomic) IBOutlet UIProgressView *cornertsProgressView;
@property (strong, nonatomic) IBOutlet UILabel *cornertsHomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *cornertsAwayLabel;

- (void)fetchFeedData;
- (float)getProgressValueWithAwayScore:(int)awayScore_ homeScore:(int)homeScore_;

@end
