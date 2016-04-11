//
//  LLMessagesBubblesSizeCalculator.h
//  LLMessages
//
//  Created by caipeng on 16/4/11.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLMessagesBubblesSizeCalculating.h"

@interface LLMessagesBubblesSizeCalculator : NSObject <LLMessagesBubblesSizeCalculating>

- (instancetype)initWithCache:(NSCache *)cache
           minimumBubbleWidth:(NSUInteger)minimumBubbleWidth
        usesFixedWidthBubbles:(BOOL)usesFixedWidthBubbles;

@end
