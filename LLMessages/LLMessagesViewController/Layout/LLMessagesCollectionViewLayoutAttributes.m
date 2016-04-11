//
//  LLMessagesCollectionViewLayoutAttributes.m
//  LLMessages
//
//  Created by ruofei on 16/4/11.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "LLMessagesCollectionViewLayoutAttributes.h"

@implementation LLMessagesCollectionViewLayoutAttributes

- (void)setMessageBubbleFont:(UIFont *)messageBubbleFont
{
    NSParameterAssert(messageBubbleFont != nil);
    _messageBubbleFont = messageBubbleFont;
}

- (void)setMessageBubbleContainerViewWidth:(CGFloat)messageBubbleContainerViewWidth
{
    NSParameterAssert(messageBubbleContainerViewWidth > 0.0f);
    _messageBubbleContainerViewWidth = ceilf(messageBubbleContainerViewWidth);
}


- (void)setIncomingAvatarViewSize:(CGSize)incomingAvatarViewSize
{
    NSParameterAssert(incomingAvatarViewSize.width >= 0.0f && incomingAvatarViewSize.height >= 0.0f);
    _incomingAvatarViewSize = [self ll_correctedAvatarSizeFromSize:incomingAvatarViewSize];
}

- (void)setOutgoingAvatarViewSize:(CGSize)outgoingAvatarViewSize
{
    NSParameterAssert(outgoingAvatarViewSize.width >= 0.0f && outgoingAvatarViewSize.height >= 0.0f);
    _outgoingAvatarViewSize = [self ll_correctedAvatarSizeFromSize:outgoingAvatarViewSize];
}

- (void)setCellTopLabelHeight:(CGFloat)cellTopLabelHeight
{
    NSParameterAssert(cellTopLabelHeight >= 0.0f);
    _cellTopLabelHeight = [self ll_correctedLabelHeightForHeight:cellTopLabelHeight];
}

- (void)setMessageBubbleTopLabelHeight:(CGFloat)messageBubbleTopLabelHeight
{
    NSParameterAssert(messageBubbleTopLabelHeight >= 0.0f);
    _messageBubbleTopLabelHeight = [self ll_correctedLabelHeightForHeight:messageBubbleTopLabelHeight];
}

- (void)setCellBottomLabelHeight:(CGFloat)cellBottomLabelHeight
{
    NSParameterAssert(cellBottomLabelHeight >= 0.0f);
    _cellBottomLabelHeight = [self ll_correctedLabelHeightForHeight:cellBottomLabelHeight];
}

#pragma mark -- Utilities
- (CGSize)ll_correctedAvatarSizeFromSize:(CGSize)size
{
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

- (CGFloat)ll_correctedLabelHeightForHeight:(CGFloat)height
{
    return ceilf(height);
}

#pragma mark -- NSObject

/**
 *  子类  重写，实现 对象相等判断
 *
 */
- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    }
    
    if (![other isKindOfClass:[self class]]) {
        return NO;
    }
    
    if (self.representedElementCategory == UICollectionElementCategoryCell) {
        LLMessagesCollectionViewLayoutAttributes *layoutAttributes = (LLMessagesCollectionViewLayoutAttributes *)other;
        if (![layoutAttributes.messageBubbleFont isEqual:self.messageBubbleFont]
            || !UIEdgeInsetsEqualToEdgeInsets(layoutAttributes.textViewFrameInsets, self.textViewFrameInsets)
            || !UIEdgeInsetsEqualToEdgeInsets(layoutAttributes.textViewTextContainerInsets, self.textViewTextContainerInsets)
            || !CGSizeEqualToSize(layoutAttributes.incomingAvatarViewSize, self.incomingAvatarViewSize)
            || !CGSizeEqualToSize(layoutAttributes.outgoingAvatarViewSize, self.outgoingAvatarViewSize)
            || (int)layoutAttributes.messageBubbleContainerViewWidth != (int)self.messageBubbleContainerViewWidth
            || (int)layoutAttributes.cellTopLabelHeight != (int)self.cellTopLabelHeight
            || (int)layoutAttributes.messageBubbleTopLabelHeight != (int)self.messageBubbleTopLabelHeight
            || (int)layoutAttributes.cellBottomLabelHeight != (int)self.cellBottomLabelHeight) {
            return NO;
        }
    }
    return [super isEqual:other];
}

- (NSUInteger)hash
{
    return [self.indexPath hash];
}

#pragma mark -- NSCopying
- (id)copyWithZone:(NSZone *)zone
{
    LLMessagesCollectionViewLayoutAttributes * copy = [super copyWithZone:zone];
    
    if (copy.representedElementCategory != UICollectionElementCategoryCell) {
        return copy;
    }
    
    copy.messageBubbleFont = self.messageBubbleFont;
    copy.messageBubbleContainerViewWidth = self.messageBubbleContainerViewWidth;
    copy.textViewTextContainerInsets = self.textViewTextContainerInsets;
    copy.textViewFrameInsets = self.textViewFrameInsets;
    copy.incomingAvatarViewSize = self.incomingAvatarViewSize;
    copy.outgoingAvatarViewSize = self.outgoingAvatarViewSize;
    copy.cellTopLabelHeight = self.cellTopLabelHeight;
    copy.messageBubbleTopLabelHeight = self.messageBubbleTopLabelHeight;
    copy.cellBottomLabelHeight = self.cellBottomLabelHeight;
    
    return copy;
}

@end
