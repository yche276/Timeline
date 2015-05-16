//
//  PBCollectionViewCell.h
//  PaperBoat
//
//  Created by Victor Chen on 5/16/15.
//  Copyright (c) 2015 Mt Zendo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BLOCK_TYPE)();

@interface PBCollectionViewCell : UICollectionViewCell {
    
}
@property (nonatomic, copy) BLOCK_TYPE onTap;
@property (nonatomic, copy) BLOCK_TYPE onLongPress;


@end
