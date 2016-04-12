//
//  LLMessagesBubblesSizeCalculator.m
//  LLMessages
//
//  Created by caipeng on 16/4/11.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "LLMessagesBubblesSizeCalculator.h"

@interface LLMessagesBubblesSizeCalculator ()

@property (strong, nonatomic, readonly) NSCache *cache;
@property (assign, nonatomic, readonly) NSUInteger minimumBubbleWidth;
@property (assign, nonatomic, readonly) BOOL usesFixedWidthBubbles;
@property (assign, nonatomic, readonly) NSInteger additionalInset;
@property (assign, nonatomic) CGFloat layoutWidthForFixedWidthBubbles;

@end

@implementation LLMessagesBubblesSizeCalculator

- (instancetype)initWithCache:(NSCache *)cache
           minimumBubbleWidth:(NSUInteger)minimumBubbleWidth
        usesFixedWidthBubbles:(BOOL)usesFixedWidthBubbles
{
    NSParameterAssert(cache != nil);
    NSParameterAssert(minimumBubbleWidth > 0);
    
    self = [super init];
    
    if (self) {
        _cache = cache;
        _minimumBubbleWidth = minimumBubbleWidth;
        _usesFixedWidthBubbles = usesFixedWidthBubbles;
        _layoutWidthForFixedWidthBubbles = 0.0f;
        
        // this extra inset value is needed because `boundingRectWithSize:` is slightly off
        // see comment below
        _additionalInset = 2;
    }
    return self;
}

- (instancetype)init
{
    NSCache *cache = [NSCache new];
    cache.name = @"LLMessagesBubblesSizeCalculator.cache";
    cache.countLimit = 200;
    
    return [self initWithCache:cache minimumBubbleWidth:20 usesFixedWidthBubbles:NO];
}

#pragma mark -- NSObject
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: cache=%@, minimumBubbleWidth=%@ usesFixedWidthBubbles=%@>",[self class], self.cache, @(self.minimumBubbleWidth), @(self.usesFixedWidthBubbles)];
}

#pragma mark -- LLMessagesBubbleSizeCalculating

- (void)prepareForResettingLayout:(LLMessagesCollectionViewFlowLayout *)layout
{
    [self.cache removeAllObjects];
}


@end

















