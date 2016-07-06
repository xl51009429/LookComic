//
//  ChapterHeaderView.m
//  LookComic
//
//  Created by 解梁 on 16/5/10.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "ChapterMainHeaderView.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import <FXBlurView.h>
#import "DBUtil.h"

@interface ChapterMainHeaderView()

@property (nonatomic, strong)UIImageView *backImageView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIImageView *maskView;
@property (nonatomic, strong)UIButton *backButton;
@property (nonatomic, strong)UIButton *collectionButton;

@property (nonatomic, assign)BOOL titleLabelCenterFlag;         //是否在中间
@property (nonatomic, assign)BOOL isCollection;                 //是否被收藏

@end

@implementation ChapterMainHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

//加载界面
- (void)setup
{
    _titleLabelCenterFlag = NO;
    
    [self addSubview:self.backImageView];
    [self addSubview:self.maskView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.backButton];
    [self addSubview:self.collectionButton];
    [self makeConstraints];
}

//设置
- (void)makeConstraints
{
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.left.mas_equalTo(self.mas_left).offset(kPadding + 4);
        make.top.mas_equalTo(self.mas_top).offset(kPadding * 2 + 5);
    }];
    [self.collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 25));
        make.top.mas_equalTo(self.mas_top).offset(kPadding * 2 + 10);
        make.right.mas_equalTo(self.mas_right).offset(-kPadding);
    }];
}

//设置最上面背景图的动画
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self maskAnimation];
    [self titleLabelAnimation];
}

//遮罩层透明度改变
- (void)maskAnimation
{
    CGFloat value = (kChapterHeaderHeight - self.frame.size.height)/kChapterHeaderHeight;
    self.maskView.alpha = value+0.3;
}

//标题的动画
- (void)titleLabelAnimation
{
    BOOL isAnimationFlag = self.frame.size.height < 80?YES:NO;
    CGRect frame = self.titleLabel.frame;
    frame.origin.y = self.frame.size.height - frame.size.height - kPadding ;
    self.titleLabel.frame = frame;
    if (isAnimationFlag && _titleLabelCenterFlag == NO) {
        [UIView animateWithDuration:0.2 animations:^{
            CGPoint center = self.titleLabel.center;
            center.x = self.center.x;
            self.titleLabel.center = center;
        }];
        _titleLabelCenterFlag = YES;
    }else if (!isAnimationFlag && _titleLabelCenterFlag){
        CGRect frame = self.titleLabel.frame;
        frame.origin.x = kPadding;
        [UIView animateWithDuration:0.2 animations:^{
            self.titleLabel.frame = frame;
        }];
        _titleLabelCenterFlag = NO;
    }
}

//点击返回按钮
- (void)backButtonClick:(UIButton *)btn
{
    if (_backButtonEvent) {
        _backButtonEvent();
    }
}

//关注按钮点击
- (void)collectionButtonClick:(UIButton *)btn
{
    if (_isCollection) {   //点击取消关注
        if ([[DBUtil sharedDBUtil] removeByDBWithTopicID:_topic.ID]) {
            [SVProgressHUD setMinimumDismissTimeInterval:0.8];
            [SVProgressHUD showSuccessWithStatus:@"取消关注成功"];
            _isCollection = NO;
        }
    }else{
        if ([[DBUtil sharedDBUtil] insertToDBWithTopicsModel:_topic]) {
            [SVProgressHUD setMinimumDismissTimeInterval:0.8];
            [SVProgressHUD showSuccessWithStatus:@"关注成功"];
            _isCollection = YES;
        }
    }
    [self updateCollectionButtonImage];
}

//更新按钮图片
- (void)updateCollectionButtonImage
{
    [_collectionButton setImage:[UIImage imageNamed:_isCollection?@"ic_album_nav_followed_normal_53x27_":@"ic_album_nav_follow_normal_53x27_"] forState:UIControlStateNormal];
    [_collectionButton setImage:[UIImage imageNamed:_isCollection?@"ic_album_nav_followed_pressed_53x27_":@"ic_album_nav_follow_pressed_53x27_"] forState:UIControlStateHighlighted];
}

#pragma mark - setter getter 方法

- (void)setTopic:(TopicsModel *)topic
{
    if (topic) {
        _topic = topic;
        [self.backImageView sd_setImageWithURL:[NSURL URLWithString:topic.cover_image_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            UIImage *myImage = [image blurredImageWithRadius:10 iterations:5 tintColor:[UIColor blackColor]];
            if (image) {

                self.maskView.image = myImage;
            }
        } ];
        self.backImageView.alpha = 1;
        self.titleLabel.text = topic.title;
        CGSize size = [topic.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} context:nil].size;
        self.titleLabel.frame = CGRectMake(kPadding, 0, size.width, size.height);
        
        _isCollection = [[DBUtil sharedDBUtil]isExistComicByComicID:topic.ID];
        
        [self updateCollectionButtonImage];
    }
}

- (UIImageView *)backImageView
{
    if (_backImageView == nil) {
        _backImageView = [[UIImageView alloc]init];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backImageView.clipsToBounds = YES;
    }
    return _backImageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIImageView *)maskView
{
    if (_maskView == nil) {
        _maskView = [[UIImageView alloc]init];
        _maskView.contentMode = UIViewContentModeScaleAspectFill;
        _maskView.clipsToBounds = YES;
        _maskView.image = [[[UIImage alloc]init] blurredImageWithRadius:10 iterations:5 tintColor:[UIColor blackColor]];
    }
    return _maskView;
}

- (UIButton *)backButton
{
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"common_navi_back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)collectionButton
{
    if (_collectionButton == nil) {
        _collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectionButton addTarget:self action:@selector(collectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectionButton;
}

@end
