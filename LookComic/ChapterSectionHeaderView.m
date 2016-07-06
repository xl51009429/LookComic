//
//  ChapterSectionHeaderView.m
//  LookComic
//
//  Created by 解梁 on 16/5/10.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "ChapterSectionHeaderView.h"
#import <Masonry.h>

@interface ChapterSectionHeaderView ()

@property (nonatomic, strong)UIButton *summaryButton;
@property (nonatomic, strong)UIButton *contentButton;
@property (nonatomic, strong)UIView *bottomLine;
@property (nonatomic, strong)UIView *centerLine;
@property (nonatomic, strong)UILabel *chapterListLabel;
@property (nonatomic, strong)UIButton *sortButton;
@property (nonatomic, strong)UIView *bottomLine2;
@property (nonatomic, strong)UILabel *descriptionLabel;
@property (nonatomic, strong)UIButton *allButton;
@property (nonatomic, strong)UIView *animationLineView;

@property (nonatomic, assign)float headerHeight;

@end

@implementation ChapterSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

//加载页面
- (void)setup
{
    [self addSubview:self.summaryButton];
    [self addSubview:self.contentButton];
    [self addSubview:self.bottomLine];
    [self addSubview:self.centerLine];
    [self addSubview:self.chapterListLabel];
    [self addSubview:self.sortButton];
    [self addSubview:self.bottomLine2];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.allButton];
    [self addSubview:self.animationLineView];
    [self makeConstraints];
}

//设置布局属性
- (void)makeConstraints
{
    [self.summaryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * .5, 40));
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.top.mas_equalTo(self.mas_top).offset(0);
    }];
    [self.contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * .5, 40));
        make.left.mas_equalTo(self.summaryButton.mas_right).offset(0);
        make.top.mas_equalTo(self.mas_top).offset(0);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1));
        make.top.mas_equalTo(self.summaryButton.mas_bottom).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
    }];
    [self.centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 30));
        make.left.mas_equalTo(self.summaryButton.mas_right).offset(0);
        make.top.mas_equalTo(self.mas_top).offset(5);
    }];
    [self.chapterListLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.top.mas_equalTo(self.summaryButton.mas_bottom).offset(kPadding);
        make.left.mas_equalTo(self.mas_left).offset(kPadding);
    }];
    [self.sortButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 20));
        make.top.mas_equalTo(self.summaryButton.mas_bottom).offset(kPadding);
        make.right.mas_equalTo(self.mas_right).offset(-kPadding);
    }];
    [self.bottomLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1));
        make.top.mas_equalTo(self.chapterListLabel.mas_bottom).offset(kPadding);
        make.left.mas_equalTo(self.mas_left).offset(0);
    }];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(kPadding);
        make.right.mas_equalTo(self.mas_right).offset(-kPadding);
        make.top.mas_equalTo(self.summaryButton.mas_bottom).offset(kPadding);
        make.height.mas_equalTo(20);
    }];
    [self.animationLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * .5, 1));
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.top.mas_equalTo(self.summaryButton.mas_bottom).offset(0);
    }];
}

//简介按钮点击
- (void)summaryButtonClick:(UIButton *)btn
{
    if (btn.selected == YES) {
        return;
    }
    btn.selected = YES;
    self.contentButton.selected = NO;
    [self showDespritionLabel];
    [self performDelegateEventWithButton:btn];
    [self updateAnimationLineView];
}

//显示排序label
- (void)showDespritionLabel
{
    [self.bottomLine2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1));
        make.top.mas_equalTo(self.descriptionLabel.mas_bottom).offset(kPadding);
        make.left.mas_equalTo(self.mas_left).offset(0);
    }];
    _headerHeight = CGRectGetMaxY(self.descriptionLabel.frame) + kPadding;
    self.descriptionLabel.hidden = NO;
    self.chapterListLabel.hidden = YES;
    self.sortButton.hidden = YES;
}

//内容按钮点击
- (void)contentButtonClick:(UIButton *)btn
{
    if (btn.selected == YES) {
        return;
    }
    btn.selected = YES;
    self.summaryButton.selected = NO;
    [self showChapterLabel];
    [self performDelegateEventWithButton:btn];
    [self updateAnimationLineView];
}

//显示排序按钮
- (void)showChapterLabel
{
    [self.bottomLine2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1));
        make.top.mas_equalTo(self.chapterListLabel.mas_bottom).offset(kPadding);
        make.left.mas_equalTo(self.mas_left).offset(0);
    }];
    _headerHeight = 90;
    self.descriptionLabel.hidden = YES;
    self.chapterListLabel.hidden = NO;
    self.sortButton.hidden = NO;
}

