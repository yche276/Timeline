//
//  DateCollectionViewCell.m
//
//
//  Created by Victor Chen on 5/9/15.
//  Copyright (c) 2015 Mt Zendo Inc. All rights reserved.
//

#import "DateCollectionViewCell.h"
#import "DigitalMt.h"

@implementation DateCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        NSArray *arrayOfViews = nil;
//        CGSize screenSize = [UIScreen mainScreen].bounds.size;
//        
//        
//        if (frame.origin.x < screenSize.width/2) {//left hand side
//            
//            arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"DateCollectionViewCell" owner:self options:nil];
//        }
//        else {//load right hand side
//            arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"DateCollectionViewCell-RightSide" owner:self options:nil];
//        }
//        
//        if ([arrayOfViews count] < 1) {
//            return nil;
//        }
//        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
//            return nil;
//        }
//       
//        self = [arrayOfViews objectAtIndex:0];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if (IS_IPHONE) {
        return;
    }
    
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Drawing lines with a white stroke color
    CGContextSetRGBStrokeColor(context, (float)214/255, (float)206/255, (float)207/255, 1.0);
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    if (self.typeSwitch) {//YES is left, NO is right side
        CGContextMoveToPoint(context, self.frame.size.width*0.55f, self.frame.size.height/2);
        CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height/2);
    }
    else{
        CGContextMoveToPoint(context, 0, self.frame.size.height/2);
        CGContextAddLineToPoint(context, self.frame.size.width*0.55f, self.frame.size.height/2);
    }
    
    
    
    
    CGContextStrokePath(context);
}


@end
