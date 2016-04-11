//
//  LLMessagesCollectionViewLayoutAttributes.h
//  LLMessages
//
//  Created by ruofei on 16/4/11.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  一个模型，专门用来管理布局属性的
 */
@interface LLMessagesCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes <NSCopying>

@property (strong, nonatomic) UIFont *messageBubbleFont;

@property (assign, nonatomic) CGFloat messageBubbleContainerViewWidth;

@property (assign, nonatomic) UIEdgeInsets textViewTextContainerInsets;

/**
 *  The inset of the frame of the text view within a `JSQMessagesCollectionViewCell`.
 *
 *  @discussion The inset values should be greater than or equal to `0.0` and are applied in the following ways:
 *
 *  1. The right value insets the text view frame on the side adjacent to the avatar image
 *  (or where the avatar would normally appear). For outgoing messages this is the right side,
 *  for incoming messages this is the left side.
 *
 *  2. The left value insets the text view frame on the side opposite the avatar image
 *  (or where the avatar would normally appear). For outgoing messages this is the left side,
 *  for incoming messages this is the right side.
 *
 *  3. The top value insets the top of the frame.
 *
 *  4. The bottom value insets the bottom of the frame.
 */
@property (assign, nonatomic) UIEdgeInsets textViewFrameInsets;

@property (assign, nonatomic) CGSize incomingAvatarViewSize;

@property (assign, nonatomic) CGSize outgoingAvatarViewSize;

@property (assign, nonatomic) CGFloat cellTopLabelHeight;

@property (assign, nonatomic) CGFloat messageBubbleTopLabelHeight;

@property (assign, nonatomic) CGFloat cellBottomLabelHeight;

@end
