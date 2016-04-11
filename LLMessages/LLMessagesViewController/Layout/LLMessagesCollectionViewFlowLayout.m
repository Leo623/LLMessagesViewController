//
//  LLMessagesCollectionViewFlowLayout.m
//  LLMessages
//
//  Created by ruofei on 16/4/11.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "LLMessagesCollectionViewFlowLayout.h"

#import "LLMessagesCollectionViewLayoutAttributes.h"
#import "LLMessagesCollectionViewFlowLayoutInvalidationContext.h"

@implementation LLMessagesCollectionViewFlowLayout

@dynamic collectionView;

#pragma mark -- Initialization

- (void)ll_configureFlowLayout
{
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sectionInset = UIEdgeInsetsMake(10.0f, 4.0, 10.0f, 4.0f);
    self.minimumLineSpacing = 4.0f;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self ll_configureFlowLayout];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self ll_configureFlowLayout];
}

//每一个Item会询问一次
+ (Class)layoutAttributesClass
{
    NSLog(@"每一个Item询问一次 layoutAttributesClass");
    return [LLMessagesCollectionViewLayoutAttributes class];
}

+ (Class)invalidationContextClass
{
    NSLog(@"首先会确定使上下文失效的类 invalidationContextClass");
    return [LLMessagesCollectionViewFlowLayoutInvalidationContext class];
}

#pragma mark -- Collection view flow layout

//布局之前会先调用这个
- (void)invalidateLayoutWithContext:(LLMessagesCollectionViewFlowLayoutInvalidationContext *)context
{
    NSLog(@"其次会调用invalidateLayoutWithContext");
    [super invalidateLayoutWithContext:context];
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    NSLog(@"prepareLayout");
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesInRect = [super layoutAttributesForElementsInRect:rect];
    NSLog(@"layoutAttributesForElementsInRect %@", attributesInRect);
    return attributesInRect;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LLMessagesCollectionViewLayoutAttributes *customAttributes = (LLMessagesCollectionViewLayoutAttributes *)[super layoutAttributesForItemAtIndexPath:indexPath];
    NSLog(@"layoutAttributesForItemAtIndexPath");
    return customAttributes;
}


//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    CGRect oldBounds = self.collectionView.bounces;
//    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
//        return YES;
//    }
//    return NO;
//}

- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems
{
    NSLog(@"prepareForCollectionViewUpdates");
}
@end
