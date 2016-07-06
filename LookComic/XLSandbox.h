//
//  XLSandbox.h
//  BuyHouse
//
//  Created by 解梁 on 15/12/15.
//  Copyright © 2015年 xl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLSandbox : NSObject

+ (NSString*)appPath;

+ (NSString*)documentPath;

+ (NSString*)cachesPath;

+ (NSString*)tmpPath;

+ (NSString *)getIPAddress;

@end

NSString * GetUUIDString();

NSString * GetBuildNumber();

NSString * GetAppVersion();

NSString * GetAppName();

