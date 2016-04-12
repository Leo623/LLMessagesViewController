//
//  LLMessagesCollectionViewLayoutInvalidationContext.h
//  LLMessages
//
//  Created by ruofei on 16/4/11.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  A `LLMessagesCollectionViewFlowLayoutInvalidationContext` object specifies properties for
 *  determining whether to recompute the size of items or their position in the layout.
 *  The flow layout object creates instances of this class when it needs to invalidate its contents
 *  in response to changes. You can also create instances when invalidating the flow layout manually.
 *
 *  子类化的目的是：加了一个缓存失效的开关
 */
@interface LLMessagesCollectionViewFlowLayoutInvalidationContext : UICollectionViewFlowLayoutInvalidationContext

@property (nonatomic, assign) BOOL invalidateFlowLayoutMessagesCache;

+ (instancetype)context;

@end
