//
//  XLSandbox.m
//  BuyHouse
//
//  Created by 解梁 on 15/12/15.
//  Copyright © 2015年 xl. All rights reserved.
//

#import "XLSandbox.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation XLSandbox

/**
 *  获取app目录(不能进行存储)
 */
+ (NSString *)appPath
{
    static NSString *s_appPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
        s_appPath = [paths objectAtIndex:0];
    });
    return s_appPath;
}

/**
 *  文档目录，需要ITUNES同步备份的数据存这里，可存放用户数据
 */
+ (NSString *)documentPath
{
    static NSString *s_docPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        s_docPath = [paths objectAtIndex:0];
    });
    return s_docPath;
}

/**
 *  缓存目录，系统永远不会删除这里的文件，ITUNES会删除
 */
+ (NSString *)cachesPath
{
    static NSString *s_cachePath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        s_cachePath = [paths objectAtIndex:0];
    });
    return s_cachePath;
}

/**
 *  临时缓存目录，APP退出后，系统可能会删除这里的内容
 */
+ (NSString *)tmpPath
{
    return NSTemporaryDirectory();
}

+ (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}


@end

NSString * GetUUIDString() {
    return [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}


NSString * GetBuildNumber() {
    static NSString *build = nil;
    if (!build) {
        build = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
    }
    
    return build;
}

NSString * GetAppVersion() {
    static NSString *version = nil;
    if (!version) {
        version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    }
    return version;
}

NSString * GetAppName() {
    static NSString *name = nil;
    name = [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"];
    if (name.length == 0) {
        name = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    }
    
    return name;
}

