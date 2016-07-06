//
//  BaseSectionCell.m
//  LookComic
//
//  Created by 解梁 on 16/5/9.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "BaseSectionCell.h"
#import "SectionHeaderView.h"
#import "TopicsModel.h"

@interface BaseSectionCell ()

@property (nonatomic, strong)SectionHeaderView *headerView;
@property (nonatomic, strong)UICollectionViewFlowLayout *layout;

@end

@implementation BaseSectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupCollectionViewAndHeader];
        [self registerCell];
    }
    return self;
}

//加载collectionView 和 Header
- (void)setupCollectionViewAndHeader
{
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.headerView];
}

//注册cell 供子类重构
- (void)registerCell
{
    
}

//点击更多按钮
- (void)moreButtonClick:(UIButton *)btn
{
    NSLog(@"%@",self.section.tag_id);
    if ([self.delegate respondsToSelector:@selector(baseSectionCell:didSelectedAtSectionTitle:)]) {
        [self.delegate baseSectionCell:self didSelectedAtSectionTitle:self.section.title];
    }
}

#pragma mark - dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.section.topics.count;
}

#pragma mark - layoutdelegate

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopicsModel *topic = self.section.topics[indexPath.row];
    NSNumber *bookID = topic.ID;
    if ([self.delegate respondsToSelector:@selector(baseSectionCell:didSelectedAtBookID:)]) {
        [self.delegate baseSectionCell:self didSelectedAtBookID:bookID];
    }
}

#pragma mark - getter setter方法

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, self.contentView.frame.size.height - 40) collectionViewLayout:_layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (void)setSection:(SectionModel *)section
{
    _section = section;
    
    //设置观察者
    [section addObserver:self forKeyPath:@"topics" options:NSKeyValueObservingOptionNew context:nil];
    
    if (_section.type == 0) {
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }else{
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    _collectionView.frame = CGRectMake(0, 40, kScreenWidth, section.contentCellHeight - 40);
    self.headerView.titleLabel.text = section.title;
    [_collectionView reloadData];
}

- (SectionHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[SectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        [_headerView.moreButton addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}

#pragma mark - kvo

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"topics"]) {
        [self.collectionView reloadData];
    }
}

- (void)dealloc
{
    [_section removeObserver:self forKeyPath:@"topics"];
}

@end
