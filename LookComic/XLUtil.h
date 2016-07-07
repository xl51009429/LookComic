//
//  XLUtil.h
//  LookComic
//
//  Created by 解梁 on 16/5/11.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XLUtil : NSObject

+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

/**
 *  将数字转换为字符串，大于10000的变为n万
 *
 *  @param number 要转换的数字
 *
 *  @return 转换好的字符串
 */
+ (NSString *)convertToStringWithNumber:(NSNumber *)number;

/**
 *  将时间戳转换为日期 格式：MM:dd
 *
 *  @param number 时间戳
 *
 *  @return 日期字符串
 */
+ (NSString *)convertToTimeStringWithNumber:(NSNumber *)number;

@end
