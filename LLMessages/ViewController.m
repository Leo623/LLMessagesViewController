//
//  ViewController.m
//  LLMessages
//
//  Created by ruofei on 16/4/11.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "ViewController.h"

#pragma mark -- 键盘
#import "ChatKeyBoard.h"
#import "MoreItem.h"
#import "ChatToolBarItem.h"
#import "FaceThemeModel.h"

#pragma mark -- 聊天UI
#import "LLMessagesCollectionView.h"
#import "LLMessagesCollectionViewFlowLayout.h"
#import "LLMessagesCollectionViewCell.h"

#define KSCREENHEIGHT  [[UIScreen mainScreen] bounds].size.height
#define KSCREENWIDTH   [[UIScreen mainScreen] bounds].size.width
@interface ViewController () <ChatKeyBoardDataSource, ChatKeyBoardDelegate, LLMessagesCollectionViewDelegateFlowLayout, LLMessagesCollectionViewDataSource>

/** 聊天键盘 */
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;

@property (nonatomic, strong) LLMessagesCollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LLMessagesCollectionViewFlowLayout *flowLayout = [[LLMessagesCollectionViewFlowLayout alloc] init];
    _collectionView = [[LLMessagesCollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT-49) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    
    self.chatKeyBoard = [ChatKeyBoard keyBoard];
    self.chatKeyBoard.delegate = self;
    self.chatKeyBoard.dataSource = self;
    
    [self.view addSubview:self.chatKeyBoard];
}

#pragma mark -- LLMessagesCollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 15;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LLMessagesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LLMessagesCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHue:arc4random_uniform(255)/255.f saturation:arc4random_uniform(255)/255.f brightness:arc4random_uniform(255)/255.f alpha:1.f];
    return cell;
}


#pragma mark -- ChatKeyBoardDataSource
- (NSArray<MoreItem *> *)chatKeyBoardMorePanelItems
{
    MoreItem *item1 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item2 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item3 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item4 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item5 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item6 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item7 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item8 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item9 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    return @[item1, item2, item3, item4, item5, item6, item7, item8, item9];

}

- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems
{
    ChatToolBarItem *item1 = [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"face" high:@"face_HL" select:@"keyboard"];
    
    ChatToolBarItem *item2 = [ChatToolBarItem barItemWithKind:kBarItemVoice normal:@"voice" high:@"voice_HL" select:@"keyboard"];
    
    ChatToolBarItem *item3 = [ChatToolBarItem barItemWithKind:kBarItemMore normal:@"more_ios" high:@"more_ios_HL" select:nil];
    
    ChatToolBarItem *item4 = [ChatToolBarItem barItemWithKind:kBarItemSwitchBar normal:@"switchDown" high:nil select:nil];
    
    return @[item1, item2, item3, item4];

}

- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems
{
    NSMutableArray *subjectArray = [NSMutableArray array];
    
    NSArray *sources = @[@"face", @"systemEmoji",@"emotion",@"systemEmoji",@"face",@"systemEmoji",@"emotion",@"emotion",@"face",@"face",@"emotion",@"face", @"emotion",@"face", @"emotion"];
    
    for (int i = 0; i < sources.count; ++i)
    {
        NSString *plistName = sources[i];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSDictionary *faceDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        NSArray *allkeys = faceDic.allKeys;
        
        FaceThemeModel *themeM = [[FaceThemeModel alloc] init];
        
        if ([plistName isEqualToString:@"face"]) {
            themeM.themeStyle = FaceThemeStyleCustomEmoji;
            themeM.themeDecribe = [NSString stringWithFormat:@"f%d", i];
            themeM.themeIcon = @"section0_emotion0";
        }else if ([plistName isEqualToString:@"systemEmoji"]){
            themeM.themeStyle = FaceThemeStyleSystemEmoji;
            themeM.themeDecribe = @"sEmoji";
            themeM.themeIcon = @"";
        }
        else {
            themeM.themeStyle = FaceThemeStyleGif;
            themeM.themeDecribe = [NSString stringWithFormat:@"e%d", i];
            themeM.themeIcon = @"f_static_000";
        }
        
        
        NSMutableArray *modelsArr = [NSMutableArray array];
        
        for (int i = 0; i < allkeys.count; ++i) {
            NSString *name = allkeys[i];
            FaceModel *fm = [[FaceModel alloc] init];
            fm.faceTitle = name;
            fm.faceIcon = [faceDic objectForKey:name];
            [modelsArr addObject:fm];
        }
        themeM.faceModels = modelsArr;
        
        [subjectArray addObject:themeM];
    }
    
    return subjectArray;
}


@end
