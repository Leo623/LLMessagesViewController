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
#import "LLMessagesCollectionView.h"
#import "LLMessagesBubblesSizeCalculator.h"

const CGFloat kLLMessagesCollectionViewCellLabelHeightDefault = 10.0f;
const CGFloat kLLMessagesCollectionViewAvatarSizeDefault = 40.0f;


@interface LLMessagesCollectionViewFlowLayout ()

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (strong, nonatomic) NSMutableSet *visibleIndexPaths;

@property (assign, nonatomic) CGFloat latestDelta;

@end

@implementation LLMessagesCollectionViewFlowLayout

@dynamic collectionView;

@synthesize bubbleSizeCalculator = _bubbleSizeCalculator;

#pragma mark -- Initialization

- (void)ll_configureFlowLayout
{
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sectionInset = UIEdgeInsetsMake(10.0f, 4.0, 10.0f, 4.0f);
    self.minimumLineSpacing = 4.0f;
    
    _messageBubbleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        _messageBubbleLeftRightMargin = 240.f;
    }else {
        _messageBubbleLeftRightMargin = 50.f;
    }
    
    _messageBubbleTextViewFrameInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
    _messageBubbleTextViewTextContainerInsets = UIEdgeInsetsMake(7.0f, 14.0f, 7.0f, 14.0f);
    
    CGSize defaultAvatarSize = CGSizeMake(kLLMessagesCollectionViewAvatarSizeDefault, kLLMessagesCollectionViewAvatarSizeDefault);
    _incomingAvatarViewSize = defaultAvatarSize;
    _outgoingAvatarViewSize = defaultAvatarSize;
    
    _springinessEnabled = NO;
    _springResistanceFactor = 1000;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ll_didReceiveApplicationMemoryWarningNotification:)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ll_didReceiveDeviceOrientationDidChangeNotification:)
                                                 name:UIDeviceOrientationDidChangeNotification object:nil];
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

/**
 *  布局对象的相关类
 */
+ (Class)layoutAttributesClass
{
    return [LLMessagesCollectionViewLayoutAttributes class];
}

