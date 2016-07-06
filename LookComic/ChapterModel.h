//
//  ChapterModel.h
//  LookComic
//
//  Created by 解梁 on 16/5/10.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "BaseModel.h"

@interface ChapterModel : BaseModel

@property (nonatomic,copy)NSString *cover_image_url;        //章节封面
@property (nonatomic, retain)NSNumber *created_at;          //创建时间
@property (nonatomic, retain)NSNumber *likes_count;         //读者点击喜欢数量
@property (nonatomic,copy)NSString *status;                 //章节状态
@property (nonatomic,copy)NSString *title;                  //章节标题
@property (nonatomic, retain)NSNumber *topic_id;            //所属漫画id
@property (nonatomic, retain)NSNumber *updated_at;          //更新时间
@property (nonatomic,copy)NSString *url;                    //此章节漫画url地址

//返回的字段和保留字冲突，改变字段名字，需另外赋值
@property (nonatomic, retain)NSNumber *ID;                  //章节id

@property (nonatomic, retain)NSArray *images;               //章节图片

@end
