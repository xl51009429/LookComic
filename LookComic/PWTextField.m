//
//  PWTextField.m
//  LookComic
//
//  Created by 解梁 on 16/5/25.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "PWTextField.h"

@interface PWTextField ()<UITextFieldDelegate>

@property (nonatomic, copy)NSString *image;
@property (nonatomic, copy)NSString *selectImage;
@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation PWTextField

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title normalImageNamed:(NSString *)image selectImageNamed:(NSString *)selectImage secureTextEntry:(BOOL)isSecure keyBoardNumber:(BOOL)isNumber
{
    if (self = [super initWithFrame:frame]) {
        _image = image;
        _selectImage = selectImage;
        [self initTextFieldWithTitle:title secureTextEntry:isSecure keyBoardNumber:isNumber];
    }
    return self;
}

//初始化输入框
- (void)initTextFieldWithTitle:(NSString *)title secureTextEntry:(BOOL)isSecure keyBoardNumber:(BOOL)isNumber
{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 21, 21)];
    _imageView.image = [UIImage imageNamed:_image];
    self.leftView = _imageView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.font = [UIFont systemFontOfSize:13];
    self.placeholder = title;
    self.delegate = self;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.secureTextEntry = isSecure;
    if (isNumber)
        self.keyboardType = UIKeyboardTypeNumberPad;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _imageView.image = [UIImage imageNamed:_selectImage];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _imageView.image = [UIImage imageNamed:_image];
}

@end
