//
//  LLMessagesCollectionViewLayoutInvalidationContext.h
//  LLMessages
//
//  Created by ruofei on 16/4/11.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLMessagesCollectionViewFlowLayoutInvalidationContext : UICollectionViewFlowLayoutInvalidationContext

@property (nonatomic, assign) BOOL invalidateFlowLayoutMessagesCache;


+ (instancetype)context;

@end
