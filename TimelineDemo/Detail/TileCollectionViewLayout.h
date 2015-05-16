//
//  TileCollectionViewLayout.h
//  Timeline
//
//  Created by Victor Chen on 5/14/15.
//  Copyright (c) 2015 Mt Zendo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBCollectionViewCell.h"

@interface TileCollectionViewLayout : UICollectionViewFlowLayout {
    
    
}
@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) CGFloat interItemSpacingX;

@property (nonatomic, strong) NSMutableArray *numberOfColumns;
@property (nonatomic, strong) NSMutableArray *itemSizeInSections;



@end
