//
//  PWTextField.h
//  LookComic
//
//  Created by 解梁 on 16/5/25.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PWTextField : UITextField

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title normalImageNamed:(NSString *)image selectImageNamed:(NSString *)selectImage secureTextEntry:(BOOL)isSecure keyBoardNumber:(BOOL)isNumber;

@end
