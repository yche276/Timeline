//
//  TimelineCollectionViewLayout.m
//  PIM
//
//  Created by Victor Chen on 2/8/15.
//  Copyright (c) 2015 Mt Zendo Inc. All rights reserved.
//

#import "TimelineCollectionViewLayout.h"
#import "AppDelegate.h"

#define IS_IPHONE           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPAD             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)



static NSString * const TimelineCellKind = @"TimelineCell";
static NSString * const DateCellKind = @"DateCell";
static NSString * const NumberCellKind = @"NumberCell";

@interface TimelineCollectionViewLayout () {

}
@property (nonatomic, assign) NSInteger dateHeight;
@property (nonatomic, assign) NSInteger numberHeight;
@property (nonatomic, strong) NSDictionary *layoutInfo;

//Private Methods
-(CGRect)dateViewRectAtRow:(NSInteger)prmRow column:(NSInteger)prmColumn;
-(CGRect)numberViewRectAtRow:(NSInteger)prmRow column:(NSInteger)prmColumn;
-(CGRect)timelineViewRectAtRow:(NSInteger)prmRow column:(NSInteger)prmColumn;

@end

@implementation TimelineCollectionViewLayout
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
    self.dateHeight = 50;
    self.numberHeight = IS_IPHONE?50:70;
    
    
    self.interItemSpacingY = IS_IPHONE?60:150;
    self.interItemSpacingX = IS_IPHONE?15:40.0f;
    
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;

    self.numberOfColumns = 3;
    
    CGFloat width = (screenSize.width/self.numberOfColumns)-self.interItemSpacingX;
    CGFloat height = IS_IPHONE?220:400;
    
    self.itemSize = (CGSize){width, height};
    
    
    CGFloat top = 50.0f;
    float left = (float)(screenSize.width-(self.itemSize.width*self.numberOfColumns))/(self.numberOfColumns+1);

    CGFloat bottom = 10.0f;
    CGFloat right = left;
    
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
    
    newLayoutInfo[TimelineCellKind] = cellLayoutInfo;
    
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
    return self.layoutInfo[TimelineCellKind][indexPath];
}




- (CGSize)collectionViewContentSize
{
    int sum = 0;
    for (int i=0; i<[self.collectionView numberOfSections]; i++) {
        sum += [self.collectionView numberOfItemsInSection:i];
    }
    CGFloat rowCount = sum / self.numberOfColumns;
    
    // make sure we count another row if one is only partially filled
//    if ([self.collectionView numberOfSections] % self.numberOfColumns) {
//        rowCount++;
//    }
    rowCount += 0.5f;
    CGFloat height = self.itemSize.height*(rowCount/2) + self.dateHeight*(rowCount/2) + (rowCount - 1) * self.interItemSpacingY ;

    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    
    return YES;
}

#pragma mark - Private

-(CGRect)dateViewRectAtRow:(NSInteger)prmRow column:(NSInteger)prmColumn{
    CGRect resultRect = CGRectZero;
    
    CGFloat spacingX = self.collectionView.bounds.size.width - self.itemInsets.left - self.itemInsets.right - (self.numberOfColumns * self.itemSize.width);
    
    if (self.numberOfColumns > 1) {
        spacingX = spacingX / (self.numberOfColumns - 1);
    }
    
    CGFloat originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * prmColumn);
    CGFloat originY = floor(self.itemInsets.top + (self.itemSize.height + self.interItemSpacingY) * prmRow);
    
    CGFloat width = self.itemSize.width*1.3;
    CGFloat height = self.dateHeight;
    CGFloat Y = originY-(self.itemSize.height*0.5f)*prmRow;
    Y = Y<0?originY:Y;
    Y += (self.itemSize.height/2)-(height/2);
    
    if(prmRow%2 == 0){// date--number--timeline_object
        CGFloat X = originX;
        resultRect = CGRectMake(X, Y, width, height);
    }
    else {// timeline_object--number--date
        CGFloat X = originX-(self.itemSize.width*0.3f);
        resultRect =  CGRectMake(X, Y, width, height);
    }
    return resultRect;
}

-(CGRect)numberViewRectAtRow:(NSInteger)prmRow column:(NSInteger)prmColumn{
    CGFloat height = self.numberHeight;
    CGFloat width = height;
    CGFloat originX = (self.collectionView.bounds.size.width/2)-(width/2);
    CGFloat originY = floor(self.itemInsets.top + (self.itemSize.height + self.interItemSpacingY) * prmRow);
    CGFloat Y = originY-(self.itemSize.height*0.5f)*prmRow;
    Y = Y<0?originY:Y;
    Y += (self.itemSize.height/2)-(height/2);
    return CGRectMake(originX, Y, width, height);
}

-(CGRect)timelineViewRectAtRow:(NSInteger)prmRow column:(NSInteger)prmColumn{
    CGRect resultRect = CGRectZero;
    CGFloat spacingX = self.collectionView.bounds.size.width - self.itemInsets.left - self.itemInsets.right - (self.numberOfColumns * self.itemSize.width);
    
    if (self.numberOfColumns > 1) {
        spacingX = spacingX / (self.numberOfColumns - 1);
    }
    CGFloat originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * prmColumn);
    CGFloat originY = floor(self.itemInsets.top + (self.itemSize.height + self.interItemSpacingY) * prmRow);
    CGFloat Y = originY-(self.itemSize.height*0.5f)*prmRow;
    if(prmRow%2 == 0){// date--number--timeline_object
        resultRect = CGRectMake(originX-(self.itemSize.width*0.3f),
                                Y<0?originY:Y,
                                self.itemSize.width*1.3,
                                self.itemSize.height);
    }
    else {// timeline_object--number--date
        resultRect = CGRectMake(originX,
                                Y<0?originY:Y,
                                self.itemSize.width*1.3,
                                self.itemSize.height);
    }
    return resultRect;
}

- (CGRect)frameForCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row/self.numberOfColumns;
    NSInteger column = indexPath.row%self.numberOfColumns;

    if(row%2 == 0){// date--number--timeline_object
        if (column == 0) {//date
            return [self dateViewRectAtRow:row column:column];
        }
        else if (column == 1){//number
            return [self numberViewRectAtRow:row column:column];
        }
        return [self timelineViewRectAtRow:row column:column];//time line, column index 2
    }
    else {// timeline_object--number--date
        if (column == 0) {//timeline obj
            return [self timelineViewRectAtRow:row column:column];
        }
        else if (column == 1){//number
            return [self numberViewRectAtRow:row column:column];
        }
        return [self dateViewRectAtRow:row column:column];//date, column index 2
    }
}

#pragma mark - Properties

- (void)setItemInsets:(UIEdgeInsets)itemInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(_itemInsets, itemInsets)) return;
    
    _itemInsets = itemInsets;
    
    [self invalidateLayout];
}

- (void)setItemSize:(CGSize)itemSize
{
    if (CGSizeEqualToSize(_itemSize, itemSize)) return;
    
    _itemSize = itemSize;
    
    [self invalidateLayout];
}

- (void)setInterItemSpacingY:(CGFloat)interItemSpacingY
{
    if (_interItemSpacingY == interItemSpacingY) return;
    
    _interItemSpacingY = interItemSpacingY;
    
    [self invalidateLayout];
}

- (void)setNumberOfColumns:(NSInteger)numberOfColumns
{
    if (_numberOfColumns == numberOfColumns) return;
    
    _numberOfColumns = numberOfColumns;
    
    [self invalidateLayout];
}



@end
