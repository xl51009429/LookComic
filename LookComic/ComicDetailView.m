//
//  ComicDetailView.m
//  LookComic
//
//  Created by 解梁 on 16/5/12.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "ComicDetailView.h"
#import "ComicImageCell.h"
#import <UIImageView+WebCache.h>

static NSString *comicImageCellId = @"ComicImageCellId";

@interface ComicDetailView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@end

@implementation ComicDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerNib:[UINib nibWithNibName:@"ComicImageCell" bundle:nil] forCellWithReuseIdentifier:comicImageCellId];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ComicImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:comicImageCellId forIndexPath:indexPath];
    ImageModel *imageModel = self.images[indexPath.item];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.imageUrl] placeholderImage:[UIImage imageNamed:@"community_cover_item"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (imageModel.height == 0) {
            imageModel.height = image.size.height *image.size.width/kScreenWidth;
            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }
    }];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth, 300);
}

#pragma mark - setter 方法

- (void)setImages:(NSArray *)images
{
    _images = images;
    [self reloadData];
}

@end
