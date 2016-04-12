//
//  LLMessageBubbleImageDataSource.h
//  LLMessages
//
//  Created by ruofei on 16/4/12.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  The `LLMessageBubbleImageDataSource` protocol defines the common interface through which
 *  a `LLMessagesViewController` and `LLMessagesCollectionView` interact with
 *  message bubble image model objects.
 *
 *  It declares the required and optional methods that a class must implement so that instances
 *  of that class can be display properly within a `LLMessagesCollectionViewCell`.
 *
 *  A concrete class that conforms to this protocol is provided in the library. See `LLMessagesBubbleImage`.
 *
 *  @see LLMessagesBubbleImage.
 */
@protocol LLMessageBubbleImageDataSource <NSObject>

@required

/**
 *  @return The message bubble image for a regular display state.
 *
 *  @warning You must not return `nil` from this method.
 */
- (UIImage *)messageBubbleImage;

/**
 *  @return The message bubble image for a highlighted display state.
 *
 *  @warning You must not return `nil` from this method.
 */
- (UIImage *)messageBubbleHighlightedImage;

@end