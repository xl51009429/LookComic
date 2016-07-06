//
//  ComicStoreSectionListView.m
//  LookComic
//
//  Created by 解梁 on 16/5/6.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "ComicStoreSectionListView.h"
#import "ComicStoreHeaderView.h"
#import "ImageContentView.h"
#import "SectionModel.h"
#import "BaseSectionCell.h"
#import "TopImageContentView.h"
#import "LeftImageContentView.h"

@interface ComicStoreSectionListView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,BaseSectionCellDelegate>

@end

static NSString *headerIdentifier = @"headerIdentifierId";
static NSString *imageContentViewIdentifier = @"ImageContentViewId";
static NSString *topImageContentViewIdentifier = @"topImageContentViewId";
static NSString *leftImageContentViewIdentifier = @"leftImageContentViewId";


@implementation ComicStoreSectionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[ComicStoreHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
        [self registerClass:[ImageContentView class] forCellWithReuseIdentifier:imageContentViewIdentifier];
        [self registerClass:[TopImageContentView class] forCellWithReuseIdentifier:topImageContentViewIdentifier];
        [self registerClass:[LeftImageContentView class] forCellWithReuseIdentifier:leftImageContentViewIdentifier];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - UICollectionView的dataSource方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.sectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SectionModel *section = self.sectionArray[indexPath.row];
    BaseSectionCell *cell;
    if (section.type == 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:topImageContentViewIdentifier forIndexPath:indexPath];
    }else if (section.type == 1){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:topImageContentViewIdentifier forIndexPath:indexPath];
    }else if (section.type == 2){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:leftImageContentViewIdentifier forIndexPath:indexPath];
    }else if ((section.type - 3)%3==0){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:topImageContentViewIdentifier forIndexPath:indexPath];
    }else if ((section.type - 3)%3==1){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageContentViewIdentifier forIndexPath:indexPath];
    }else if ((section.type - 3)%3==2){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:leftImageContentViewIdentifier forIndexPath:indexPath];
    }
    cell.delegate = self;
    cell.section = section;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ComicStoreHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        header.bannerArray = _bannerArray;
        return header;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout代理方法

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, kHeaderHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SectionModel *section = self.sectionArray[indexPath.row];
    return CGSizeMake(kScreenWidth,section.contentCellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - BaseSectionCellDelegate方法

- (void)baseSectionCell:(BaseSectionCell *)baseSectionCell didSelectedAtBookID:(NSNumber *)bookID
{
    if ([self.comicDelegate respondsToSelector:@selector(comicStoreSectionListView:didSelectItemAtBookID:)]) {
        [self.comicDelegate comicStoreSectionListView:self didSelectItemAtBookID:bookID];
    }
}

- (void)baseSectionCell:(BaseSectionCell *)baseSectionCell didSelectedAtSectionTitle:(NSString *)sectionTitle
{
    if ([self.comicDelegate respondsToSelector:@selector(comicStoreSectionListView:didSelectItemAtSectionTitle:)]) {
        [self.comicDelegate comicStoreSectionListView:self didSelectItemAtSectionTitle:sectionTitle];
    }
}

#pragma mark - setter getter方法

-  (void)setBannerArray:(NSArray *)bannerArray
{
    _bannerArray = bannerArray;
    [self reloadData];
}

- (void)setSectionArray:(NSArray *)sectionArray
{
    _sectionArray = sectionArray;
    [self reloadData];
}

@end