//底部线做动画
- (void)updateAnimationLineView
{
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:5.0 animations:^{
        [self.animationLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(self.contentButton.selected?0:-kScreenWidth*.5);
        }];
    }];
    [self layoutIfNeeded];
}

//排序按钮点击事件
- (void)sortButtonClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    [self performDelegateEventWithButton:btn];
}

//代理通知事件
- (void)performDelegateEventWithButton:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(chapterSectionHeaderView:didSelectedAtIndex:headerViewHeight:)]) {
        [self.delegate chapterSectionHeaderView:self didSelectedAtIndex:btn.tag headerViewHeight:_headerHeight];
    }
}

//全部按钮点击事件
- (void)allButtonClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

#pragma mark - getter setter方法

- (UIButton *)summaryButton
{
    if (_summaryButton == nil) {
        _summaryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _summaryButton.tag = ChapterSectionHeaderSummaryKind;
        _summaryButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_summaryButton setTitle:@"简介" forState:UIControlStateNormal];
        [_summaryButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_summaryButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_summaryButton addTarget:self action:@selector(summaryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _summaryButton;
}

- (UIButton *)contentButton
{
    if (_contentButton == nil) {
        _contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _contentButton.selected = YES;
        _contentButton.tag = ChapterSectionHeaderContentKind;
        _contentButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_contentButton setTitle:@"内容" forState:UIControlStateNormal];
        [_contentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_contentButton addTarget:self action:@selector(contentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contentButton;
}

- (UIView *)bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = [UIColor grayColor];
        _bottomLine.alpha = 0.2;
    }
    return _bottomLine;
}

- (UIView *)centerLine
{
    if (_centerLine == nil) {
        _centerLine = [[UIView alloc]init];
        _centerLine.backgroundColor = [UIColor grayColor];
        _centerLine.alpha = 0.2;
    }
    return _centerLine;
}

- (UILabel *)chapterListLabel
{
    if (_chapterListLabel == nil) {
        _chapterListLabel = [[UILabel alloc]init];
        _chapterListLabel.font = [UIFont systemFontOfSize:15];
        _chapterListLabel.textColor = [UIColor grayColor];
        _chapterListLabel.text = @"章节列表";
    }
    return _chapterListLabel;
}

- (UIButton *)sortButton
{
    if (_sortButton == nil) {
        _sortButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sortButton.tag = ChapterSectionHeaderSortKind;
        _sortButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [_sortButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _sortButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_sortButton setImage:[UIImage imageNamed:@"ico_daoxun"] forState:UIControlStateNormal];
        [_sortButton setTitle:@" 倒序" forState:UIControlStateNormal];
        [_sortButton setImage:[UIImage imageNamed:@"ico_shunxun"] forState:UIControlStateSelected];
        [_sortButton addTarget:self action:@selector(sortButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_sortButton setTitle:@" 顺序" forState:UIControlStateSelected];
    }
    return _sortButton;
}

- (UIView *)bottomLine2
{
    if (_bottomLine2 == nil) {
        _bottomLine2 = [[UIView alloc]init];
        _bottomLine2.backgroundColor = [UIColor grayColor];
        _bottomLine2.alpha = 0.2;
    }
    return _bottomLine2;
}

- (UILabel *)descriptionLabel
{
    if (_descriptionLabel == nil) {
        _descriptionLabel = [[UILabel alloc]init];
        _descriptionLabel.hidden = YES;
        _descriptionLabel.font = [UIFont systemFontOfSize:11];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.textColor = [UIColor grayColor];
    }
    return _descriptionLabel;
}

- (UIButton *)allButton
{
    if (_allButton == nil) {
        _allButton = [[UIButton alloc]init];
        _allButton.hidden = YES;
        [_allButton setTitle:@"全部" forState:UIControlStateNormal];
        [_allButton setTitle:@"收起" forState:UIControlStateSelected];
        //[_allButton setImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>]
        [_allButton addTarget:self action:@selector(allButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allButton;
}

- (UIView *)animationLineView
{
    if (_animationLineView == nil) {
        _animationLineView = [[UIView alloc]init];
        _animationLineView.backgroundColor = [UIColor orangeColor];
    }
    return _animationLineView;
}

- (void)setDescri:(NSString *)descri
{
    _descri = descri;
    self.descriptionLabel.text = descri;
    CGRect rect = [descri boundingRectWithSize:CGSizeMake(kScreenWidth - kPadding*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil];
    [self.descriptionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(kPadding);
        make.right.mas_equalTo(self.mas_right).offset(-kPadding);
        make.top.mas_equalTo(self.summaryButton.mas_bottom).offset(kPadding);
        make.height.mas_equalTo(rect.size.height);
    }];
}

@end
