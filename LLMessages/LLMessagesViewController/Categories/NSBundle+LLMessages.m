//
//  NSBundle+LLMessages.m
//  LLMessages
//
//  Created by caipeng on 16/4/11.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "NSBundle+LLMessages.h"

@implementation NSBundle (LLMessages)

+ (NSBundle *)ll_messagesBundle
{
    return [NSBundle bundleForClass:NSClassFromString(@"LLMessagesViewController")];
}

+ (NSBundle *)ll_messagesAssetBundle
{
    NSString *bundleResourcePath = [NSBundle ll_messagesBundle].resourcePath;
    NSString *assetPath = [bundleResourcePath stringByAppendingPathComponent:@"LLMessagesAssets.bundle"];
    return [NSBundle bundleWithPath:assetPath];
}

@end
