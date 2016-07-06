//
//  LoginView.h
//  LookComic
//
//  Created by 解梁 on 16/5/25.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LoginViewButtonClickKind){
    LoginButtonClickKind = 1,
    RegisterButtonClickKind,
    QQLoginButtonClickKind,
    WeiXinLoginButtonClickKind,
    WeiBoLoginButtonClickKind,
    BackLoginButtonClickKind
};

@class LoginView;

@protocol LoginViewDelegate <NSObject>

- (void)loginView:(LoginView *)loginView didSelectedAtIndex:(NSInteger)index;

@end

@interface LoginView : UIView

@property (nonatomic, assign)id<LoginViewDelegate> delegate;

@end
