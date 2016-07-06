//
//  SectionHeaderView.m
//  LookComic
//
//  Created by 解梁 on 16/5/9.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "SectionHeaderView.h"
#import <Masonry.h>

@interface SectionHeaderView ()

@end
@implementation SectionHeaderView

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

//界面绘制
- (void)setup
{
    [self addSubview:self.logoView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.moreButton];
    [self makeConstraints];
}

//设置布局
- (void)makeConstraints
{
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(5, 20));
        make.left.equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoView.mas_right).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 40));
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(self.mas_top).offset(0);
    }];
}

#pragma mark - getter setter 方法

-(UIView *)logoView
{
    if (_logoView == nil) {
        _logoView = [[UIView alloc]init];
        _logoView.backgroundColor = [UIColor greenColor];
        _logoView.layer.cornerRadius = 2.5;
    }
    return _logoView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor grayColor];
    }
    return _titleLabel;
}

- (UIButton *)moreButton
{
    if (_moreButton == nil) {
        _moreButton = [[UIButton alloc]init];
        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    return _moreButton;
}

@end
