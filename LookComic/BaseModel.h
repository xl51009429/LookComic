//
//  BaseModel.h
//  LookComic
//
//  Created by 解梁 on 16/5/5.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)modelWithDictionary:(NSDictionary *)dic;

@end
