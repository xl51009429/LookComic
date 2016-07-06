//
//  SectionModel.h
//  LookComic
//
//  Created by 解梁 on 16/5/6.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "BaseModel.h"
#import <Foundation/Foundation.h>

@interface SectionModel : BaseModel


@property (nonatomic,copy)NSString *icon;                           //icon图标
@property (nonatomic,retain)NSNumber *priority;
@property (nonatomic,retain)NSNumber *tag_id;                       //区域类别id
@property (nonatomic,copy)NSString *title;                          //标题

@property (nonatomic,assign)NSInteger contentCount;                 //显示内容的个数
@property (nonatomic, assign, readonly)float contentCellHeight;     //cell的高度
@property (nonatomic,assign)NSInteger type;                         //类型

@property (nonatomic,copy)NSArray *topics;

@end
