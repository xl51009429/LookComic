//
//  SearchComicController.m
//  LookComic
//
//  Created by 解梁 on 16/5/12.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "SearchComicController.h"
#import "SearchComicView.h"
#import "SearchBar.h"
#import "CTMediator+ComicStoreActions.h"

@interface SearchComicController ()<SearchBarDelegate,SearchComicViewDelegate>

@property (nonatomic, strong)SearchComicView *searchComicView;
@property (nonatomic, strong)SearchBar *searchBar;
@property (nonatomic, strong)UIImageView *noResultImageView;
@property (nonatomic, strong)UILabel *tipLabel;

@end

@implementation SearchComicController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

//加载界面
- (void)setup
{
    [self.view addSubview:self.noResultImageView];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.searchComicView];
    self.navigationItem.titleView = self.searchBar;
}

//网络请求数据
- (void)requestData:(NSString *)keyword
{
    NSDictionary *dic = @{@"keyword":keyword,
                          @"limit":@(kSearchComicLimitCount),
                          @"offset":@0};
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    [[MGJRequestManager sharedInstance]GET:kSearchComicAPI parameters:dic startImmediately:YES configurationHandler:nil completionHandler:^(NSError *error, id result, BOOL isFromCache, AFHTTPRequestOperation *operation) {
        NSDictionary *obj = (NSDictionary *)result;
        if (!error) {
            if ([obj[@"code"] isEqual:@200]) {
                [SVProgressHUD dismiss];
                NSMutableArray *topics = [[NSMutableArray alloc]init];
                for (NSDictionary *dic in obj[@"data"][@"topics"]) {
                    TopicsModel *topic = [TopicsModel modelWithDictionary:dic];
                    [topics addObject:topic];
                }
                [weakSelf operateDate:topics];
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

//对网络获取的数据进行处理
- (void)operateDate:(NSArray *)topics
{
    _searchComicView.hidden = topics.count == 0;
    self.searchComicView.topics = topics;
}

//触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.searchBar resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - SearchComicViewDelegate方法

- (void)searchComicView:(SearchComicView *)searchComicView didSelectedAtTopicID:(NSNumber *)topicID
{
    [self.searchBar resignFirstResponder];
    UIViewController *comicChapter = [[CTMediator sharedInstance] CTMediator_viewControllerForComicChapter:@{@"bookID":topicID}];
    [self.navigationController pushViewController:comicChapter animated:YES];
}

- (void)searchComicViewDidScroll:(SearchComicView *)searchComicView
{
    [self.searchBar resignFirstResponder];
}

#pragma mark - SearchBarDelegate方法

- (void)searchBar:(SearchBar *)searchBar didChangedWithValue:(NSString *)value
{
    [self requestData:value];
}

- (void)searchBarHaveNilValue:(SearchBar *)searchBar
{
    self.searchComicView.topics = nil;
    [self.searchComicView reloadData];
}

#pragma mark - getter方法

- (SearchComicView *)searchComicView
{
    if (_searchComicView == nil) {
        _searchComicView = [[SearchComicView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - CGRectGetMaxY(self.navigationController.navigationBar.frame))];
        _searchComicView.viewDelegate = self;
    }
    return _searchComicView;
}

- (SearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[SearchBar alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
        _searchBar.barDelegate = self;
    }
    return _searchBar;
}

- (UIImageView *)noResultImageView
{
    if (_noResultImageView == nil) {
        _noResultImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        _noResultImageView.image = [UIImage imageNamed:@"ic_search_empty_82x104_"];
        _noResultImageView.contentMode = UIViewContentModeCenter;
    }
    return _noResultImageView;
}

- (UILabel *)tipLabel
{
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, kScreenWidth, 30)];
        _tipLabel.text = @"亲，没有找到您想要的结果！";
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textColor = [UIColor grayColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

@end
