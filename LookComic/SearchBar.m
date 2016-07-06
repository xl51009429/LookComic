//
//  SearchBar.m
//  LookComic
//
//  Created by 解梁 on 16/5/13.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "SearchBar.h"
#import <Masonry.h>

NSString *textValue = @"";

@interface SearchBar ()<UITextFieldDelegate>

@property (nonatomic, strong)UIView *backView;

@end
@implementation SearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

//加载控件
- (void)setup
{
    self.placeholder = @"输入漫画名 作者名";
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = self.frame.size.height*.5;
    self.font = [UIFont systemFontOfSize:13];
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.delegate = self;
    
    [self addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    
    //添加左试图
    [self setupLeftView];
}

//添加左试图
- (void)setupLeftView
{
    CGFloat width = self.frame.size.height;
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, width)];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"ic_home_nav_search_normal_19x19_"];
    [_backView addSubview:imageView];
    self.leftView = _backView;
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width*.5, width*.5));
        make.right.mas_equalTo(_backView.mas_right).offset(-width*.5*.5);
        make.top.mas_equalTo(_backView.mas_top).offset(width*.5*.5);
    }];
    
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)textFieldEditChanged:(UITextField *)textField
{
    textValue = textField.text;
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分
    if (position)
        return;
    if (textField.text.length > 0 && [self.barDelegate respondsToSelector:@selector(searchBar:didChangedWithValue:)]) {
        [self.barDelegate searchBar:self didChangedWithValue:textField.text];
    }
    if (textField.text.length == 0 && [self.barDelegate respondsToSelector:@selector(searchBarHaveNilValue:)]) {
        [self.barDelegate searchBarHaveNilValue:self];
    }
}

//#pragma mark - UITextFieldDelegate方法
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    CGFloat width = self.frame.size.height;
//    [UIView animateWithDuration:3.0 animations:^{
//        CGRect frame = _backView.frame;
//        frame.size.width = width;
//        _backView.frame = frame;
//    }];
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [UIView animateWithDuration:3.0 animations:^{
//        CGRect frame = _backView.frame;
//        frame.size.width = 80;
//        _backView.frame = frame;
//    }];
//}

@end
