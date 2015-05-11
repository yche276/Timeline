//
//  DateCollectionViewCell.h
//
//
//  Created by Victor Chen on 5/9/15.
//  Copyright (c) 2015 Mt Zendo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateCollectionViewCell : UICollectionViewCell {
    
}
@property (strong, nonatomic) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) IBOutlet UILabel *weekdayLabel;
@property (strong, nonatomic) IBOutlet UILabel *monthLabel;


@property (assign, nonatomic)  BOOL typeSwitch;
@end
