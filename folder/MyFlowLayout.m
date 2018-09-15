//
//  MyFlowLayout.m
//  demo
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MyFlowLayout.h"

@interface MyFlowLayout ()<UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSMutableArray *allAttributes;

@end

@implementation MyFlowLayout

-(instancetype)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.allAttributes = [NSMutableArray array];
    
    NSInteger sections = [self.collectionView numberOfSections];
    for (int i = 0; i < sections; i++)
    {
        NSMutableArray * tmpArray = [NSMutableArray array];
        NSUInteger count = [self.collectionView numberOfItemsInSection:i];
        
        for (NSUInteger j = 0; j<count; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [tmpArray addObject:attributes];
        }
        
        [self.allAttributes addObject:tmpArray];
    }
}

- (CGSize)collectionViewContentSize
{
//    return [super collectionViewContentSize];
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    NSInteger pageNumber = itemCount / (self.rowCount * self.itemCountPerRow);
    if (itemCount%(self.rowCount*self.itemCountPerRow)) {
        pageNumber += 1;
    }
    return CGSizeMake(pageNumber * self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger item = indexPath.item;
    NSUInteger x;
    NSUInteger y;
    [self targetPositionWithItem:item resultX:&x resultY:&y];
    NSUInteger item2 = [self originItemAtX:x y:y];
    NSIndexPath *theNewIndexPath = [NSIndexPath indexPathForItem:item2 inSection:indexPath.section];
    
    UICollectionViewLayoutAttributes *theNewAttr = [super layoutAttributesForItemAtIndexPath:theNewIndexPath];
    theNewAttr.indexPath = indexPath;
    return theNewAttr;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *tmp = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        for (NSMutableArray *attributes in self.allAttributes)
        {
            for (UICollectionViewLayoutAttributes *attr2 in attributes) {
                if (attr.indexPath.item == attr2.indexPath.item) {
                    [tmp addObject:attr2];
                    break;
                }
            }
            
        }
    }
    return tmp;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

// 根据 item 计算目标item的位置
// x 横向偏移  y 竖向偏移
- (void)targetPositionWithItem:(NSUInteger)item
                       resultX:(NSUInteger *)x
                       resultY:(NSUInteger *)y
{
    NSUInteger page = item/(self.itemCountPerRow*self.rowCount);
    
    NSUInteger theX = item % self.itemCountPerRow + page * self.itemCountPerRow;
    NSUInteger theY = item / self.itemCountPerRow - page * self.rowCount;
    if (x != NULL) {
        *x = theX;
    }
    if (y != NULL) {
        *y = theY;
    }
    
}

// 根据偏移量计算item
- (NSUInteger)originItemAtX:(NSUInteger)x
                          y:(NSUInteger)y
{
    NSUInteger item = x * self.rowCount + y;
    return item;
}


@end
