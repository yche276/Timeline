//
//  TimelineCollectionViewLayout.h
//
//
//  Created by Victor Chen on 2/8/15.
//  Copyright (c) 2015 Mt Zendo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimelineCollectionViewLayout : UICollectionViewLayout {
    
}
@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) CGFloat interItemSpacingX;
@property (nonatomic) NSInteger numberOfColumns;



@end
