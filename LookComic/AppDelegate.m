//
//  AppDelegate.m
//  LookComic
//
//  Created by 解梁 on 16/5/5.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "AppDelegate.h"
#import "XLTabBarController.h"
#import <UMSocial.h>
#import <UMSocialSinaSSOHandler.h>
#import "XLSandbox.h"
#import <JPEngine.h>
#import <Appirater.h>
#import "CTMediator.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    XLTabBarController *tabC = [[XLTabBarController alloc]init];
    self.window.rootViewController = tabC;
    
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"menu_bk_partten"] forBarMetrics:UIBarMetricsDefault];
    
    [self.window makeKeyAndVisible];
    
    //生成唯一标示
    [self getUUID];
    
    //UMeng
    [self setupUMeng];
    
    //JSPatch
    [self setupJSPatch];
    
    //打分
    [self setupAppirater];
    
    return YES;
}

//获取唯一标示
- (void)getUUID
{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"uuid"]) {
        NSString *uuid = GetUUIDString();
        [[NSUserDefaults standardUserDefaults]setObject:uuid forKey:@"uuid"];
    }
}

//设置UMeng 第三方登录
- (void)setupUMeng
{
    //设置UM appkey
    [UMSocialData setAppKey:@"57453c0be0f55a21b0000d54"];
    
    //设置应用app id
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:kWeiBoAppKey secret:@"94e074729c361b705ebdff3f1029e0fa" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

//JSPatch
- (void)setupJSPatch
{
//    [JPEngine startEngine];
//    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://cnbang.net/test.js"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        NSString *script = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        [JPEngine evaluateScript:script];
//    }];
}

//Appirater打分
- (void)setupAppirater
{
    [Appirater setAppId:@"1116602899"];
    [Appirater setDaysUntilPrompt:3];
    [Appirater setUsesUntilPrompt:3];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:2];
    [Appirater setDebug:YES];
    [Appirater appLaunched:YES];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [Appirater appEnteredForeground:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options
{
    return [[[CTMediator sharedInstance]performActionWithUrl:url completion:nil] boolValue];
}

@end
