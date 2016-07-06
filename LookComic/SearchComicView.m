//
//  SearchComicView.m
//  LookComic
//
//  Created by 解梁 on 16/5/12.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "SearchComicView.h"

static NSString *searchComicCellId = @"SearchComicCellId";

@interface SearchComicView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@end

@implementation SearchComicView

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.dataSource = self;
        self.delegate = self;
        self.alwaysBounceVertical = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self registerNib:[UINib nibWithNibName:@"SearchComicCell" bundle:nil] forCellWithReuseIdentifier:searchComicCellId];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource 方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.topics.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchComicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:searchComicCellId forIndexPath:indexPath];
    cell.topic = self.topics[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopicsModel *topic = self.topics[indexPath.item];
    if ([self.viewDelegate respondsToSelector:@selector(searchComicView:didSelectedAtTopicID:)]) {
        [self.viewDelegate searchComicView:self didSelectedAtTopicID:topic.ID];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout方法

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth, 80);
}

#pragma mark - UIScrollViewDelegate方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.viewDelegate respondsToSelector:@selector(searchComicViewDidScroll:)]) {
        [self.viewDelegate searchComicViewDidScroll:self];
    }
}

#pragma mark - setter方法

- (void)setTopics:(NSArray *)topics
{
    _topics = topics;
    [self reloadData];
}

@end
