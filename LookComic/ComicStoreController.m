//
//  ComicStoreController.m
//  LookComic
//
//  Created by 解梁 on 16/5/6.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "ComicStoreController.h"
#import "BannerModel.h"
#import "ComicStoreSectionListView.h"
#import "SectionModel.h"
#import "TopicsModel.h"
#import "Animator.h"
#import "CTMediator+ComicStoreActions.h"

@interface ComicStoreController ()<ComicStoreSectionListViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong)ComicStoreSectionListView *sectionListView;
@property (nonatomic, copy)NSMutableArray *bannerArray;
@property (nonatomic, copy)NSMutableArray *sectionArray;

@end

@implementation ComicStoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

//页面加载完毕处理事件
- (void)setup
{
    [self setupListView];
    [self requestBanner];
    [self requestSectionList];
    [self setStatusBar];
}

//创建主视图view
- (void)setupListView
{
    [self.view addSubview:self.sectionListView];
}

//请求轮播图
- (void)requestBanner
{
    __weak typeof(self) weakSelf = self;
    //请求banner
    [SVProgressHUD show];
    [NetUtil GET:kBannersAPI param:nil finish:^(NSData *data, NSDictionary *obj, NSError *error) {
        if (!error) {
            if ([obj[@"code"] isEqual:@200]) {
                for (NSDictionary *dic in obj[@"data"][@"banner_group"]) {
                    BannerModel *banner = [BannerModel modelWithDictionary:dic];
                    [self.bannerArray addObject:banner];
                }
                [weakSelf setupBanners];
            }else{
                //请求失败
                
            }
        }else{
            NSLog(@"error:%@",error);
        }
    }];
}

//请求内容列表
- (void)requestSectionList
{
    [NetUtil GET:kSectionListTitleAPI param:nil finish:^(NSData *data, NSDictionary *obj, NSError *error) {
        if (!error) {
            if ([obj[@"code"] isEqual:@200]) {
                for (NSDictionary *dic in obj[@"data"][@"suggestion"]) {
                    SectionModel *section = [SectionModel modelWithDictionary:dic];
                    [self.sectionArray addObject:section];
                }
                self.sectionListView.sectionArray =  self.sectionArray;
                [SVProgressHUD dismiss];
                //请求cell中的cell列表
                [self.sectionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    SectionModel *section = (SectionModel *)obj;
                    section.type = idx;
                    NSDictionary *param = @{@"limit": @(section.contentCount),
                                            @"offset": @0,
                                            @"tag": section.title};
                    [NetUtil GET:kSectionListInfoAPI param:param finish:^(NSData *data, NSDictionary *obj, NSError *error) {
                        if (!error) {
                            if ([obj[@"code"] isEqual:@200]) {
                                NSMutableArray *topics = [[NSMutableArray alloc]init];
                                for (NSDictionary *dic in obj[@"data"][@"topics"]) {
                                    TopicsModel *topic = [TopicsModel modelWithDictionary:dic];
                                    [topics addObject:topic];
                                }
                                section.topics = topics;
                            }else{
                                //请求错误
                            }
                        }else{
                            NSLog(@"error:%@",error);
                        }
                    }];
                }];
            }else{
                //请求错误
            }
        }else{
            NSLog(@"error:%@",error);
        }
    }];
}

//设置轮播图的数据源
- (void)setupBanners
{
    self.sectionListView.bannerArray = self.bannerArray;
}

//设置状态栏的颜色
- (void)setStatusBar
{
    CALayer *backLayer = [CALayer layer];
    backLayer.frame = CGRectMake(0, 0, kScreenWidth, 20);
    backLayer.backgroundColor = UIColorFromRGB(0xFFBF00).CGColor;
    backLayer.zPosition = 10;
    [self.view.layer addSublayer:backLayer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - ComicStoreSectionListViewDelegate

- (void)comicStoreSectionListView:(ComicStoreSectionListView *)comicStoreSectionListView didSelectItemAtBookID:(NSNumber *)bookID
{
    //self.navigationController.delegate = self;
    UIViewController *comicChapter = [[CTMediator sharedInstance]CTMediator_viewControllerForComicChapter:@{@"bookID":bookID}];
    [self.navigationController pushViewController:comicChapter animated:YES];
}

- (void)comicStoreSectionListView:(ComicStoreSectionListView *)comicStoreSectionListView didSelectItemAtSectionTitle:(NSString *)sectionTitle
{
    UIViewController *sectionMore = [[CTMediator sharedInstance] CTMediator_viewControllerForSectionMore:@{@"sectionTitle":sectionTitle}];
    [self.navigationController pushViewController:sectionMore animated:YES];
}

//返回转场动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
//    return [Animator new];
    return nil;
}

#pragma mark - setter getter方法

- (ComicStoreSectionListView *)sectionListView
{
    if (_sectionListView == nil) {
        _sectionListView = [[ComicStoreSectionListView alloc]initWithFrame:self.view.bounds];
        _sectionListView.comicDelegate = self;
    }
    return _sectionListView;
}

- (NSMutableArray *)bannerArray
{
    if (_bannerArray == nil) {
        _bannerArray = [[NSMutableArray alloc]init];
    }
    return _bannerArray;
}

- (NSMutableArray *)sectionArray
{
    if (_sectionArray == nil) {
        _sectionArray = [[NSMutableArray alloc]init];
    }
    return _sectionArray;
}

@end
