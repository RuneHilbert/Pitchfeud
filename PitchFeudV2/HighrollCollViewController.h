//
//  HighrollCollViewController.h
//  PitchFeudV2
//
//  Created by Rune on 25/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"

@interface HighrollCollViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray *betImages;

@end
