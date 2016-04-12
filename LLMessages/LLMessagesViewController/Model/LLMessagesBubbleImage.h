//
//  LLMessagesBubbleImage.h
//  LLMessages
//
//  Created by ruofei on 16/4/12.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LLMessageBubbleImageDataSource.h"

/**
 *  A `LLMessagesBubbleImage` model object represents a message bubble image, and is immutable.
 *  This is a concrete class that implements the `LLMessageBubbleImageDataSource` protocol.
 *  It contains a regular message bubble image and a highlighted message bubble image.
 *
 *  @see LLMessagesBubbleImageFactory.
 */
@interface LLMessagesBubbleImage : NSObject <LLMessageBubbleImageDataSource, NSCopying>

/**
 *  Returns the message bubble image for a regular display state.
 */
@property (strong, nonatomic, readonly) UIImage *messageBubbleImage;

/**
 *  Returns the message bubble image for a highlighted display state.
 */
@property (strong, nonatomic, readonly) UIImage *messageBubbleHighlightedImage;

/**
 *  Initializes and returns a message bubble image object having the specified regular image and highlighted image.
 *
 *  @param image            The regular message bubble image. This value must not be `nil`.
 *  @param highlightedImage The highlighted message bubble image. This value must not be `nil`.
 *
 *  @return An initialized `LLMessagesBubbleImage` object if successful, `nil` otherwise.
 *
 *  @see LLMessagesBubbleImageFactory.
 */
- (instancetype)initWithMessageBubbleImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage NS_DESIGNATED_INITIALIZER;

/**
 *  Not a valid initializer.
 */
- (id)init NS_UNAVAILABLE;

@end
