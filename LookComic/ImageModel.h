//
//  ImageModel.h
//  LookComic
//
//  Created by 解梁 on 16/5/12.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "BaseModel.h"

@interface ImageModel : BaseModel

@property (nonatomic, copy)NSString *imageUrl;      //图片url
@property (nonatomic, assign)CGFloat height;        //图片高度

@end
