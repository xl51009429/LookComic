//
//  CTMediator+PersonalActions.h
//  LookComic
//
//  Created by 解梁 on 16/7/4.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "CTMediator.h"

@interface CTMediator (PersonalActions)

//获取PersonalController控制器
- (UIViewController *)CTMediator_viewControllerForPersonal;

//获取LoginController控制器
- (UIViewController *)CTMediator_viewControllerForLogin;

@end
