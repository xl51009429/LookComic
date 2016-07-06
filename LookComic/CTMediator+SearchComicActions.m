//
//  CTMediator+SearchComicActions.m
//  LookComic
//
//  Created by 解梁 on 16/7/4.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "CTMediator+SearchComicActions.h"

NSString *const kCTMediatorTargetSearchComic = @"SearchComic";

NSString * const kCTMediatorActionNativFetchSearchComicController = @"nativeFetchSearchComicController";

@implementation CTMediator (SearchComicActions)

- (UIViewController *)CTMediator_viewControllerForSearchComic
{
    return [self CTMediator_viewControllerWithTarger:kCTMediatorTargetSearchComic action:kCTMediatorActionNativFetchSearchComicController params:nil];
}

@end
