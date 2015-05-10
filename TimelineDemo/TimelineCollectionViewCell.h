//
//  TimelineCollectionViewCell.h
//
//
//  Created by Victor Chen on 5/9/15.
//  Copyright (c) 2015 Mt Zendo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DigitalMt.h"

@interface TimelineCollectionViewCell : UICollectionViewCell{
    
}
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

@property (strong, nonatomic) IBOutlet MZProfilePhotoView *profilePhotoView;
@end
