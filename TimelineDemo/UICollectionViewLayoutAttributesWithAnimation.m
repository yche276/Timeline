//
//  UICollectionViewLayoutAttributesWithAnimation.m
//  TimelineDemo
//
//  Created by Victor Chen on 5/12/15.
//  Copyright (c) 2015 Mt Zendo Inc. All rights reserved.
//

#import "UICollectionViewLayoutAttributesWithAnimation.h"

@implementation UICollectionViewLayoutAttributesWithAnimation
@synthesize animation=_animation;

- (id)copyWithZone:(NSZone *)zone
{
    UICollectionViewLayoutAttributesWithAnimation *attributes = [super copyWithZone:zone];
    attributes.animation = _animation;
    return attributes;
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    }
    if (!other || ![[other class] isEqual:[self class]]) {
        return NO;
    }
    if ([(( UICollectionViewLayoutAttributesWithAnimation *) other) animation] != [self animation]) {
        return NO;
    }
    
    return YES;
}

@end
