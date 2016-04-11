//
//  LLMessagesCollectionViewLayoutInvalidationContext.m
//  LLMessages
//
//  Created by ruofei on 16/4/11.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "LLMessagesCollectionViewFlowLayoutInvalidationContext.h"

@implementation LLMessagesCollectionViewFlowLayoutInvalidationContext

#pragma mark -- Initialization
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.invalidateFlowLayoutDelegateMetrics = NO;
        self.invalidateFlowLayoutAttributes = NO;
        _invalidateFlowLayoutMessagesCache = NO;
    }
    return self;
}

+ (instancetype)context
{
    LLMessagesCollectionViewFlowLayoutInvalidationContext *context = [[LLMessagesCollectionViewFlowLayoutInvalidationContext alloc] init];
    context.invalidateFlowLayoutDelegateMetrics = YES;
    context.invalidateFlowLayoutAttributes = YES;
    return context;
}

#pragma mark -- NSObject
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: invalidateFlowLayoutDelegateMetrics=%@, invalidateFlowLayoutAttributes=%@, invalidateDataSourceCounts=%@, invalidateFlowLayoutMessagesCache=%@>", [self class], @(self.invalidateFlowLayoutDelegateMetrics), @(self.invalidateFlowLayoutAttributes), @(self.invalidateDataSourceCounts), @(self.invalidateFlowLayoutMessagesCache)];
}

@end
