//
//  BuyPlayersViewController.m
//  PitchFeudV2
//
//  Created by Rune on 27/03/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

// loll
//jdklsjfksdjfælksdjfjkjhk
#import "BuyPlayersViewController.h"

@interface BuyPlayersViewController ()

@end

@implementation BuyPlayersViewController

@synthesize scrollView = _scrollView, playerPositions = _playerPositions;

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
	[self.scrollView setScrollEnabled:YES];
	[self.scrollView setShowsHorizontalScrollIndicator:NO];
	[self.scrollView setShowsVerticalScrollIndicator:NO];
    
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"players1"]];
    self.playerPositions = [[NSMutableArray alloc]initWithCapacity:100];
    
    for(int i = 0; i < 100; i++){
        
        [self.playerPositions addObject:[[Player alloc]init]];
    }
}

- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers {
	return NO;
}

-(IBAction)DoneBuying:(id)sender{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"HideBuyPlayer" object:nil];
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    for (NSUInteger i = 0; i < [self.childViewControllers count]; i++) {
		[self loadScrollViewWithPage:i];
	}
	
	self.scrollView.contentSize = CGSizeMake(2275, self.scrollView.frame.size.height );
    
    
    for(Player *p in [PlayerManager Instance].allTeams){
        
        if(p == (Player*)[NSNull null] || p.bought)continue;
        
        p.playerImage.center = [self FindCenterPointInBuyView:p];
        [self.scrollView addSubview:p.playerImage];
        [self.scrollView bringSubviewToFront: p.playerImage];
        
    }
    /*
    for(Player *p in [PlayerManager Instance].homeTeam){
        
        if(p.bought)break;
 
        p.playerImage.center = [self FindCenterPointInBuyView:p IsHomeTeam:YES];
        [self.scrollView addSubview:p.playerImage];
        [self.scrollView bringSubviewToFront: p.playerImage];
    }
    
    for(Player *p in [PlayerManager Instance].awayTeam){
        
        if(p.bought)break;
        
        p.playerImage.center = [self FindCenterPointInBuyView:p IsHomeTeam:NO];
        [self.scrollView addSubview:p.playerImage];
        [self.scrollView bringSubviewToFront: p.playerImage];
    }
    */
}

-(CGPoint)FindCenterPointInBuyView:(Player*)p{
    
    BOOL isHome = p.playerImage.tag < 26;
    
    int marginX = 50;
    int marginY = 0;
    //int totalWidth = 0;
    
    CGPoint centerPoint; //[[self.playerPositions objectAtIndex:p.playerImage.tag]CGPointValue];
    centerPoint.y = p.playerImage.frame.size.height/2 + marginY;
    
    if(!isHome){
        centerPoint.x = marginX + (p.playerImage.frame.size.width + 5) * (p.playerImage.tag - 26);
        centerPoint.y += p.playerImage.frame.size.height;
    }else{
        
        centerPoint.x = marginX + (p.playerImage.frame.size.width + 5) * p.playerImage.tag;
    }
    
    return centerPoint;
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
        frame.size.width = 2275;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [self.scrollView addSubview:controller.view];
        
        for(UIView *view in controller.view.subviews){
            
            CGPoint centerPoint = view.center;
            CGRect frame = view.frame;
            [self.playerPositions replaceObjectAtIndex:view.tag withObject:[NSValue valueWithCGPoint:centerPoint]];
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)removeFromView:(id)sender
{
    [self.view removeFromSuperview];
}

- (IBAction)modalBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
