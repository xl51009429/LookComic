//
//  BaseModel.m
//  LookComic
//
//  Created by 解梁 on 16/5/5.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

//防止操作没有定义的属性时崩溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    return ;
}

//实例初始化方法
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

//类初始化方法
+ (instancetype)modelWithDictionary:(NSDictionary *)dic
{
    return [[self alloc]initWithDictionary:dic];
}

@end
