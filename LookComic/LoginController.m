//
//  LoginController.m
//  LookComic
//
//  Created by 解梁 on 16/5/25.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "LoginController.h"
#import "LoginView.h"
#import <UMSocial.h>

@interface LoginController ()<LoginViewDelegate>

@property (nonatomic, strong)LoginView *loginView;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
}

//加载view
- (void)setupView
{
    self.view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.loginView];
}

//微博登录
- (void)weiBoLogin
{
    UMSocialSnsPlatform *platform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    platform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:@"sina"];
            NSDictionary *dic = @{@"oauth_app_id":@(3691583305),
                                  @"oauth_provider":@"weibo",
                                  @"oauth_token":snsAccount.accessToken,
                                  @"oauth_uid":snsAccount.usid
                                  };
//            [NetUtil POST:kSignUp param:dic finish:^(NSData *data, NSDictionary *obj, NSError *error) {
//                if (!error) {
//                    NSLog(@"%@",obj);
//                }else{
//                    NSLog(@"%@",error);
//                }
//            }];
            
//            NSDictionary *dic = @{@"alias_id":@"13229247",
//                                  @"muid":@"b27a56c93014fa052872888d5c7351ca",
//                                  @"partner_id":@1,
//                                  @"platform":@2,
//                                  @"register_id":@"1a1018970aa57a1b16d",
//                                  @"tags":@"login"
//                                  };
//            [NetUtil POST:kPushInfo param:dic finish:^(NSData *data, NSDictionary *obj, NSError *error) {
//                if (!error) {
//                    NSLog(@"%@",obj);
//                }else{
//                    NSLog(@"%@",error);
//                }
//            }];

        }
    });
}

#pragma mark - LoginViewDelegate

- (void)loginView:(LoginView *)loginView didSelectedAtIndex:(NSInteger)index
{
    switch (index) {
        case LoginButtonClickKind:          //登录按钮点击
            
            break;
        case RegisterButtonClickKind:       //注册按钮点击
            
            break;
        case QQLoginButtonClickKind:        //qq登录按钮点击
            
            break;
        case WeiBoLoginButtonClickKind:     //微博登录按钮点击
            [self weiBoLogin];
            break;
        case WeiXinLoginButtonClickKind:    //微信登录按钮点击
            
            break;
        case BackLoginButtonClickKind:      //返回按钮点击
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
            
        default:
            break;
    }
}

#pragma mark - getter方法

- (LoginView *)loginView
{
    if (_loginView == nil) {
        _loginView = [[LoginView alloc]initWithFrame:self.view.frame];
        _loginView.delegate = self;
    }
    return _loginView;
}

@end
