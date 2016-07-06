//
//  OtherLoginView.m
//  LookComic
//
//  Created by 解梁 on 16/5/26.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "OtherLoginView.h"

@interface OtherLoginView ()

@end

@implementation OtherLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

//加载view
- (void)setupView
{
    CGFloat width = 40;
    CGFloat height = 55;
    CGFloat padding = (kScreenWidth * 0.7 - 40 * 3)*.5;
    NSArray *images = @[@"ic_login_QQ_40x55_",@"ic_login_weibo_40x55_",@"ic_login_weixin_40x55_"];
    NSArray *hightImages = @[@"ic_login_QQ_pressed_40x55_",@"ic_login_weibo_pressed_40x55_",@"ic_login_weixin_pressed_40x55_"];
    for (int i=0; i<3; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((padding + width) * i, 50 - kPadding, width, height)];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:hightImages[i]] forState:UIControlStateHighlighted];
        btn.tag = i;
        [btn addTarget: self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
    UIView *leftLine = [[UIView alloc]initWithFrame:CGRectMake(0, 10, width, 1)];
    leftLine.backgroundColor = [UIColor grayColor];
    [self addSubview:leftLine];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(width, 0, width + padding *2, 20)];
    titleLabel.text = @"其他登录方式";
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    UIView *rightLine = [[UIView alloc]initWithFrame:CGRectMake((padding + width) * 2, 10, width, 1)];
    rightLine.backgroundColor = [UIColor grayColor];
    [self addSubview:rightLine];
}

// 按钮点击事件
- (void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(otherLoginView:didselectedAtIndex:)]) {
        [self.delegate otherLoginView:self didselectedAtIndex:btn.tag];
    }
}

@end
