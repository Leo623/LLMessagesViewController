//
//  LLMessagesCollectionViewFlowLayout.h
//  LLMessages
//
//  Created by ruofei on 16/4/11.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLMessagesCollectionView;

@interface LLMessagesCollectionViewFlowLayout : UICollectionViewFlowLayout

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
@property (readonly, nonatomic) LLMessagesCollectionView *collectionView;
#pragma clang diagnostic pop

@end
