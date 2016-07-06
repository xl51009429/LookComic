//
//  MyCollectionController.m
//  LookComic
//
//  Created by 解梁 on 16/5/16.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "MyCollectionController.h"
#import "MyCollectionView.h"
#import "NetUtil.h"
#import "DBUtil.h"
#import <MJRefresh.h>
#import <Masonry.h>
#import "CTMediator+ComicStoreActions.h"

@interface MyCollectionController ()<MyCollectionViewDelegate>

@property (nonatomic, strong)MyCollectionView *collectionView;
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *tipLabel;

@end

@implementation MyCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

//加载页面和数据
- (void)setup
{
    [self setupUI];
    [self makeConstraints];
    [self requestData];
    [self setupRefresh];
}

//加载界面
- (void)setupUI
{
    self.title = @"我的关注";
    [self.view addSubview:self.collectionView];
    [self.collectionView addSubview:self.imageView];
    [self.collectionView addSubview:self.tipLabel];
}

- (void)makeConstraints
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 200));
        make.left.mas_equalTo(self.collectionView.mas_left).offset(0);
        make.top.mas_equalTo(self.collectionView.mas_top).offset(0);
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 20));
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.collectionView.mas_left).offset(0);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, self.tabBarController.tabBar.frame.size.height, 0));
    }];
}

//添加下拉刷新
- (void)setupRefresh
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
}

//请求收藏数据
- (void)requestData
{
    [SVProgressHUD show];
    self.collectionView.topics = [NSMutableArray arrayWithArray:[[DBUtil sharedDBUtil] selectAllCollectionTopics]];
    if (self.collectionView.topics.count == 0) {
        self.tipLabel.hidden = NO;
        self.imageView.hidden = NO;
    }else{
        self.tipLabel.hidden = YES;
        self.imageView.hidden = YES;
    }
    [self.collectionView.mj_header endRefreshing];
    [SVProgressHUD dismiss];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - MyCollectionViewDelegate方法

- (void)myCollectionView:(MyCollectionView *)myCollectionView didSelectedAtTopicID:(NSNumber *)topicID
{
    UIViewController *comicChapter = [[CTMediator sharedInstance] CTMediator_viewControllerForComicChapter:@{@"bookID":topicID}];
    [self.navigationController pushViewController:comicChapter animated:YES];
}

#pragma mark - getter方法

- (MyCollectionView *)collectionView
{
    if (_collectionView == nil) {
        _collectionView = [[MyCollectionView alloc]init];
        _collectionView.viewDelegate = self;
    }
    return _collectionView;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeCenter;
        _imageView.image = [UIImage imageNamed:@"ic_search_empty_82x104_"];
    }
    return _imageView;
}

- (UILabel *)tipLabel
{
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc]init];
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.textColor = [UIColor grayColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"暂无关注的漫画!";
    }
    return _tipLabel;
}

@end
