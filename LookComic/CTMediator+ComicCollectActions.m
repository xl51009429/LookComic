//
//  CTMediator+ComicCollectActions.m
//  LookComic
//
//  Created by 解梁 on 16/7/4.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "CTMediator+ComicCollectActions.h"

NSString *const kCTMediatorTargetComicCollect = @"ComicCollect";

NSString * const kCTMediatorActionNativFetchCollectionViewController = @"nativeFetchCollectionViewController";

@implementation CTMediator (ComicCollectActions)

//获取ComicStoreController控制器
- (UIViewController *)CTMediator_viewControllerForComicCollection
{
    return [self CTMediator_viewControllerWithTarger:kCTMediatorTargetComicCollect action:kCTMediatorActionNativFetchCollectionViewController params:nil];
}

@end
