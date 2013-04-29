//
//  LatestCollViewController.m
//  PitchFeudV2
//
//  Created by Rune on 25/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "LatestCollViewController.h"

@interface LatestCollViewController ()

@end

@implementation LatestCollViewController

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
    _betImages = [@[@"GameWindowBet07", @"GameWindowBet02", @"GameWindowBet03", @"GameWindowBet04", @"GameWindowBet05", @"GameWindowBet02", @"GameWindowBet07", @"GameWindowBet08", @"GameWindowBet01", @"GameWindowBet02", @"GameWindowBet03", @"GameWindowBet04", @"GameWindowBet05", @"GameWindowBet06", @"GameWindowBet07", @"GameWindowBet08"] mutableCopy];
}

#pragma mark -
#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return _betImages.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *Cell1 = [collectionView
                                 dequeueReusableCellWithReuseIdentifier:@"Cell1"
                                 forIndexPath:indexPath];
    
    UIImage *image;
    int row = [indexPath row];
    
    image = [UIImage imageNamed:_betImages[row]];
    
    Cell1.imageView.image = image;
    
    return Cell1;
}

// Sets the size of the imageView in the cell to the size of the content
/*
 -(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
 {
 UIImage *image;
 int row = [indexPath row];
 
 image = [UIImage imageNamed:_betImages[row]];
 
 return image.size;
 }
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
