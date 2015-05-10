//
//  NumberView.m
//  TimelineDemo
//
//  Created by Victor Chen on 5/10/15.
//  Copyright (c) 2015 Mt Zendo Inc. All rights reserved.
//

#import "NumberView.h"
#import "DigitalMt.h"

@implementation NumberView
- (void)make{
    _drawInnerShadow = YES;
    self.type = OutlineTypeOval;
    self.strokeWidth = 2;
    self.strokeColor = mzcolor(214, 206, 207, 1.0f);
    //(float)214/255, (float)206/255, (float)207/255
    //[UIColor colorWithRed:(float)38/255 green:(float)175/255 blue:(float)197/255 alpha:1.0f];
    self.fillColor = mzcolor(239, 237, 237, 1.0f);//same as the collection view
    self.titleLabel.textColor = mzcolor(214, 206, 207, 1.0f);
    self.titleLabel.text = @"D1";
    
    if (IS_IPHONE) {
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    else {
        self.titleLabel.font = [UIFont boldSystemFontOfSize:25];
    }
    
    self.userInteractionEnabled = NO;//disable gesture
    
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self make];
    }
    
    return self;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self make];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
