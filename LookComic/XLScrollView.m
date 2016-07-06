//
//  XLScrollView.m
//  LunBoDemo
//
//  Created by 解梁 on 16/3/8.
//  Copyright © 2016年 XieLiang. All rights reserved.
//

#import "XLScrollView.h"
#import <UIImageView+WebCache.h>
#import "XLImageItem.h"

@interface XLScrollView ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *_dataSourse;
    UIPageControl *_pageControl;
    NSTimer *_timer;
    UICollectionView *_collection;
}

@end

@implementation XLScrollView

- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray *)images
{
    if (self = [super initWithFrame:frame]) {
        //初始化数据源
        _dataSourse = [[NSMutableArray alloc]initWithArray:images];
        
        //初始化时间间隔 默认4秒
        _timeInterval = 4.0;
        
        //使用系统布局
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.minimumInteritemSpacing = 0;
        flow.minimumLineSpacing = 0;
        
        //初始化collection
        _collection = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:flow];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.pagingEnabled = YES;
        [_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_dataSourse.count*500 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        _collection.showsHorizontalScrollIndicator = NO;
        [self addSubview:_collection];
        
        //注册cell
        [_collection registerNib:[UINib nibWithNibName:@"XLImageItem" bundle:nil] forCellWithReuseIdentifier:@"XLImageItemID"];
        
        //初始化pageControl
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.backgroundColor = [UIColor blackColor];
        _pageControl.center = CGPointMake(self.frame.size.width*.5, self.frame.size.height - 10);
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.numberOfPages = _dataSourse.count;
        [self addSubview:_pageControl];
        
        //开启定时器
        [self startTimer];
    }
    return self;
}

#pragma -mark collectionView代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  _dataSourse.count*10000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XLImageItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLImageItemID" forIndexPath:indexPath];
    [item.imageView sd_setImageWithURL:[NSURL URLWithString:_dataSourse[indexPath.item%_dataSourse.count]] placeholderImage:[UIImage imageNamed:self.defaultImage]];
    return item;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.bounds.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(xlScrollView:didSelectItemAtIndex:)]) {
        [self.delegate xlScrollView:self didSelectItemAtIndex:indexPath.item%_dataSourse.count];
    }
}

/**
 *  开启定时器
 */
- (void)startTimer
{
    _timer = [NSTimer timerWithTimeInterval:_timeInterval target:self selector:@selector(operateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

/**
 *  关闭定时器
 */
- (void)endTimer
{
    [_timer invalidate];
    _timer = nil;
}

/**
 *  定时器触发方法
 */
- (void)operateTimer
{
    NSIndexPath *indexPath = [_collection indexPathsForVisibleItems][0];
    if (indexPath.item == _dataSourse.count*1000-1) {
        [_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_dataSourse.count*500 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }else{
        [_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item+1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

/**
 *  开始拖拽的时候调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止定时器(一旦定时器停止了,就不能再使用)
    [self endTimer];
}

/**
 *  停止拖拽的时候调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 开启定时器
    [self startTimer];
}

/**
 *  翻页
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    NSInteger page = _dataSourse.count == 0?0:((int)((scrollView.contentOffset.x + width*0.5)/width))%_dataSourse.count;
    _pageControl.currentPage = page;
}

/**
 *  修改时间间隔，重启定时器
 */
- (void)setTimeInterval:(NSTimeInterval)timeInterval
{
    _timeInterval = timeInterval;
    [self endTimer];
    [self startTimer];
}

/**
 *  修改轮播图图片数据源
 *
 *  @param images 数据源数组
 */
- (void)setImages:(NSArray *)images
{
    [self endTimer];
    _images = images;
    [_dataSourse removeAllObjects];
    [_dataSourse addObjectsFromArray:images];
    [_collection reloadData];
//    [_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_dataSourse.count*500 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    _pageControl.numberOfPages = _dataSourse.count;
    [self startTimer];
}

@end
