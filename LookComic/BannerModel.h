//
//  BannerModel.h
//  LookComic
//
//  Created by 解梁 on 16/5/6.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "BaseModel.h"

@interface BannerModel : BaseModel

@property (nonatomic,copy)NSString *pic;        //图片网址
@property (nonatomic,copy)NSString *title;      //图片标题
@property (nonatomic,retain)NSNumber *type;     //图片类型
@property (nonatomic,retain)NSNumber *value;    //图片?值

@end
