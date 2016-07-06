//
//  LoginView.m
//  LookComic
//
//  Created by 解梁 on 16/5/25.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "LoginView.h"
#import "PWTextField.h"
#import "OtherLoginView.h"
#import <Masonry.h>

@interface LoginView ()<OtherLoginViewDelegate>

@property (nonatomic, strong)UIView *textView;
@property (nonatomic, strong)PWTextField *passwordField;
@property (nonatomic, strong)PWTextField *phoneNumField;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UIButton *loginButton;
@property (nonatomic, strong)UIButton *registerButton;
@property (nonatomic, strong)UIButton *backButton;
@property (nonatomic, strong)OtherLoginView *otherLoginView;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addTapGesture];
        [self setupView];
        [self makeConstraints];
    }
    return self;
}

//添加点击手势 退出键盘
- (void)addTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exitKeyBoard)];
    [self addGestureRecognizer:tap];
}

//退出键盘
- (void)exitKeyBoard
{
    [self endEditing:YES];
}

//加载view
- (void)setupView
{
    [self.textView addSubview:self.phoneNumField];
    [self.textView addSubview:self.lineView];
    [self.textView addSubview:self.passwordField];
    [self addSubview:self.textView];
    [self addSubview:self.loginButton];
    [self addSubview:self.registerButton];
    [self addSubview:self.backButton];
    [self addSubview:self.otherLoginView];
}

//添加布局约束
- (void)makeConstraints
{
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
        make.centerY.mas_equalTo(self.mas_centerY).offset(-100);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.7, 80));
    }];
    [self.phoneNumField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.7 - kPadding*2, 30));
        make.left.mas_equalTo(self.textView.mas_left).offset(kPadding);
        make.top.mas_equalTo(self.textView.mas_top).offset(kPadding*.5);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.7, 1));
        make.center.mas_equalTo(self.textView);
    }];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.7 - kPadding*2, 30));
        make.left.mas_equalTo(self.textView.mas_left).offset(kPadding);
        make.bottom.mas_equalTo(self.textView.mas_bottom).offset(-kPadding*.5);
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.7, 30));
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
        make.top.mas_equalTo(self.textView.mas_bottom).offset(kPadding);
    }];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.7, 30));
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(kPadding);
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.left.mas_equalTo(self.mas_left).offset(kPadding);
        make.top.mas_equalTo(self.mas_top).offset(20 + kPadding);
    }];
    [self.otherLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.7, 100));
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-kPadding);
    }];

}

//登录按钮点击事件
- (void)loginButtonClick:(UIButton *)btn
{
    [self performDelegate:LoginButtonClickKind];
}

//注册按钮点击事件
- (void)registerButtonClick:(UIButton *)btn
{
    [self performDelegate:RegisterButtonClickKind];
}

//返回按钮点击事件
- (void)backButtonClick:(UIButton *)btn
{
    [self performDelegate:BackLoginButtonClickKind];
}

//代理执行代理方法
- (void)performDelegate:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(loginView:didSelectedAtIndex:)]) {
        [self.delegate loginView:self didSelectedAtIndex:index];
    }
}

#pragma mark - OtherLoginViewDelegate

- (void)otherLoginView:(OtherLoginView *)otherLoginView didselectedAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:     //QQ登录按钮
            [self performDelegate:QQLoginButtonClickKind];
            break;
        case 1:     //微博登录
            [self performDelegate:WeiBoLoginButtonClickKind];
            break;
        case 2:     //微信登录
            [self performDelegate:WeiXinLoginButtonClickKind];
            break;
        default:
            break;
    }
}

#pragma mark - getter方法

- (UIView *)textView
{
    if (_textView == nil) {
        _textView = [[UIView alloc]init];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.layer.cornerRadius = 5;
    }
    return _textView;
}

- (PWTextField *)passwordField
{
    if (_passwordField == nil) {
        _passwordField = [[PWTextField alloc]initWithFrame:CGRectMake(0, 0, 0, 0) title:@"输入手机号" normalImageNamed:@"ic_login_password_normal_21x21_" selectImageNamed:@"ic_login_password_highlighted_21x21_" secureTextEntry:YES keyBoardNumber:NO];
    }
    return _passwordField;
}

- (PWTextField *)phoneNumField
{
    if (_phoneNumField == nil) {
        _phoneNumField = [[PWTextField alloc]initWithFrame:CGRectZero title:@"请输入密码" normalImageNamed:@"ic_login_user_normal_21x21_" selectImageNamed:@"ic_login_user_highlighted_21x21_" secureTextEntry:NO keyBoardNumber:YES];
    }
    return _phoneNumField;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor grayColor];
        _lineView.alpha = 0.2;
    }
    return _lineView;
}

- (UIButton *)loginButton
{
    if (_loginButton == nil) {
        _loginButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setBackgroundColor:[UIColor blackColor]];
        [_loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.userInteractionEnabled = NO;
        [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _loginButton.layer.cornerRadius = 5;
        _loginButton.layer.masksToBounds = YES;
    }
    return _loginButton;
}

- (UIButton *)registerButton
{
    if (_registerButton == nil) {
        _registerButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setBackgroundColor:[UIColor blackColor]];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _registerButton.layer.cornerRadius = 5;
        _registerButton.layer.masksToBounds = YES;
    }
    return _registerButton;
}

- (UIButton *)backButton
{
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"ic_nav_close_normal_16x16_"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (OtherLoginView *)otherLoginView
{
    if (_otherLoginView == nil) {
        _otherLoginView = [[OtherLoginView alloc]init];
        _otherLoginView.delegate = self;
    }
    return _otherLoginView;
}

@end
