//
//  ChapterListView.m
//  LookComic
//
//  Created by 解梁 on 16/5/10.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "ChapterListView.h"
#import "ComicChapterFlowLayout.h"
#import "ChapterListCell.h"
#import "ChapterSectionHeaderView.h"
#import "ChapterAuthorCell.h"

static NSString *chapterAuthorCellId = @"ChapterAuthorCellId";
static NSString *chapterListCellId = @"ChapterListCellId";
static NSString *chapterSectionHeaderViewId = @"ChapterSectionHeaderViewId";
static NSString *chapterMainHeaderViewId = @"ChapterMainHeaderViewId";

@interface ChapterListView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ChapterSectionHeaderViewDelegate>

@property (nonatomic,retain)NSArray *chapterArray;          //章节正序数组
@property (nonatomic,assign)BOOL daoxuFlag;                 //倒序标志
@property (nonatomic,assign)BOOL contentFlag;               //显示内容标志
@property (nonatomic,assign)CGFloat headerHeight;           //头视图高度

@end
@implementation ChapterListView

- (instancetype)initWithFrame:(CGRect)frame
{
    ComicChapterFlowLayout *layout = [[ComicChapterFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        self.alwaysBounceVertical = YES;
        [self initFlag];
        [self registerView];
    }
    return self;
}

//初始化标志位
- (void)initFlag
{
    _daoxuFlag = YES;
    _contentFlag = YES;
    _headerHeight = 90.0;
}

//注册cell  和  头视图
- (void)registerView
{
    [self registerNib:[UINib nibWithNibName:@"ChapterListCell" bundle:nil] forCellWithReuseIdentifier:chapterListCellId];
    [self registerNib:[UINib nibWithNibName:@"ChapterAuthorCell" bundle:nil] forCellWithReuseIdentifier:chapterAuthorCellId];
    [self registerClass:[ChapterSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:chapterSectionHeaderViewId];
    [self registerClass:[ChapterMainHeaderView class] forSupplementaryViewOfKind:chapterMainHeaderViewKind withReuseIdentifier:chapterMainHeaderViewId];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _contentFlag?_daoxuFlag?self.topic.comics.count:self.chapterArray.count:1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    if (_contentFlag) {
        ChapterListCell *listCell = [collectionView dequeueReusableCellWithReuseIdentifier:chapterListCellId forIndexPath:indexPath];
        listCell.chapter = _daoxuFlag?self.topic.comics[indexPath.item]:self.chapterArray[indexPath.item];
        cell = listCell;
    }else{
        ChapterAuthorCell *authorCell = [collectionView dequeueReusableCellWithReuseIdentifier:chapterAuthorCellId forIndexPath:indexPath];
        authorCell.user = self.topic.user;
        cell = authorCell;
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reuseableView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ChapterSectionHeaderView *headerView = [self dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:chapterSectionHeaderViewId forIndexPath:indexPath];
        headerView.delegate = self;
        headerView.descri = self.topic.descri;
        reuseableView = headerView;
    }else if ([kind isEqualToString:chapterMainHeaderViewKind]){
        ChapterMainHeaderView *mainView = [self dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:chapterMainHeaderViewId forIndexPath:indexPath];
        mainView.topic = self.topic;
        if (self.backButtonEvent) {
            mainView.backButtonEvent = _backButtonEvent;
        }
        reuseableView = mainView;
    }
    return reuseableView;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_contentFlag) {
        //点击查看一章的详情
        ChapterModel *chapter = self.topic.comics[indexPath.item];
        if ([self.chapterDelegate respondsToSelector:@selector(chapterListView:didSelectedAtChapterID:)]) {
            [self.chapterDelegate chapterListView:self didSelectedAtChapterID:chapter.ID];
        }
    }else{
        //点击查看作者详情
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return _contentFlag?CGSizeMake(kScreenWidth, 90):CGSizeMake(kScreenWidth, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, _headerHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - ChapterSectionHeaderViewDelegate

- (void)chapterSectionHeaderView:(ChapterSectionHeaderView *)chapterSectionHeaderView didSelectedAtIndex:(ChapterSectionHeaderButtonKind)index headerViewHeight:(CGFloat)height
{
    switch (index) {
        case ChapterSectionHeaderSummaryKind:             //简介按钮点击
            _contentFlag = NO;
            _headerHeight = height;
            [self reloadData];
            break;
        case ChapterSectionHeaderContentKind:             //内容按钮点击
            _contentFlag = YES;
            _headerHeight = height;
            [self reloadData];
            break;
        case ChapterSectionHeaderSortKind:                //排序按钮点击
            _daoxuFlag = !_daoxuFlag;
            [self reloadData];
            break;
        default:
            break;
    }
}

#pragma mark - setter getter 方法

- (void)setTopic:(TopicsModel *)topic
{
    _topic = topic;
    //正序数组赋值
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.chapterArray = [[topic.comics reverseObjectEnumerator] allObjects];
    });
    [self reloadData];
}



@end
