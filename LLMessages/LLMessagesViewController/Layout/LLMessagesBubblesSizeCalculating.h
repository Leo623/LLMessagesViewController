//
//  LLMessagesBubblesSizeCalculating.h
//  LLMessages
//
//  Created by caipeng on 16/4/11.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LLMessagesCollectionViewFlowLayout;
@protocol LLMessagesBubblesSizeCalculating <NSObject>


/**
 *  Notifies the receiver that the layout will be reset.
 *  Use this method to clear any cached layout information, if necessary.
 *
 *  @param layout The layout object notifying the receiver.
 */
- (void)prepareForResettingLayout:(LLMessagesCollectionViewFlowLayout *)layout;

@end