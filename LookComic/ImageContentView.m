//
//  ImageContentView.m
//  LookComic
//
//  Created by 解梁 on 16/5/9.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "ImageContentView.h"
#import "ImageContentCell.h"
#import <UIImageView+WebCache.h>
#import "TopicsModel.h"

@implementation ImageContentView


- (void)registerCell
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageContentCell" bundle:nil] forCellWithReuseIdentifier:@"ImageContentCellId"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageContentCellId" forIndexPath:indexPath];
    TopicsModel *topic = self.section.topics[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.cover_image_url]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth, 100);
}

@end
