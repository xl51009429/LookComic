//
//  Target_ComicStore.h
//  LookComic
//
//  Created by 解梁 on 16/7/4.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Target_ComicStore : NSObject

- (UIViewController *)Action_nativeFetchComicStoreViewController:(NSDictionary *)params;

- (UIViewController *)Action_nativeFetchComicChapterViewController:(NSDictionary *)params;

- (UIViewController *)Action_nativeFetchComicDetailViewController:(NSDictionary *)params;

- (UIViewController *)Action_nativeFetchSectionMoreViewController:(NSDictionary *)params;

@end
