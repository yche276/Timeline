//
//  TileCollectionViewLayout.m
//  Timeline
//
//  Created by Victor Chen on 5/14/15.
//  Copyright (c) 2015 Mt Zendo Inc. All rights reserved.
//

#import "TileCollectionViewLayout.h"

#import "UIApplication+Dimension.h"


#define IS_IPAD             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


static NSString * const cellKind = @"cell";


@interface TileCollectionViewLayout ()

@property (nonatomic, strong) NSDictionary *layoutInfo;

@end


@implementation TileCollectionViewLayout


#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
        
    }
    
    return self;
}

- (void)setup
{
    //    self.interItemSpacingY = 20.0f;
    
    self.interItemSpacingY = 0.0f;
    self.interItemSpacingX = 0.0f;
    CGSize screenSize = self.collectionView.frame.size;
    //[UIScreen mainScreen].bounds.size;
    //[UIApplication sizeInOrientation:[UIApplication sharedApplication].statusBarOrientation];

    self.numberOfColumns = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:1],
                                                            [NSNumber numberWithInt:2],
                                                            [NSNumber numberWithInt:3],
                                                            [NSNumber numberWithInt:1],
                                                            nil];
    self.itemSizeInSections = [NSMutableArray array];

    CGFloat sec0_Height = IS_IPHONE?55:130;
    CGFloat remainHeight = screenSize.height-sec0_Height;
    CGFloat sec1_Height = (CGFloat)remainHeight/3;
    CGFloat sec2_Height = (CGFloat)remainHeight/3;
    CGFloat sec3_Height = (CGFloat)remainHeight/3;
    
    
    [self.itemSizeInSections addObject:[NSValue valueWithCGSize:(CGSize){(screenSize.width/[[self.numberOfColumns objectAtIndex:0] intValue])-self.interItemSpacingY, sec0_Height}]];
    [self.itemSizeInSections addObject:[NSValue valueWithCGSize:(CGSize){(screenSize.width/[[self.numberOfColumns objectAtIndex:1] intValue])-self.interItemSpacingY, sec1_Height}]];
    [self.itemSizeInSections addObject:[NSValue valueWithCGSize:(CGSize){(screenSize.width/[[self.numberOfColumns objectAtIndex:2] intValue])-self.interItemSpacingY, sec2_Height}]];
    [self.itemSizeInSections addObject:[NSValue valueWithCGSize:(CGSize){(screenSize.width/[[self.numberOfColumns objectAtIndex:3] intValue])-self.interItemSpacingY, sec3_Height}]];
    
    CGFloat top = self.interItemSpacingX;
    CGFloat left = 0;
    CGFloat bottom = 0;
    CGFloat right = 0;
    
    self.itemInsets = UIEdgeInsetsMake(top, left, bottom, right);
}

#pragma mark - Layout

- (void)prepareLayout
{
    [self setup];
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForCellAtIndexPath:indexPath];
            
            cellLayoutInfo[indexPath] = itemAttributes;
        }
    }
    newLayoutInfo[cellKind] = cellLayoutInfo;
    self.layoutInfo = newLayoutInfo;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[cellKind][indexPath];
}

- (CGSize)collectionViewContentSize
{
    CGFloat height = 0;
    
    for (int i=0; i<[self.collectionView numberOfSections]; i++) {
        NSInteger  rowCount = [self.collectionView numberOfItemsInSection:i]/[self.numberOfColumns[i] intValue];
        CGSize size = [self.itemSizeInSections[i] CGSizeValue];
        height += (self.itemInsets.top+rowCount*size.height+(rowCount-1)*self.interItemSpacingY+self.itemInsets.bottom);
        
    }
    
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    
    return YES;
}

#pragma mark - Private
- (CGRect)frameForCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger numOfColumnInSection = [self.numberOfColumns[indexPath.section] intValue];
    CGSize size = [self.itemSizeInSections[indexPath.section] CGSizeValue];
    CGFloat itemHeight = size.height;
    CGFloat itemWidth = size.width;
    
    NSInteger row = indexPath.row/numOfColumnInSection;
    NSInteger column = indexPath.row%numOfColumnInSection;
    
    CGFloat spacingX = self.collectionView.bounds.size.width-self.itemInsets.left-self.itemInsets.right-(numOfColumnInSection*itemWidth);
    if (numOfColumnInSection > 1) {
        spacingX = spacingX / (numOfColumnInSection - 1);
    }
    CGFloat originX = floorf(self.itemInsets.left + (itemWidth + spacingX) * column);
    CGFloat originY = floorf(self.itemInsets.top + (itemHeight + self.interItemSpacingY) * row);
    
    originY += [self yOfSection:indexPath.section];
    CGRect rect = CGRectMake(originX, originY, itemWidth, itemHeight);
    
    if (indexPath.section == 1) {//second section, top moments and photos
        //only two items in this section
        if (indexPath.row == 0) {//top moments
            itemWidth = self.collectionView.frame.size.width/3;
            rect = CGRectMake(originX, originY, itemWidth, itemHeight);
        }
        else if (indexPath.row == 1){//photos
            itemWidth = self.collectionView.frame.size.width/3;
            rect = CGRectMake(originX-(itemWidth/2), originY, itemWidth*2, itemHeight);
        }
    }
//    NSLog(@"section = %ld,row = %ld, rect = %@", indexPath.section, indexPath.row, NSStringFromCGRect(rect));
    
    return rect;
}

-(CGFloat)yOfSection:(NSInteger)prmSection{
    CGFloat y = 0;
    for (int i=0; i<prmSection; i++) {
        NSInteger numOfColumnInSection = [self.numberOfColumns[i] intValue];
        NSInteger numRowInSection = [self.collectionView numberOfItemsInSection:i]/numOfColumnInSection;
        CGSize size = [self.itemSizeInSections[i] CGSizeValue];
        CGFloat itemHeight = size.height;
        y += (itemHeight+self.interItemSpacingY)*numRowInSection;
    }
    
    return y;
}

#pragma mark - Properties

- (void)setItemInsets:(UIEdgeInsets)itemInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(_itemInsets, itemInsets)) return;
    
    _itemInsets = itemInsets;
    
    [self invalidateLayout];
}



- (void)itemSizeInSections:(NSMutableArray *)itemSizeInSections
{
    if (_itemSizeInSections == itemSizeInSections) return;
    _itemSizeInSections = itemSizeInSections;
    
    [self invalidateLayout];
}


- (void)setInterItemSpacingY:(CGFloat)interItemSpacingY
{
    if (_interItemSpacingY == interItemSpacingY) return;
    
    _interItemSpacingY = interItemSpacingY;
    
    [self invalidateLayout];
}

- (void)setNumberOfColumns:(NSMutableArray *)numberOfColumns
{
    if (_numberOfColumns == numberOfColumns) return;
    
    _numberOfColumns = numberOfColumns;
    
    [self invalidateLayout];
}


@end
