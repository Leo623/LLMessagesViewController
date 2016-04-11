//
//  NSString+LLMessages.m
//  LLMessages
//
//  Created by caipeng on 16/4/11.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "NSString+LLMessages.h"

@implementation NSString (LLMessages)

- (NSString *)ll_stringByTrimingWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
