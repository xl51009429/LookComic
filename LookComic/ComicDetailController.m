//
//  ComicDetailController.m
//  LookComic
//
//  Created by 解梁 on 16/5/12.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "ComicDetailController.h"
#import "ChapterModel.h"
#import "ComicDetailView.h"

@interface ComicDetailController ()

@property (nonatomic, strong)ComicDetailView *detailView;
@property (nonatomic, retain)ChapterModel *chapter;

@end

@implementation ComicDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

//加载界面
- (void)setup
{
    [self.view addSubview:self.detailView];
    [self requestData];
}

//请求数据
- (void)requestData
{
    if (_chapterID) {
        [[MGJRequestManager sharedInstance]GET:[kComicDetailAPI stringByAppendingFormat:@"%@",self.chapterID] parameters:nil startImmediately:YES configurationHandler:nil completionHandler:^(NSError *error, id result, BOOL isFromCache, AFHTTPRequestOperation *operation) {
            NSDictionary *obj = (NSDictionary *)result;
            if (!error) {
                if ([obj[@"code"] isEqual:@200]) {
                    ChapterModel *chapter = [ChapterModel modelWithDictionary:obj[@"data"]];
                    [self performSelectorOnMainThread:@selector(operateData:) withObject:chapter waitUntilDone:NO];
                }else{
                    //返回错误状态吗
                }
            }else{
                //请求错误
                NSLog(@"%@",error);
            }
        }];
    }
}

//操作数据
- (void)operateData:(ChapterModel *)chapter
{
    self.chapter = chapter;
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (NSString *imageUrl in chapter.images) {
        ImageModel *image = [[ImageModel alloc]init];
        image.imageUrl = imageUrl;
        [images addObject:image];
    }
    self.detailView.images = images;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - setter getter方法

- (ComicDetailView *)detailView
{
    if (_detailView == nil) {
        _detailView = [[ComicDetailView alloc]initWithFrame:self.view.bounds];
    }
    return _detailView;
}

- (void)setChapter:(ChapterModel *)chapter
{
    self.title = chapter.title;
}

@end
