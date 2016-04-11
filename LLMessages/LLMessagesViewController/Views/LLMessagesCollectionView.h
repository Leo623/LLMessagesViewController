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

@interface LLMessagesCollectionView : UICollectionView

@property (strong, nonatomic) LLMessagesCollectionViewFlowLayout *collectionViewLayout;
@property (weak, nonatomic) id<LLMessagesCollectionViewDataSource> dataSource;
@property (weak, nonatomic) id<LLMessagesCollectionViewDelegateFlowLayout> delegate;


@end
