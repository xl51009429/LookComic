//
//  HeaderView.m
//  LookComic
//
//  Created by 解梁 on 16/5/6.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "ComicStoreHeaderView.h"
#import "XLScrollView.h"
#import "BannerModel.h"

@interface ComicStoreHeaderView ()

@property (nonatomic, strong)XLScrollView *scrollView;

@end
@implementation ComicStoreHeaderView

- (void)layoutSubviews
{
    _scrollView = [[XLScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeaderHeight) imgArray:@[@"community_cover_item"]];
    _scrollView.defaultImage = @"community_cover_item";
    [self addSubview:_scrollView];
    self.backgroundColor = [UIColor redColor];
}

- (void)setBannerArray:(NSArray *)bannerArray
{
    _bannerArray = bannerArray;
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (BannerModel *banner in _bannerArray) {
        [images addObject:banner.pic];
    }
    _scrollView.images = images;
}

@end
