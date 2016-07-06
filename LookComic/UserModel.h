//
//  UserModel.h
//  LookComic
//
//  Created by 解梁 on 16/5/9.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel

@property (nonatomic,copy)NSString *avatar_url;         //作者头像
@property (nonatomic, retain)NSNumber *ID;              //作者id
@property (nonatomic,copy)NSString *nickname;           //作者昵称
@property (nonatomic,copy)NSString *reg_type;           //登陆方式

@end
