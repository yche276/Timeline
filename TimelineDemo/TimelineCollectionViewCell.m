//
//  TimelineCollectionViewCell.m
//
//
//  Created by Victor Chen on 5/9/15.
//  Copyright (c) 2015 Mt Zendo Inc. All rights reserved.
//

#import "TimelineCollectionViewCell.h"


@implementation TimelineCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *arrayOfViews = nil;
        arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"TimelineCollectionViewCell" owner:self options:nil];
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        self = [arrayOfViews objectAtIndex:0];
    }
    
    return self;
}






@end