+ (Class)invalidationContextClass
{
    return [LLMessagesCollectionViewFlowLayoutInvalidationContext class];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark -- Setters
- (void)setBubbleSizeCalculator:(id<LLMessagesBubblesSizeCalculating>)bubbleSizeCalculator
{
    NSParameterAssert(bubbleSizeCalculator != nil);
    _bubbleSizeCalculator = bubbleSizeCalculator;
}

- (void)setSpringinessEnabled:(BOOL)springinessEnabled
{
    if (_springinessEnabled == springinessEnabled) {
        return;
    }
    
    _springinessEnabled = springinessEnabled;
    
    if (!springinessEnabled) {
        [_dynamicAnimator removeAllBehaviors];
        [_visibleIndexPaths removeAllObjects];
    }
    
    [self invalidateLayoutWithContext:[LLMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setMessageBubbleFont:(UIFont *)messageBubbleFont
{
    NSParameterAssert(messageBubbleFont != nil);
    
    if ([_messageBubbleFont isEqual:messageBubbleFont]) {
        return;
    }
    
    _messageBubbleFont = messageBubbleFont;
    [self invalidateLayoutWithContext:[LLMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setMessageBubbleLeftRightMargin:(CGFloat)messageBubbleLeftRightMargin
{
    NSParameterAssert(messageBubbleLeftRightMargin >= 0.0f);
    _messageBubbleLeftRightMargin = messageBubbleLeftRightMargin;
    [self invalidateLayoutWithContext:[LLMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setMessageBubbleTextViewFrameInsets:(UIEdgeInsets)messageBubbleTextViewFrameInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(_messageBubbleTextViewFrameInsets, messageBubbleTextViewFrameInsets)){
        return;
    }
    
    _messageBubbleTextViewFrameInsets = messageBubbleTextViewFrameInsets;
    
    [self invalidateLayoutWithContext:[LLMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setMessageBubbleTextViewTextContainerInsets:(UIEdgeInsets)messageBubbleTextViewTextContainerInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(_messageBubbleTextViewTextContainerInsets, messageBubbleTextViewTextContainerInsets)) {
        return;
    }
    
    _messageBubbleTextViewTextContainerInsets = messageBubbleTextViewTextContainerInsets;
    [self invalidateLayoutWithContext:[LLMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setIncomingAvatarViewSize:(CGSize)incomingAvatarViewSize
{
    if (CGSizeEqualToSize(_incomingAvatarViewSize, incomingAvatarViewSize)) {
        return;
    }
    
    _incomingAvatarViewSize = incomingAvatarViewSize;
    [self invalidateLayoutWithContext:[LLMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setOutgoingAvatarViewSize:(CGSize)outgoingAvatarViewSize
{
    if (CGSizeEqualToSize(_outgoingAvatarViewSize, outgoingAvatarViewSize)) {
        return;
    }
    
    _outgoingAvatarViewSize = outgoingAvatarViewSize;
    [self invalidateLayoutWithContext:[LLMessagesCollectionViewFlowLayoutInvalidationContext context]];
}
#pragma mark -- Getters

- (CGFloat)itemWidth
{
    return CGRectGetWidth(self.collectionView.frame) - self.sectionInset.left - self.sectionInset.right;
}

- (UIDynamicAnimator *)dynamicAnimator
{
    if (!_dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    }
    return _dynamicAnimator;
}

- (NSMutableSet *)visibleIndexPaths
{
    if (!_visibleIndexPaths) {
        _visibleIndexPaths = [NSMutableSet new];
    }
    return _visibleIndexPaths;
}

- (id<LLMessagesBubblesSizeCalculating>)bubbleSizeCalculator
{
    if (!_bubbleSizeCalculator) {
        _bubbleSizeCalculator = [LLMessagesBubblesSizeCalculator new];
    }
    return _bubbleSizeCalculator;
}


#pragma mark -- Notifications
- (void)ll_didReceiveApplicationMemoryWarningNotification:(NSNotification *)notification
{
    [self ll_resetLayout];
}

- (void)ll_didReceiveDeviceOrientationDidChangeNotification:(NSNotification *)notification
{
    [self ll_resetLayout];
    [self invalidateLayoutWithContext:[LLMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

#pragma mark -- Collection view flow layout

- (void)invalidateLayoutWithContext:(LLMessagesCollectionViewFlowLayoutInvalidationContext *)context
{
    if (context.invalidateDataSourceCounts) {
        context.invalidateFlowLayoutAttributes = YES;
        context.invalidateFlowLayoutDelegateMetrics = YES;
    }
    
    if (context.invalidateFlowLayoutAttributes || context.invalidateFlowLayoutDelegateMetrics) {
        [self ll_resetDynamicAnimator];
    }
    
    if (context.invalidateFlowLayoutMessagesCache) {
        [self ll_resetLayout];
    }
    [super invalidateLayoutWithContext:context];
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    if (self.springinessEnabled) {
        //  pad rect to avoid flickering
        CGFloat padding = -100;
        CGRect visibleRect = CGRectInset(self.collectionView.bounds, padding, padding);
        
        NSArray *visibleItems = [super layoutAttributesForElementsInRect:visibleRect];
        NSSet *visibleItemsIndexPaths = [NSSet setWithArray:[visibleItems valueForKey:NSStringFromSelector(@selector(indexPath))]];
        
        [self ll_removeNoLongerVisibleBehaviorsFromVisibleItemsIndexPaths:visibleItemsIndexPaths];
        [self ll_addNewlyVisibleBehaviorsFromVisibleItems:visibleItems];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesInRect = [super layoutAttributesForElementsInRect:rect];
    
    if (self.springinessEnabled) {
        NSMutableArray *attributesInRectCopy = [attributesInRect mutableCopy];
        NSArray *dynamicAttributes = [self.dynamicAnimator itemsInRect:rect];
        
        //  avoid duplicate attributes
        //  use dynamic animator attribute item instead of regular item, if it exists
        for (UICollectionViewLayoutAttributes *eachItem in attributesInRect) {
            
            for (UICollectionViewLayoutAttributes *eachDynamicItem in dynamicAttributes) {
                if ([eachItem.indexPath isEqual:eachDynamicItem.indexPath]
                    && eachItem.representedElementCategory == eachDynamicItem.representedElementCategory) {
                    
                    [attributesInRectCopy removeObject:eachItem];
                    [attributesInRectCopy addObject:eachDynamicItem];
                    continue;
                }
            }
        }
        attributesInRect = attributesInRectCopy;
    }
    
    [attributesInRect enumerateObjectsUsingBlock:^(LLMessagesCollectionViewLayoutAttributes *attributesItem, NSUInteger index, BOOL * _Nonnull stop) {
        if (attributesItem.representedElementCategory == UICollectionElementCategoryCell) {
            
        }else {
            attributesItem.zIndex = -1;
        }
    }];
    
    return attributesInRect;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LLMessagesCollectionViewLayoutAttributes *customAttributes = (LLMessagesCollectionViewLayoutAttributes *)[super layoutAttributesForItemAtIndexPath:indexPath];
    
    if (customAttributes.representedElementCategory == UICollectionElementCategoryCell) {
        [self ll_configureMessageCellLayoutAttributes:customAttributes];
    }
    
    return customAttributes;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    if (self.springinessEnabled) {
        UIScrollView *scrollView = self.collectionView;
        CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
        
        self.latestDelta = delta;
        
        CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
        
        [self.dynamicAnimator.behaviors enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehaviour, NSUInteger idx, BOOL *stop) {
            [self ll_adjustSpringBehavior:springBehaviour forTouchLocation:touchLocation];
            [self.dynamicAnimator updateItemUsingCurrentState:[springBehaviour.items firstObject]];
        }];
    }
    
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    
    return NO;
}

- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems
{
    [super prepareForCollectionViewUpdates:updateItems];
    
    [updateItems enumerateObjectsUsingBlock:^(UICollectionViewUpdateItem *updateItem, NSUInteger index, BOOL *stop) {
        if (updateItem.updateAction == UICollectionUpdateActionInsert) {
            
            if (self.springinessEnabled && [self.dynamicAnimator layoutAttributesForCellAtIndexPath:updateItem.indexPathAfterUpdate]) {
                *stop = YES;
            }
            
            CGFloat collectionViewHeight = CGRectGetHeight(self.collectionView.bounds);
            
            //插入之后拿到属性
            LLMessagesCollectionViewLayoutAttributes *attributes = [LLMessagesCollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:updateItem.indexPathAfterUpdate];
            
            if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
                [self ll_configureMessageCellLayoutAttributes:attributes];
            }
            
            attributes.frame = CGRectMake(0.0f,
                                          collectionViewHeight + CGRectGetHeight(attributes.frame),
                                          CGRectGetWidth(attributes.frame),
                                          CGRectGetHeight(attributes.frame));
            
            if (self.springinessEnabled) {
                UIAttachmentBehavior *springBehaviour = [self ll_springBehaviorWithLayoutAttributesItem:attributes];
                [self.dynamicAnimator addBehavior:springBehaviour];
            }
        }
    }];
}

#pragma mark -- Invalidation utilities
- (void)ll_resetLayout
{
    [self.bubbleSizeCalculator prepareForResettingLayout:self];
    [self ll_resetDynamicAnimator];
}

- (void)ll_resetDynamicAnimator
{
    if (self.springinessEnabled) {
        [self.dynamicAnimator removeAllBehaviors];
        [self.visibleIndexPaths removeAllObjects];
    }
}
#pragma mark -- Message cell layout utilities

- (CGSize)messageBubbleSizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(200, 100);
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize messageBubbleSize = [self messageBubbleSizeForItemAtIndexPath:indexPath];
    LLMessagesCollectionViewLayoutAttributes *attributes = (LLMessagesCollectionViewLayoutAttributes *)[self layoutAttributesForItemAtIndexPath:indexPath];
    
    CGFloat finalHeight = messageBubbleSize.height;
    finalHeight += attributes.cellTopLabelHeight;
    finalHeight += attributes.messageBubbleTopLabelHeight;
    finalHeight += attributes.cellBottomLabelHeight;
    
    return CGSizeMake(self.itemWidth, ceilf(finalHeight));
}

//子类化，要自己去赋值
- (void)ll_configureMessageCellLayoutAttributes:(LLMessagesCollectionViewLayoutAttributes *)layoutAttributes
{
    NSIndexPath *indexPath = layoutAttributes.indexPath;
    
    CGSize messageBubbleSize = [self messageBubbleSizeForItemAtIndexPath:indexPath];
    
    layoutAttributes.messageBubbleContainerViewWidth = messageBubbleSize.width;
    layoutAttributes.textViewFrameInsets = self.messageBubbleTextViewFrameInsets;
    layoutAttributes.textViewTextContainerInsets = self.messageBubbleTextViewTextContainerInsets;
    layoutAttributes.messageBubbleFont = self.messageBubbleFont;
    layoutAttributes.incomingAvatarViewSize = self.incomingAvatarViewSize;
    layoutAttributes.outgoingAvatarViewSize = self.outgoingAvatarViewSize;
    layoutAttributes.cellTopLabelHeight = 10;
    layoutAttributes.messageBubbleTopLabelHeight = 0;
    layoutAttributes.cellBottomLabelHeight = 10;
}
#pragma mark -- Spring behavior utilities

/**
 *  UICollectionViewLayoutAttributes 实现了 UIDynamicItem 协议，所以，
 *
 *  UICollectionViewLayoutAttributes 可以添加动画行为。
 */

- (UIAttachmentBehavior *)ll_springBehaviorWithLayoutAttributesItem:(UICollectionViewLayoutAttributes *)item
{
    if (CGSizeEqualToSize(item.frame.size, CGSizeZero)) {
        // adding a spring behavior with zero size will fail in in -prepareForCollectionViewUpdates:
        return nil;
    }
    
    UIAttachmentBehavior *springBehavior = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:item.center];
    springBehavior.length = 1.0f;
    springBehavior.damping = 1.0f;
    springBehavior.frequency = 1.0f;
    return springBehavior;
}

- (void)ll_addNewlyVisibleBehaviorsFromVisibleItems:(NSArray *)visibleItems
{
    //  a "newly visible" item is in `visibleItems` but not in `self.visibleIndexPaths`
    NSIndexSet *indexSet = [visibleItems indexesOfObjectsPassingTest:^BOOL(UICollectionViewLayoutAttributes *item, NSUInteger index, BOOL * _Nonnull stop) {
        return ![self.visibleIndexPaths containsObject:item.indexPath];
    }];
    
    NSArray *newlyVisibleItems = [visibleItems objectsAtIndexes:indexSet];
    
    CGPoint touchLocation =[self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    [newlyVisibleItems enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *item, NSUInteger index, BOOL * _Nonnull stop) {
        UIAttachmentBehavior *springBehaviour = [self ll_springBehaviorWithLayoutAttributesItem:item];
        [self ll_adjustSpringBehavior:springBehaviour forTouchLocation:touchLocation];
        [self.dynamicAnimator addBehavior:springBehaviour];
        [self.visibleIndexPaths addObject:item.indexPath];
    }];
}

- (void)ll_removeNoLongerVisibleBehaviorsFromVisibleItemsIndexPaths:(NSSet *)visibleItemsIndexPaths
{
    NSArray *behaviors = self.dynamicAnimator.behaviors;
    
    NSIndexSet *indexSet = [behaviors indexesOfObjectsPassingTest:^BOOL(UIAttachmentBehavior *springBehaviour, NSUInteger index, BOOL * _Nonnull stop) {
        UICollectionViewLayoutAttributes *layoutAttributes = (UICollectionViewLayoutAttributes *)[springBehaviour.items firstObject];
        return ![visibleItemsIndexPaths containsObject:layoutAttributes.indexPath];
    }];
    
    NSArray *behaviorsToRemove = [self.dynamicAnimator.behaviors objectsAtIndexes:indexSet];
    
    [behaviorsToRemove enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehaviour, NSUInteger index, BOOL * _Nonnull stop) {
        UICollectionViewLayoutAttributes *layoutAttributes = (UICollectionViewLayoutAttributes *)[springBehaviour.items firstObject];
        [self.dynamicAnimator removeBehavior:springBehaviour];
        [self.visibleIndexPaths removeObject:layoutAttributes.indexPath];
    }];
}

- (void)ll_adjustSpringBehavior:(UIAttachmentBehavior *)springBehavior forTouchLocation:(CGPoint)touchLocation
{
    UICollectionViewLayoutAttributes *item = (UICollectionViewLayoutAttributes *)[springBehavior.items firstObject];
    CGPoint center = item.center;
    
    //  if touch is not (0,0) -- adjust item center "in flight"
    if (!CGPointEqualToPoint(CGPointZero, touchLocation)) {
        CGFloat distanceFromTouch = fabs(touchLocation.y - springBehavior.anchorPoint.y);
        CGFloat scrollResistance = distanceFromTouch / self.springResistanceFactor;
        
        if (self.latestDelta < 0.0f) {
            center.y += MAX(self.latestDelta, self.latestDelta * scrollResistance);
        }else {
            center.y = MIN(self.latestDelta, self.latestDelta * scrollResistance);
        }
        item.center = center;
    }
}

@end












