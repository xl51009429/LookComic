//
//  PersonalView.m
//  LookComic
//
//  Created by 解梁 on 16/5/25.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "PersonalView.h"
#import "PersonalHeaderView.h"

@interface PersonalView ()<UITableViewDataSource,UITableViewDelegate,PersonalHeaderViewDelegate>

@property (nonatomic, retain)NSMutableArray *titles;            //cell标题数组
@property (nonatomic, retain)NSMutableArray *images;            //cell图片数组
@property (nonatomic, strong)PersonalHeaderView *headerView;    //头视图

@end

@implementation PersonalView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self setupTable];
        [self setupDataSource];
    }
    return self;
}

//加载tableview
- (void)setupTable
{
    self.delegate = self;
    self.dataSource = self;
    self.alwaysBounceVertical = NO;
    self.tableFooterView = [[UIView alloc]init];
    self.tableHeaderView = self.headerView;
    self.separatorInset = UIEdgeInsetsZero;
}

//加载数据源
- (void)setupDataSource
{
    [self.titles addObjectsFromArray:@[@[@"我的消息"],@[@"我的关注",@"我的收藏"],@[@"设置"]]];
    [self.images addObjectsFromArray:@[@[@"ic_me_item_message_20x20_"],@[@"ic_me_item_collection_topic_20x20_",@"ic_me_item_collection_comic_20x20_"],@[@"ic_me_item_setting_20x20_"]]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titles[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"personalCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.imageView.image = [UIImage imageNamed:self.images[indexPath.section][indexPath.row]];
    cell.textLabel.text = self.titles[indexPath.section][indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kPadding;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - PersonalHeaderViewDelegate

- (void)iconButtonClickedInPersonalHeaderView:(PersonalHeaderView *)personalHeaderView
{
    if ([self.personalDelegate respondsToSelector:@selector(iconButtonClickedInPersonalView:)]) {
        [self.personalDelegate iconButtonClickedInPersonalView:self];
    }
}

#pragma mark - getter方法

- (NSMutableArray *)titles
{
    if (_titles == nil) {
        _titles = [[NSMutableArray alloc]init];
    }
    return _titles;
}

- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [[NSMutableArray alloc]init];
    }
    return _images;
}

- (PersonalHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[PersonalHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeaderHeight)];
        _headerView.delegate = self;
    }
    return _headerView;
}

@end
