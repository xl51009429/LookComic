//
//  MyCollectionView.m
//  LookComic
//
//  Created by 解梁 on 16/5/16.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "MyCollectionView.h"
#import "SearchComicCell.h"
#import "MycollectionCell.h"
#import "DBUtil.h"

static NSString *mycollectionCellId = @"MycollectionCellId";

@interface MyCollectionView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MyCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.dataSource = self;
        self.delegate = self;
        self.alwaysBounceVertical = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.rowHeight = 80;
        [self registerNib:[UINib nibWithNibName:@"MycollectionCell" bundle:nil] forCellReuseIdentifier:mycollectionCellId];
        self.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    return self;
}

#pragma mark - UITableViewDataSource 方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MycollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:mycollectionCellId forIndexPath:indexPath];
    cell.topic = self.topics[indexPath.item];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[DBUtil sharedDBUtil]removeByDBWithTopicID:[self.topics[indexPath.row] ID]];
        [self.topics removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

#pragma mark - UITableViewDelegate方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TopicsModel *topic = self.topics[indexPath.item];
    if ([self.viewDelegate respondsToSelector:@selector(myCollectionView:didSelectedAtTopicID:)]) {
        [self.viewDelegate myCollectionView:self didSelectedAtTopicID:topic.ID];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"取消关注";
}

#pragma mark - setter方法

- (void)setTopics:(NSMutableArray *)topics
{
    _topics = topics;
    [self reloadData];
}

@end
