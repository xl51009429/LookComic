//
//  TopImageContentView.m
//  LookComic
//
//  Created by 解梁 on 16/5/9.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "TopImageContentView.h"
#import "TopImageContentCell.h"
#import "TopicsModel.h"

@implementation TopImageContentView

- (void)registerCell
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"TopImageContentCell" bundle:nil] forCellWithReuseIdentifier:@"TopImageContentCellId"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopImageContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopImageContentCellId" forIndexPath:indexPath];
    TopicsModel *topic = self.section.topics[indexPath.row];
    cell.model = topic;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.section.type == 0) {
        return CGSizeMake(110, 80);
    }
    CGFloat width = (kScreenWidth - 10 * 3)/2.0;
    return CGSizeMake(width, 100);
}

@end
