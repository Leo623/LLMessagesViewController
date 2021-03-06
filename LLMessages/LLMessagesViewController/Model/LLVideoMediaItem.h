//
//  LLVideoMediaItem.h
//  LLMessages
//
//  Created by ruofei on 16/4/12.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "LLMediaItem.h"

/**
 *  The `LLVideoMediaItem` class is a concrete `LLMediaItem` subclass that implements the `LLMessageMediaData` protocol
 *  and represents a video media message. An initialized `LLVideoMediaItem` object can be passed
 *  to a `LLMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `LLVideoMediaItem` to provide additional functionality or behavior.
 */
@interface LLVideoMediaItem : LLMediaItem <LLMessageMediaData, NSCoding, NSCopying>

/**
 *  The URL that identifies a video resource.
 */
@property (nonatomic, strong) NSURL *fileURL;

/**
 *  A boolean value that specifies whether or not the video is ready to be played.
 *
 *  @discussion When set to `YES`, the video is ready. When set to `NO` it is not ready.
 */
@property (nonatomic, assign) BOOL isReadyToPlay;

/**
 *  Initializes and returns a video media item having the given fileURL.
 *
 *  @param fileURL       The URL that identifies the video resource.
 *  @param isReadyToPlay A boolean value that specifies if the video is ready to play.
 *
 *  @return An initialized `LLVideoMediaItem` if successful, `nil` otherwise.
 *
 *  @discussion If the video must be downloaded from the network,
 *  you may initialize a `LLVideoMediaItem` with a `nil` fileURL or specify `NO` for
 *  isReadyToPlay. Once the video has been saved to disk, or is ready to stream, you can
 *  set the fileURL property or isReadyToPlay property, respectively.
 */
- (instancetype)initWithFileURL:(NSURL *)fileURL isReadyToPlay:(BOOL)isReadyToPlay;

@end
