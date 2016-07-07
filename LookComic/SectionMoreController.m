//
//  SectionMoreController.m
//  LookComic
//
//  Created by 解梁 on 16/5/16.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "SectionMoreController.h"
#import "TopicsModel.h"
#import "SearchComicView.h"
#import "ComicChapterController.h"
#import <MJRefresh.h>

@interface SectionMoreController ()<SearchComicViewDelegate>

@property (nonatomic, strong)SearchComicView *comicView;
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, retain)NSMutableArray *myTopics;

@end

@implementation SectionMoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

//加载页面和数据
- (void)setup
{
    _index = 0;
    [self setupComicView];
    [self requestData];
    [self addRefresh];
}

//加载漫画列表页
- (void)setupComicView
{
    [self.view addSubview:self.comicView];
    self.title = _sectionTitle;
}

//请求网络数据
- (void)requestData
{
    [SVProgressHUD show];
    NSDictionary *param = @{@"limit": @(kSearchComicLimitCount),
                                                @"offset": @(kSearchComicLimitCount * self.index),
                                                @"tag": _sectionTitle};
    [[MGJRequestManager sharedInstance]GET:kSectionListInfoAPI parameters:param startImmediately:YES configurationHandler:nil completionHandler:^(NSError *error, id result, BOOL isFromCache, AFHTTPRequestOperation *operation) {
        NSDictionary *obj = (NSDictionary *)result;
        if (!error) {
            if ([obj[@"code"] isEqual:@200]) {
                if (self.index == 0) {
                    [self.myTopics removeAllObjects];
                }
                for (NSDictionary *dic in obj[@"data"][@"topics"]) {
                    TopicsModel *topic = [TopicsModel modelWithDictionary:dic];
                    [self.myTopics addObject:topic];
                }
                self.comicView.topics = self.myTopics;
                if (self.index > 0) {
                    [_comicView.mj_footer endRefreshing];  //停止上拉的菊花
                }else{
                    [_comicView.mj_header endRefreshing]; //停止下拉的菊花
                }
                if ([obj[@"data"][@"topics"] count] == 0) {
                    //无更多漫画
                    [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
                    [SVProgressHUD showInfoWithStatus:@"无更多漫画"];
                }else{
                    [SVProgressHUD dismiss];
                }
            }else{
                //返回错误状态码
                [SVProgressHUD showErrorWithStatus:@"请求错误"];
            }
        }else{
            //请求错误
            [SVProgressHUD showErrorWithStatus:@"请求错误"];
        }
    }];
}

//添加刷新
- (void)addRefresh
{
    __weak typeof(self) weakSelf = self;
    
    _comicView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.index = 0;
        [weakSelf requestData];
    }];
    
    _comicView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.index++;
        [weakSelf requestData];
    }];
}

#pragma mark - SearchComicViewDelegate方法

- (void)searchComicView:(SearchComicView *)searchComicView didSelectedAtTopicID:(NSNumber *)topicID
{
    ComicChapterController *comicChapter = [[ComicChapterController alloc]init];
    comicChapter.bookID = topicID;
    [self.navigationController pushViewController:comicChapter animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - getter方法

- (SearchComicView *)comicView
{
    if (_comicView == nil) {
        _comicView = [[SearchComicView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height - CGRectGetMaxY(self.navigationController.navigationBar.frame))];
        _comicView.viewDelegate = self;
    }
    return _comicView;
}

- (NSMutableArray *)myTopics
{
    if (_myTopics == nil) {
        _myTopics = [[NSMutableArray alloc]init];
    }
    return _myTopics;
}


@end
