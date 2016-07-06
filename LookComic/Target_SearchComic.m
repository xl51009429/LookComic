//
//  Target_SearchComic.m
//  LookComic
//
//  Created by 解梁 on 16/7/4.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "Target_SearchComic.h"
#import "SearchComicController.h"

@implementation Target_SearchComic

- (UIViewController *)Action_nativeFetchSearchComicController:(NSDictionary *)params
{
    SearchComicController *searchComic = [[SearchComicController alloc]init];
    return searchComic;
}

@end
