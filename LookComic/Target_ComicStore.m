//
//  Target_ComicStore.m
//  LookComic
//
//  Created by 解梁 on 16/7/4.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "Target_ComicStore.h"
#import "ComicChapterController.h"
#import "ComicDetailController.h"
#import "SectionMoreController.h"
#import "ComicStoreController.h"

@implementation Target_ComicStore

- (UIViewController *)Action_nativeFetchComicStoreViewController:(NSDictionary *)params
{
    ComicStoreController *comicStoreController = [[ComicStoreController alloc]init];
    return comicStoreController;
}

- (UIViewController *)Action_nativeFetchComicChapterViewController:(NSDictionary *)params
{
    ComicChapterController *comicChapterController = [[ComicChapterController alloc]init];
    comicChapterController.bookID = params[@"bookID"];
    return comicChapterController;
}

- (UIViewController *)Action_nativeFetchComicDetailViewController:(NSDictionary *)params
{
    ComicDetailController *comicDetailController = [[ComicDetailController alloc]init];
    comicDetailController.chapterID = params[@"chapterID"];
    return comicDetailController;
}

- (UIViewController *)Action_nativeFetchSectionMoreViewController:(NSDictionary *)params
{
    SectionMoreController *sectionMoreController = [[SectionMoreController alloc]init];
    sectionMoreController.sectionTitle = params[@"sectionTitle"];
    return sectionMoreController;
}

@end
