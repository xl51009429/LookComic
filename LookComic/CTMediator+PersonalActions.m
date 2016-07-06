//
//  CTMediator+PersonalActions.m
//  LookComic
//
//  Created by 解梁 on 16/7/4.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "CTMediator+PersonalActions.h"

NSString *const kCTMediatorTargetPersonal = @"Personal";

NSString * const kCTMediatorActionNativFetchPersonalController = @"nativeFetchPersonalController";
NSString * const kCTMediatorActionNativFetchLoginController = @"nativeFetchLoginController";

@implementation CTMediator (PersonalActions)

//获取PersonalController控制器
- (UIViewController *)CTMediator_viewControllerForPersonal
{
    return [self CTMediator_viewControllerWithTarger:kCTMediatorTargetPersonal action:kCTMediatorActionNativFetchPersonalController params:nil];
}

//获取LoginController控制器
- (UIViewController *)CTMediator_viewControllerForLogin
{
    return [self CTMediator_viewControllerWithTarger:kCTMediatorTargetPersonal action:kCTMediatorActionNativFetchLoginController params:nil];
}

@end
