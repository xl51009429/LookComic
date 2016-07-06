//
//  LeftImageContentView.m
//  LookComic
//
//  Created by 解梁 on 16/5/9.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "LeftImageContentView.h"
#import "LeftImageContentCell.h"
#import "TopicsModel.h"

@implementation LeftImageContentView

//重载父类方法
- (void)registerCell
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"LeftImageContentCell" bundle:nil] forCellWithReuseIdentifier:@"LeftImageContentCellId"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LeftImageContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LeftImageContentCellId" forIndexPath:indexPath];
    TopicsModel *topic = self.section.topics[indexPath.row];
    cell.model = topic;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = kScreenWidth - 10*2;
    return CGSizeMake(width, 70);
}

@end
