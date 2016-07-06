//
//  CTMediator+ComicStoreActions.m
//  LookComic
//
//  Created by 解梁 on 16/7/4.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "CTMediator+ComicStoreActions.h"

NSString *const kCTMediatorTargetComicStore = @"ComicStore";

NSString * const kCTMediatorActionNativFetchComicStoreController = @"nativeFetchComicStoreViewController";
NSString * const kCTMediatorActionNativFetchComicChapterController = @"nativeFetchComicChapterViewController";
NSString * const kCTMediatorActionNativFetchComicDetailController = @"nativeFetchComicDetailViewController";
NSString * const kCTMediatorActionNativFetchSectionMoreController = @"nativeFetchSectionMoreViewController";

@implementation CTMediator (ComicStoreActions)

//获取ComicStoreController控制器
- (UIViewController *)CTMediator_viewControllerForComicStore
{
    return [self CTMediator_viewControllerWithTarger:kCTMediatorTargetComicStore action:kCTMediatorActionNativFetchComicStoreController params:nil];
}

//获取ComicChapterController控制器
- (UIViewController *)CTMediator_viewControllerForComicChapter:(NSDictionary *)params
{
    return [self CTMediator_viewControllerWithTarger:kCTMediatorTargetComicStore action:kCTMediatorActionNativFetchComicChapterController params:params];
}

//获取ComicDetailController控制器
- (UIViewController *)CTMediator_viewControllerForComicDetail:(NSDictionary *)params
{
    return [self CTMediator_viewControllerWithTarger:kCTMediatorTargetComicStore action:kCTMediatorActionNativFetchComicDetailController params:params];
}

//获取SectionMoreController控制器
- (UIViewController *)CTMediator_viewControllerForSectionMore:(NSDictionary *)params
{
    return [self CTMediator_viewControllerWithTarger:kCTMediatorTargetComicStore action:kCTMediatorActionNativFetchSectionMoreController params:params];
}


@end
