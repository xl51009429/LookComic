//
//  PersonalHeaderView.m
//  LookComic
//
//  Created by 解梁 on 16/5/25.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "PersonalHeaderView.h"
#import <Masonry.h>

@interface PersonalHeaderView ()

@property (nonatomic, strong)UIButton *iconButton;          //头像
@property (nonatomic, strong)UILabel *titleLabel;           //昵称

@end
@implementation PersonalHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
        [self makeConstraints];
    }
    return self;
}

//加载试图
- (void)setupView
{
    self.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.iconButton];
    [self addSubview:self.titleLabel];
}

//添加布局约束
- (void)makeConstraints
{
    [self.iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80 * kScreen320Scale, 80 * kScreen320Scale));
        make.center.mas_equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(kPadding);
        make.right.mas_equalTo(self.mas_right).offset(-kPadding);
        make.height.mas_equalTo(@20);
        make.top.mas_equalTo(self.iconButton.mas_bottom).offset(kPadding);
    }];
}

//头像点击事件
- (void)iconButtonClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(iconButtonClickedInPersonalHeaderView:)]) {
        [self.delegate iconButtonClickedInPersonalHeaderView:self];
    }
}

#pragma mark - getter方法

- (UIButton *)iconButton
{
    if (_iconButton == nil) {
        _iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_iconButton setImage:[UIImage imageNamed:@"defaultIcon"] forState:UIControlStateNormal];
        [_iconButton addTarget:self action:@selector(iconButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconButton;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"登陆";
    }
    return _titleLabel;
}

@end
