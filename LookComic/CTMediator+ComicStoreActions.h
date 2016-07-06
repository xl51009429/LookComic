//
//  CTMediator+ComicStoreActions.h
//  LookComic
//
//  Created by 解梁 on 16/7/4.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "CTMediator.h"

@interface CTMediator (ComicStoreActions)

//获取ComicStoreController控制器 
- (UIViewController *)CTMediator_viewControllerForComicStore;

//获取ComicChapterController控制器 params 传 @{@"chapterID":chapterID}
- (UIViewController *)CTMediator_viewControllerForComicChapter:(NSDictionary *)params;

//获取ComicDetailController控制器 params 传 @{@"bookID":bookID}
- (UIViewController *)CTMediator_viewControllerForComicDetail:(NSDictionary *)params;

//获取SectionMoreController控制器 params 传 @{@"sectionTitle":sectionTitle}
- (UIViewController *)CTMediator_viewControllerForSectionMore:(NSDictionary *)params;

@end
