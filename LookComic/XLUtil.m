//
//  XLUtil.m
//  LookComic
//
//  Created by 解梁 on 16/5/11.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "XLUtil.h"

@implementation XLUtil

+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

+ (NSString *)convertToStringWithNumber:(NSNumber *)number
{
    int num = [number intValue];
    if (num >= 10000) {
        return [NSString stringWithFormat:@" %d万",num/10000];
    }
    return [NSString stringWithFormat:@" %d",num];
}

+ (NSString *)convertToTimeStringWithNumber:(NSNumber *)number
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"MM-dd";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[number longValue]];
    return [formatter stringFromDate:date];
}

@end
