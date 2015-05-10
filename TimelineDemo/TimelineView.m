//
//  TimelineView.m
//
//
//  Created by Victor Chen on 5/9/15.
//  Copyright (c) 2015 Mt Zendo Inc. All rights reserved.
//

#import "TimelineView.h"

@implementation TimelineView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Drawing lines with a white stroke color
    CGContextSetRGBStrokeColor(context, (float)214/255, (float)206/255, (float)207/255, 1.0);
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    // Draw a single line from left to right
    CGContextMoveToPoint(context, screenSize.width/2, 0.0);
    CGContextAddLineToPoint(context, screenSize.width/2, screenSize.height);
    CGContextStrokePath(context);
}


@end
