//
//  DBUtil.h
//  LookComic
//
//  Created by 解梁 on 16/5/16.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import "TopicsModel.h"

@interface DBUtil : NSObject

/**
 *  单例创建对象
 *
 *  @return 单例对象
 */
+ (instancetype)sharedDBUtil;

/**
 *  查询漫画是否被收藏
 *
 *  @param comicID 漫画id
 *
 *  @return YES代表已收藏 NO代表未收藏
 */
- (BOOL)isExistComicByComicID:(NSNumber *)comicID;

/**
 *  把漫画添加进数据库
 *
 *  @param topic 漫画对象
 *
 *  @return YES添加成功  NO添加失败
 */
- (BOOL)insertToDBWithTopicsModel:(TopicsModel *)topic;

/**
 *  把漫画从数据库删除
 *
 *  @param topicID 漫画对象id
 *
 *  @return YES删除成功  NO删除失败
 */
- (BOOL)removeByDBWithTopicID:(NSNumber *)topicID;

/**
 *  查找数据库中所有的关注动漫
 *
 *  @return 关注的动漫数组
 */
- (NSArray *)selectAllCollectionTopics;

@end
