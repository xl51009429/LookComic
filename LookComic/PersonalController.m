//
//  PersonalController.m
//  LookComic
//
//  Created by 解梁 on 16/5/25.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "PersonalController.h"
#import "PersonalView.h"
#import "CTMediator+PersonalActions.h"

@interface PersonalController ()<PersonalViewDelegate>

@property (nonatomic, strong)PersonalView *personalView;

@end

@implementation PersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

//加载视图
- (void)setupView
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.view addSubview:self.personalView];
}

#pragma mark - PersonalViewDelegate

- (void)iconButtonClickedInPersonalView:(PersonalView *)personalView
{
    //头像按钮被点击，判断是否登录
    UIViewController *login = [[CTMediator sharedInstance]CTMediator_viewControllerForLogin];
    [self presentViewController:login animated:YES completion:nil];
}

- (void)PersonalView:(PersonalView *)personalView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - getter方法

- (PersonalView *)personalView
{
    if (_personalView == nil) {
        _personalView = [[PersonalView alloc]initWithFrame:CGRectMake(0, -[UIApplication sharedApplication].statusBarFrame.size.height, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _personalView.personalDelegate = self;
    }
    return _personalView;
}

@end
