//
//  ComicChaperController.m
//  LookComic
//
//  Created by 解梁 on 16/5/10.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "ComicChapterController.h"
#import "TopicsModel.h"
#import "ChapterListView.h"
#import "CTMediator+ComicStoreActions.h"

@interface ComicChapterController ()<ChapterListViewDelegate>

@property (nonatomic, strong)ChapterListView *chapterListView;

@end

@implementation ComicChapterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

//页面加载完成进行的操作
- (void)setup
{
    [self setupChapterListView];
    [self requestChapter];
}

//加载章节列表视图
- (void)setupChapterListView
{
    self.view.backgroundColor = [UIColor whiteColor];
    //self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.chapterListView];
}

//请求章节数据
- (void)requestChapter
{
    [SVProgressHUD show];
    [NetUtil GET:[kChapterListAPI stringByAppendingFormat:@"%@",_bookID] param:nil finish:^(NSData *data, NSDictionary *obj, NSError *error) {
        if (!error) {
            if ([obj[@"code"] isEqual:@200]) {
                TopicsModel *topic = [TopicsModel modelWithDictionary:obj[@"data"]];
                [self performSelectorOnMainThread:@selector(operateData:) withObject:topic waitUntilDone:NO];
            }else{
                //返回状态码错误
            }
        }else{
            NSLog(@"error:%@",error);
        }
    }];
}

//操作请求到的数据
- (void)operateData:(TopicsModel *)topic
{
    [SVProgressHUD dismiss];
    self.chapterListView.topic = topic;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - ChapterListViewDelegate

- (void)chapterListView:(ChapterListView *)chapterListView didSelectedAtChapterID:(NSNumber *)chapterID
{
//    ComicDetailController *comicDetail =[[ComicDetailController alloc]init];
//    comicDetail.chapterID = chapterID;
    UIViewController *comicDetail = [[CTMediator sharedInstance] CTMediator_viewControllerForComicDetail:@{@"chapterID":chapterID}];
    [self.navigationController pushViewController:comicDetail animated:YES];
}

#pragma mark - getter 方法

- (ChapterListView *)chapterListView
{
    if (_chapterListView == nil) {
        _chapterListView = [[ChapterListView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _chapterListView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        _chapterListView.backButtonEvent = ^{[weakSelf.navigationController popViewControllerAnimated:YES];};
        _chapterListView.chapterDelegate = self;
    }
    return _chapterListView;
}


@end
