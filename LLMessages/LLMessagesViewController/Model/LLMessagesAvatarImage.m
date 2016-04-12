//
//  LLMessagesAvatarImage.m
//  LLMessages
//
//  Created by ruofei on 16/4/12.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "LLMessagesAvatarImage.h"

@implementation LLMessagesAvatarImage
#pragma mark - Initialization

+ (instancetype)avatarWithImage:(UIImage *)image
{
    NSParameterAssert(image != nil);
    
    return [[LLMessagesAvatarImage alloc] initWithAvatarImage:image
                                              highlightedImage:image
                                              placeholderImage:image];
}

+ (instancetype)avatarImageWithPlaceholder:(UIImage *)placeholderImage
{
    return [[LLMessagesAvatarImage alloc] initWithAvatarImage:nil
                                              highlightedImage:nil
                                              placeholderImage:placeholderImage];
}

- (instancetype)initWithAvatarImage:(UIImage *)avatarImage
                   highlightedImage:(UIImage *)highlightedImage
                   placeholderImage:(UIImage *)placeholderImage
{
    NSParameterAssert(placeholderImage != nil);
    
    self = [super init];
    if (self) {
        _avatarImage = avatarImage;
        _avatarHighlightedImage = highlightedImage;
        _avatarPlaceholderImage = placeholderImage;
    }
    return self;
}

#pragma mark - NSObject

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: avatarImage=%@, avatarHighlightedImage=%@, avatarPlaceholderImage=%@>",
            [self class], self.avatarImage, self.avatarHighlightedImage, self.avatarPlaceholderImage];
}

- (id)debugQuickLookObject
{
    return [[UIImageView alloc] initWithImage:self.avatarImage ?: self.avatarPlaceholderImage];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithAvatarImage:[UIImage imageWithCGImage:self.avatarImage.CGImage]
                                                 highlightedImage:[UIImage imageWithCGImage:self.avatarHighlightedImage.CGImage]
                                                 placeholderImage:[UIImage imageWithCGImage:self.avatarPlaceholderImage.CGImage]];
}

@end
