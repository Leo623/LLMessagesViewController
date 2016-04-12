//
//  LLPhotoMediaItem.h
//  LLMessages
//
//  Created by ruofei on 16/4/12.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "LLMediaItem.h"

/**
 *  The `LLPhotoMediaItem` class is a concrete `LLMediaItem` subclass that implements the `LLMessageMediaData` protocol
 *  and represents a photo media message. An initialized `LLPhotoMediaItem` object can be passed
 *  to a `LLMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `LLPhotoMediaItem` to provide additional functionality or behavior.
 */
@interface LLPhotoMediaItem : LLMediaItem <LLMessageMediaData, NSCoding, NSCopying>

/**
 *  The image for the photo media item. The default value is `nil`.
 */
@property (copy, nonatomic) UIImage *image;

/**
 *  Initializes and returns a photo media item object having the given image.
 *
 *  @param image The image for the photo media item. This value may be `nil`.
 *
 *  @return An initialized `LLPhotoMediaItem` if successful, `nil` otherwise.
 *
 *  @discussion If the image must be dowloaded from the network,
 *  you may initialize a `LLPhotoMediaItem` object with a `nil` image.
 *  Once the image has been retrieved, you can then set the image property.
 */
- (instancetype)initWithImage:(UIImage *)image;

@end
