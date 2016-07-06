//
//  NetUtil.h
//  BuyHouseBM
//
//  Created by 解梁 on 15/12/28.
//  Copyright © 2015年 xl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetUtil : NSObject

+(void) GET:(NSString *)url param:(NSDictionary *)dict finish:(void (^)(NSData *data,NSDictionary *obj, NSError *error))callback;

+(void) POST:(NSString *)url param:(NSDictionary *)dict finish:(void (^)(NSData *data,NSDictionary *obj, NSError *error))callback;

@end
