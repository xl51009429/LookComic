//
//  XLTabBarController.m
//  LookComic
//
//  Created by 解梁 on 16/5/5.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "XLTabBarController.h"
#import "XLNavigationController.h"
#import "CTMediator+PersonalActions.h"
#import "CTMediator+ComicStoreActions.h"
#import "CTMediator+SearchComicActions.h"
#import "CTMediator+ComicCollectActions.h"

@interface XLTabBarController ()

@end

@implementation XLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupController];
    [self selectDefault];
}

//设置tabbarcontroller的controllers
- (void)setupController
{
    //我的关注
    UIViewController *collection = [[CTMediator sharedInstance] CTMediator_viewControllerForComicCollection];
    XLNavigationController *collectionNav = [[XLNavigationController alloc]initWithRootViewController:collection];
    collectionNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"关注" image:[UIImage imageNamed:@"tab1_nor"] selectedImage:[UIImage imageNamed:@"tab1_sel"]];
    
    //漫画城
    UIViewController *comicStore = [[CTMediator sharedInstance] CTMediator_viewControllerForComicStore];
    XLNavigationController *comicStoreNav = [[XLNavigationController alloc]initWithRootViewController:comicStore];
    comicStoreNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"漫画城" image:[UIImage imageNamed:@"tab2_nor"] selectedImage:[UIImage imageNamed:@"tab2_sel"]];
    
    //搜索漫画
    UIViewController *searchComic = [[CTMediator sharedInstance] CTMediator_viewControllerForSearchComic];
    XLNavigationController *searchComicNav = [[XLNavigationController alloc]initWithRootViewController:searchComic];
    searchComicNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"搜索" image:[UIImage imageNamed:@"tab4_nor"] selectedImage:[UIImage imageNamed:@"tab4_sel"]];
    
    //个人中心
    UIViewController *personal = [[CTMediator sharedInstance] CTMediator_viewControllerForPersonal];
    XLNavigationController *personalNav = [[XLNavigationController alloc]initWithRootViewController:personal];
    personalNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"ic_tabbar_me_normal_30x30_"] selectedImage:[UIImage imageNamed:@"ic_tabbar_me_pressed_30x30_"]];
    
    //添加控制器
    self.viewControllers = @[collectionNav,comicStoreNav,searchComicNav,personalNav];
}

//设置默认选中的tabbar
- (void)selectDefault
{
    self.selectedIndex = 1;
    self.tabBar.tintColor = [UIColor orangeColor];
}

@end
