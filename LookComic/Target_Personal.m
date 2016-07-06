//
//  Target_Personal.m
//  LookComic
//
//  Created by 解梁 on 16/7/4.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "Target_Personal.h"
#import "PersonalController.h"
#import "LoginController.h"

@implementation Target_Personal

- (UIViewController *)Action_nativeFetchPersonalController:(NSDictionary *)params
{
    PersonalController *personal = [[PersonalController alloc]init];
    return personal;
}

- (UIViewController *)Action_nativeFetchLoginController:(NSDictionary *)params
{
    LoginController *login = [[LoginController alloc]init];
    return login;
}

@end
