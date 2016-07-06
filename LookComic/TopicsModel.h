//
//  TopicsModel.h
//  LookComic
//
//  Created by 解梁 on 16/5/9.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"
#import "ChapterModel.h"

@interface TopicsModel : BaseModel

@property (nonatomic, retain)NSNumber *comics_count;            //章节总数
@property (nonatomic, retain)NSNumber *comments_count;          //评论总数
@property (nonatomic,copy)NSString *cover_image_url;            //封面图
@property (nonatomic, retain)NSNumber *created_at;              //创建时间
@property (nonatomic, retain)NSNumber *updated_at;              //更新时间
@property (nonatomic, copy) NSString *title;                    //标题
@property (nonatomic, retain)NSNumber *user_id;                 //作者id
@property (nonatomic, copy) NSString *vertical_image_url;       // ?
@property (nonatomic,retain)NSNumber *likes_count;              //喜欢数量

//返回的字段和保留字冲突，改变字段名字，需另外赋值
@property (nonatomic,copy)NSString *descri;                     //描述
@property (nonatomic, retain)NSNumber *ID;                      //id

//自定义对象属性
@property (nonatomic, retain)UserModel *user;                   //作者对象

@property (nonatomic, retain)NSArray *comics;                   //章节数组

@end
