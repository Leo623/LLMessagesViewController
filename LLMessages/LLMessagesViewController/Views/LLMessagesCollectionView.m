//
//  LLMessagesCollectionView.m
//  LLMessages
//
//  Created by ruofei on 16/4/11.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "LLMessagesCollectionView.h"

#import "LLMessagesCollectionViewFlowLayout.h"
#import "LLMessagesCollectionViewCellIncoming.h"
#import "LLMessagesCollectionViewCellOutgoing.h"

@interface LLMessagesCollectionView ()
- (void)ll_configureCollectionView;
@end

@implementation LLMessagesCollectionView

@dynamic collectionViewLayout;
@dynamic dataSource;
@dynamic delegate;

#pragma mark -- Initialization

- (void)ll_configureCollectionView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.backgroundColor = [UIColor whiteColor];
    self.alwaysBounceVertical = YES;
    self.bounces = YES;
    
    [self registerClass:[LLMessagesCollectionViewCell class] forCellWithReuseIdentifier:[LLMessagesCollectionViewCell cellReuseIdentifier]];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self ll_configureCollectionView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self ll_configureCollectionView];
}

@end
