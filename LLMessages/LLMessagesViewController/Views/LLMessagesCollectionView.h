//
//  LLMessagesCollectionView.h
//  LLMessages
//
//  Created by ruofei on 16/4/11.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LLMessagesCollectionViewFlowLayout.h"
#import "LLMessagesCollectionViewDataSource.h"
#import "LLMessagesCollectionViewDelegateFlowLayout.h"
#import "LLMessagesCollectionViewCell.h"

/**
 *  包装一个CollectionView, 这个CollectionView是专门做为消息来使用的，提供消息的数据源，提供消息的布局代理,提供布局对象
 *
 *  提供包装的   layoutdelegate
               datasource
               delegate
 */

@interface LLMessagesCollectionView : UICollectionView

@property (strong, nonatomic) LLMessagesCollectionViewFlowLayout *collectionViewLayout;
@property (weak, nonatomic) id<LLMessagesCollectionViewDataSource> dataSource;
@property (weak, nonatomic) id<LLMessagesCollectionViewDelegateFlowLayout> delegate;


@end
