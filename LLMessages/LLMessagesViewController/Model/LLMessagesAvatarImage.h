//
//  LLMessagesAvatarImage.h
//  LLMessages
//
//  Created by ruofei on 16/4/12.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LLMessageAvatarImageDataSource.h"

/**
 *  A `LLMessagesAvatarImage` model object represents an avatar image.
 *  This is a concrete class that implements the `LLMessageAvatarImageDataSource` protocol.
 *  It contains a regular avatar image, a highlighted avatar image, and a placeholder avatar image.
 *
 *  @see LLMessagesAvatarImageFactory.
 */
@interface LLMessagesAvatarImage : NSObject <LLMessageAvatarImageDataSource, NSCopying>

/**
 *  The avatar image for a regular display state.
 */
@property (nonatomic, strong) UIImage *avatarImage;

/**
 *  The avatar image for a highlighted display state.
 */
@property (nonatomic, strong) UIImage *avatarHighlightedImage;

/**
 *  Returns the placeholder image for an avatar to display if avatarImage is `nil`.
 */
@property (nonatomic, strong, readonly) UIImage *avatarPlaceholderImage;

/**
 *  Initializes and returns an avatar image object having the specified image.
 *
 *  @param image The image for this avatar image. This image will be used for the all of the following
 *  properties: avatarImage, avatarHighlightedImage, avatarPlaceholderImage;
 *  This value must not be `nil`.
 *
 *  @return An initialized `LLMessagesAvatarImage` object if successful, `nil` otherwise.
 */
+ (instancetype)avatarWithImage:(UIImage *)image;

/**
 *  Initializes and returns an avatar image object having the specified placeholder image.
 *
 *  @param placeholderImage The placeholder image for this avatar image. This value must not be `nil`.
 *
 *  @return An initialized `LLMessagesAvatarImage` object if successful, `nil` otherwise.
 */
+ (instancetype)avatarImageWithPlaceholder:(UIImage *)placeholderImage;

/**
 *  Initializes and returns an avatar image object having the specified regular, highlighed, and placeholder images.
 *
 *  @param avatarImage      The avatar image for a regular display state.
 *  @param highlightedImage The avatar image for a highlighted display state.
 *  @param placeholderImage The placeholder image for this avatar image. This value must not be `nil`.
 *
 *  @return An initialized `LLMessagesAvatarImage` object if successful, `nil` otherwise.
 */
- (instancetype)initWithAvatarImage:(UIImage *)avatarImage
                   highlightedImage:(UIImage *)highlightedImage
                   placeholderImage:(UIImage *)placeholderImage NS_DESIGNATED_INITIALIZER;

/**
 *  Not a valid initializer.
 */
- (id)init NS_UNAVAILABLE;

@end
