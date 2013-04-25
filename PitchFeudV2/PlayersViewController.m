//
//  PlayersViewController.m
//  PitchFeudV2
//
//  Created by Michael Godlowski-Maryniak on 25/03/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "PlayersViewController.h"

@interface PlayersViewController ()

@end

@implementation PlayersViewController
@synthesize pointsLabel = _pointsLabel, buyPlayersView = _buyPlayersView, playerDropableLocations = _playerDropableLocations;


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
    
    buyPlayerViewIsUp = NO;
    self.playerDropableLocations = [[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdatePointsLabel) name:@"UpdatePointsLabel"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HideBuyPlayer) name:@"HideBuyPlayer"  object:nil];
    
    [PlayerManager Instance]; //load in players
    
    //Assign gesture recognizer to all players
    for(Player *p in [PlayerManager Instance].allTeams){
        
        if(p != (Player*)[NSNull null]){
            [p.longPressGesture addTarget:self action:@selector(StartEndTouch:)];
        }
        
    }
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    
    
}

-(IBAction)ShowBuyPlayer:(id)sender{
    
    if(!buyPlayerViewIsUp){
        
        buyPlayerViewIsUp = YES;
        MainViewController *mv = (MainViewController*)[self parentViewController];
        mv.scrollView.scrollEnabled = NO;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        self.buyPlayersView = [storyboard instantiateViewControllerWithIdentifier:@"BuyPlayer"];
        
        //Get the dropable rects from subviews
        for(UIView *view in self.view.subviews){
            
            if(view.tag == 100){
                [self.playerDropableLocations addObject:[NSValue valueWithCGRect:view.frame]];
            }
        }
        
        CGRect frame = self.buyPlayersView.view.frame;
        frame.origin.y = self.view.frame.size.height;
        self.buyPlayersView.view.frame = frame;
        [self.view addSubview:self.buyPlayersView.view];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            CGRect frame = self.buyPlayersView.view.frame;
            frame.origin.y = self.view.frame.size.height - 170;
            self.buyPlayersView.view.frame = frame;
            
        }];
    }
}

-(void)HideBuyPlayer{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGRect frame = self.buyPlayersView.view.frame;
        frame.origin.y = self.view.frame.size.height;
        self.buyPlayersView.view.frame = frame;
        
    }completion:^(BOOL finished){
        
        
        [self.buyPlayersView.view removeFromSuperview];
        self.buyPlayersView = nil;
        buyPlayerViewIsUp = NO;
        MainViewController *mv = (MainViewController*)[self parentViewController];
        mv.scrollView.scrollEnabled = YES;
    }];
    
}

-(void)StartEndTouch:(UILongPressGestureRecognizer *)gestureRecognizer{
    
    if(!buyPlayerViewIsUp) return;
    
    MainViewController *mv = (MainViewController*)[self parentViewController];
    UIView *playerView = gestureRecognizer.view;
  
    if([gestureRecognizer state] == UIGestureRecognizerStateBegan){
        
        if(isDraggingPlayer)return;
        
        self.buyPlayersView.scrollView.scrollEnabled = NO;
        isDraggingPlayer = YES;
        
        NSLog(@"START");
          ((UIImageView*)playerView).image = [UIImage imageNamed:@"PlayerRedBlond.png"];
        [self.view bringSubviewToFront:playerView];
        
        //TEST player
        currentPlayer = [[PlayerManager Instance].allTeams objectAtIndex:playerView.tag];
        
        //if the player isnt bought we need to pull it out from the scroll view
        if(!currentPlayer.bought){
            
            //convert the position of the image to the playerview's coordinate system
            CGRect positionInPlayersView = [self.buyPlayersView.scrollView convertRect:playerView.frame toView:self.view];
            
            currentPlayerCenter = positionInPlayersView;
            playerView.frame = positionInPlayersView;
            [self.view addSubview:playerView];
            
        }
        
        //makes sure we can move the view correct around in its superview
        _priorPoint = [gestureRecognizer locationInView:playerView.superview];
    }
    
    if([gestureRecognizer state] == UIGestureRecognizerStateChanged){//moving
        
        //   NSLog(@"Move");
        CGPoint point = [gestureRecognizer locationInView:playerView.superview];
        if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
            CGPoint center = playerView.center;
            center.x += point.x - _priorPoint.x;
            center.y += point.y - _priorPoint.y;
            playerView.center = center;
            
        }
        _priorPoint = point;
    }
    
    if([gestureRecognizer state] == UIGestureRecognizerStateEnded){
        ((UIImageView*)playerView).image = [UIImage imageNamed:@"PlayerBWBlack.png"];
        self.buyPlayersView.scrollView.scrollEnabled = NO;
        isDraggingPlayer = NO;
        //If player is bought check if we want to sell it
        if(currentPlayer.bought){
            
            NSLog(@"DONE");
            //If drop on scroll
            if([gestureRecognizer locationInView:self.view].y > 300){
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sell Player" message:@"Sell this player?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Sell", nil];
                alert.tag = 0;
                [alert show];
                
            }else if([self CheckDropableLocation:[gestureRecognizer locationInView:self.view]]){
                
            }else{
                
                // Move back to start position
                [self MovePlayerBack:playerView];
            }
            
        }else{//Check if we want to buy the player
            
            self.buyPlayersView.scrollView.scrollEnabled = YES;
            if([self CheckDropableLocation:[gestureRecognizer locationInView:self.view]]){
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Buy Player" message:@"Buy this player?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Buy", nil];
                alert.tag = 1;
                [alert show];
                
            }else{//Move back to original position in scroll view
                [self MoveImageBackToScrollView:[gestureRecognizer view]];
            }
        }
    }
}

