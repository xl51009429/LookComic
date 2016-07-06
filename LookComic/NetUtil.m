//
//  NetUtil.m
//  BuyHouseBM
//
//  Created by 解梁 on 15/12/28.
//  Copyright © 2015年 xl. All rights reserved.
//

#import "NetUtil.h"

@interface NetUtil ()

@end
@implementation NetUtil

static BOOL isFirst = NO;
static BOOL canCHeckNetwork = NO;

+(void) GET:(NSString *)url param:(NSDictionary *)dict finish:(void (^)(NSData *data,NSDictionary *obj, NSError *error))callback
{
    NSLog(@"请求url:%@",url);
    if([self haveNotNetWork]){
        NSError *error = [NSError errorWithDomain:@"网络错误" code:100 userInfo:nil];
        callback(nil, nil,error);
        return;
    }
    //实现网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //成功 callback是对方传递过来的对象 这里是直接调用
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        callback(responseObject, obj ,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(nil, nil ,error);
        NSLog(@"%@",error);
    }];
}

+(void) POST:(NSString *)url param:(NSDictionary *)dict finish:(void (^)(NSData *data,NSDictionary *obj, NSError *error))callback
{
    NSLog(@"请求url:%@",url);
    NSLog(@"请求参数:%@",dict);
    //网络有问题
    if([self haveNotNetWork]){
        NSError *error = [NSError errorWithDomain:@"网络错误" code:100 userInfo:nil];
        callback(nil, nil,error);
        return;
    }
    
    //实现网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //成功 callback是对方传递过来的对象 这里是直接调用
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        callback(responseObject, obj ,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(nil, nil ,error);
        NSLog(@"%@",error);
    }];
}

//无网络
+ (BOOL)haveNotNetWork
{
    //检查网络连接
    if (isFirst == NO) {
        //网络只有在startMonitoring完成后才可以使用检查网络状态
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            canCHeckNetwork = YES;
        }];
        isFirst = YES;
    }
    
    //只能在监听完善之后才可以调用
    BOOL isOK = [[AFNetworkReachabilityManager sharedManager] isReachable];
    return !isOK&&canCHeckNetwork;
}

@end
