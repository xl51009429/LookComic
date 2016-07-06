//
//  Target_ComicCollect.m
//  LookComic
//
//  Created by 解梁 on 16/7/4.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "Target_ComicCollect.h"
#import "MyCollectionController.h"

@implementation Target_ComicCollect

- (UIViewController *)Action_nativeFetchCollectionViewController:(NSDictionary *)params
{
    MyCollectionController *collection = [[MyCollectionController alloc]init];
    return collection;
}

@end
