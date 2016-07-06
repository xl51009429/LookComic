//
//  Target_Personal.h
//  LookComic
//
//  Created by 解梁 on 16/7/4.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Target_Personal : NSObject

- (UIViewController *)Action_nativeFetchPersonalController:(NSDictionary *)params;

- (UIViewController *)Action_nativeFetchLoginController;

@end
