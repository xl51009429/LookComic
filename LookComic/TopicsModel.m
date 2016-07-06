//
//  TopicsModel.m
//  LookComic
//
//  Created by 解梁 on 16/5/9.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "TopicsModel.h"

@implementation TopicsModel

- (void)setUser:(UserModel *)user
{
    if ([user isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)user;
        UserModel *myUser = [UserModel modelWithDictionary:dic];
        myUser.ID = dic[@"id"];
        _user = myUser;
    }else{
        _user = user;
    }
}

- (void)setComics:(NSArray *)comics
{
    NSMutableArray *myComics = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in comics) {
        ChapterModel *chapter = [ChapterModel modelWithDictionary:dic];
        chapter.ID = dic[@"id"];
        [myComics addObject:chapter];
    }
    _comics = myComics;
}

//重写父类初始化方法，给ID descri赋值 id description为关键字
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super initWithDictionary:dic]) {
        self.ID = dic[@"id"];
        self.descri = dic[@"description"];
    }
    return self;
}

@end
