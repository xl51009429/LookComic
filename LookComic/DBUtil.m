//
//  DBUtil.m
//  LookComic
//
//  Created by 解梁 on 16/5/16.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "DBUtil.h"
#import "XLSandbox.h"

@implementation DBUtil
{
    FMDatabase *_fmdb;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self openDatabase];
    }
    return self;
}

/**
 *  单例创建对象
 *
 *  @return 单例对象
 */
+ (instancetype)sharedDBUtil
{
    static DBUtil *shareUtil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        shareUtil = [[DBUtil alloc]init];
    });
    return shareUtil;
}

//打开数据库
- (void)openDatabase
{
    //指定保存数据库文件的路径
    NSLog(@"path:%@",[XLSandbox documentPath]);
    _fmdb = [[FMDatabase alloc]initWithPath:[[XLSandbox documentPath] stringByAppendingString:@"/user.db"]];
    //打开数据库，如果数据库不存在，自动创建
    if (![_fmdb open]) {
        NSLog(@"open db failure:%@",_fmdb.lastErrorMessage);//打印错误信息
        return;
    }
    
    NSString *sql = @"create table if not exists ComicCollection(ID integer,title varchar(128),author varchar(128),likes_count integer,comments_count integer,cover_image_url varchar(128))";
    
    BOOL ret = [_fmdb executeUpdate:sql]; //执行dql语句,返回值为YES 表示成功，NO表示执行失败
    if (!ret) {
        NSLog(@"create table failure:%@",_fmdb.lastErrorMessage);
        return;
    }
}

/**
 *  查询漫画是否被收藏
 *
 *  @param comicID 漫画id
 *
 *  @return YES代表已收藏 NO代表未收藏
 */
- (BOOL)isExistComicByComicID:(NSNumber *)comicID
{
    NSString *sql = @"select * from ComicCollection where ID = ?";
    FMResultSet *result = [_fmdb executeQuery:sql,comicID];
    if ([result next]) {
        return YES;
    }
    return NO;
}

/**
 *  把漫画添加进数据库
 *
 *  @param topic 漫画对象
 *
 *  @return YES添加成功  NO添加失败
 */
- (BOOL)insertToDBWithTopicsModel:(TopicsModel *)topic
{
    NSString *sql = @"insert into ComicCollection(ID,title,author,likes_count,comments_count,cover_image_url) values(?,?,?,?,?,?)";
    if (![_fmdb executeUpdate:sql,topic.ID,topic.title,topic.user.nickname,topic.likes_count,topic.comments_count,topic.cover_image_url]) {
        return NO;
    }
    return YES;
}

/**
 *  把漫画从数据库删除
 *
 *  @param topicID 漫画对象id
 *
 *  @return YES删除成功  NO删除失败
 */
- (BOOL)removeByDBWithTopicID:(NSNumber *)topicID
{
    NSString *sql = @"delete from ComicCollection where ID = ?";
    if (![_fmdb executeUpdate:sql,topicID]) {
        return NO;
    }
    return YES;
}

/**
 *  查找数据库中所有的关注动漫
 *
 *  @return 关注的动漫数组
 */
- (NSArray *)selectAllCollectionTopics
{
    NSString *sql = @"select * from ComicCollection";
    FMResultSet *result = [_fmdb executeQuery:sql];
    if (!result) {
        return nil;
    }
    NSMutableArray *topics = [[NSMutableArray alloc]init];
    while ([result next]) {
        TopicsModel *topic = [[TopicsModel alloc]init];
        topic.ID = [NSNumber numberWithInt:[result intForColumn:@"ID"]];
        topic.cover_image_url = [result stringForColumn:@"cover_image_url"];
        topic.comments_count = [NSNumber numberWithInt:[result intForColumn:@"comments_count"]];
        topic.likes_count = [NSNumber numberWithInt:[result intForColumn:@"likes_count"]];
        topic.title = [result stringForColumn:@"title"];
        
        UserModel *user = [[UserModel alloc]init];
        user.nickname = [result stringForColumn:@"author"];
        
        topic.user = user;
        
        [topics addObject:topic];
    }
    return topics;
}

//关闭数据库
- (void)closeDB
{
    [_fmdb close];
}

- (void)dealloc
{
    [self closeDB];
}


@end
