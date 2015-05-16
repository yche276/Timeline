//
//  PBCollectionViewCell.m
//   
//
//  Created by Victor Chen on 5/16/15.
//  Copyright (c) 2015 Mt Zendo Inc. All rights reserved.
//

#import "PBCollectionViewCell.h"

@implementation PBCollectionViewCell
@synthesize onTap, onLongPress;

-(void)commonInit{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
    longPress.cancelsTouchesInView = NO;
    [self addGestureRecognizer:longPress];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapRecognizer];
}


- (void)awakeFromNib {
    // Initialization code
    [self commonInit];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

#pragma mark - Gesture Methods
-(void)onLongPress:(UILongPressGestureRecognizer *)gestureRecognizer{
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
//        DLog(@"onLongPress");
        //        [[NSNotificationCenter defaultCenter] postNotificationName:kClockEnterEditModeNotification object:nil userInfo:nil];
    }
}

-(void)onTapped:(UITapGestureRecognizer *)gestureRecognizer{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(1), @(0.9), @(0.8), @(0.9), @(1)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.duration = 0.15f;
    animation.delegate = self;
    
    void (^completion)(void) = ^{
        if (self.onTap) {
            self.onTap();
        }
    };
    
    
    [animation setValue:completion forKey:@"bounce_completion_handler"];
    [self.layer addAnimation:animation forKey:@"bounce"];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
    BLOCK_TYPE compBlock = [theAnimation valueForKey:@"bounce_completion_handler"];
    if (compBlock) {
        compBlock();
    }
}

@end