-(BOOL)CheckDropableLocation:(CGPoint)playerPoint{
    
    BOOL isContained = NO;
    
    for (NSValue *value in self.playerDropableLocations){
        
        CGRect locationRect = [value CGRectValue];
        
        if(CGRectContainsPoint(locationRect, playerPoint)){
            
            for(Player *p in [PlayerManager Instance].allTeams){
                
                //Return false is there is already a player present on that field
                if(p != (Player*)[NSNull null] && p.bought && ![p isEqual:currentPlayer] && CGRectContainsPoint(p.playerImage.frame, playerPoint)){
                    
                    return isContained;
                }
            }
            
            isContained = YES;
            
            buyPointLocation.x = locationRect.origin.x + locationRect.size.width/2;
            buyPointLocation.y = locationRect.origin.y + locationRect.size.height/2;
            [UIView animateWithDuration:0.2 animations:^{
                
                currentPlayer.playerImage.center = buyPointLocation;
                currentPlayer.positionInView = buyPointLocation;
                
            }];
        }
    }
    return isContained;
}

-(void)MoveImageBackToScrollView:(UIView*)imageView{
    
    //convert the position of the image back to the coordinate system of the scroll view
    CGRect positionInBuyPlayersView = [self.view convertRect:currentPlayerCenter toView:self.buyPlayersView.scrollView];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        imageView.frame = currentPlayerCenter;
        
        
    } completion:^(BOOL finished){
        
        imageView.frame = positionInBuyPlayersView;
        [self.buyPlayersView.scrollView addSubview:imageView];
        
    }];
    
}

-(void)MovePlayerToInitialPositionInBuyView{
    
    CGPoint initialCenterPoint = [self.buyPlayersView FindCenterPointInBuyView:currentPlayer];
    CGPoint convertedPoint = [self.buyPlayersView.scrollView convertPoint: initialCenterPoint toView:self.view];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        currentPlayer.playerImage.center = convertedPoint;
        
        
    } completion:^(BOOL finished){
        
        [self.buyPlayersView.scrollView addSubview:currentPlayer.playerImage];
        currentPlayer.playerImage.center = initialCenterPoint;
        [self.buyPlayersView.scrollView bringSubviewToFront:currentPlayer.playerImage];
    }];
    
}


-(void)MovePlayerBack:(UIView*)playerView{
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        playerView.center = currentPlayer.positionInView;
        
        
    } completion:^(BOOL finished){
        
        
    }];
    
}


-(void)UpdatePointsLabel{
    
    self.pointsLabel.text = [NSString stringWithFormat:@"%d",[PlayerManager Instance].points];
}

// Delegate method - return YES to allow 2 different gesture recognizers at once
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    BOOL buying = alertView.tag;
    
    switch (buttonIndex) {
        case 0:
            if(buying){
                
                [self MoveImageBackToScrollView:currentPlayer.playerImage];
                
            }else{
                
                [self MovePlayerBack:currentPlayer.playerImage];
            }
            
            break;
        case 1:
            if(buying){
                //[currentPlayer.longPressGesture removeTarget:self action:@selector(StartEndTouch:)];
                currentPlayer.bought = YES;
            }else{
                
                currentPlayer.bought = NO;
                [self MovePlayerToInitialPositionInBuyView];
            }
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
