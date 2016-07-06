//
//  SearchComicCell.m
//  LookComic
//
//  Created by 解梁 on 16/5/12.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "SearchComicCell.h"
#import <UIImageView+WebCache.h>
#import "XLUtil.h"
#import "DBUtil.h"

@interface SearchComicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *fllowButton;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (nonatomic, assign)BOOL isCollection;

@end
@implementation SearchComicCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - setter方法

- (void)setTopic:(TopicsModel *)topic
{
    _topic = topic;
    //设置cell的子view值
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topic.cover_image_url] placeholderImage:[UIImage imageNamed:@"community_cover_item"]];
    _titleLabel.text = topic.title;
    _authorLabel.text = topic.user.nickname;
    [_likeButton setTitle:[XLUtil convertToStringWithNumber:topic.likes_count] forState:UIControlStateNormal];
    [_commentButton setTitle:[XLUtil convertToStringWithNumber:topic.comments_count] forState:UIControlStateNormal];
    
    _isCollection = [[DBUtil sharedDBUtil]isExistComicByComicID:topic.ID];
    
    [_collectionButton setImage:[UIImage imageNamed:_isCollection?@"ic_album_nav_followed_normal_53x27_":@"ic_album_nav_follow_normal_53x27_"] forState:UIControlStateNormal];
    [_collectionButton setImage:[UIImage imageNamed:_isCollection?@"ic_album_nav_followed_pressed_53x27_":@"ic_album_nav_follow_pressed_53x27_"] forState:UIControlStateHighlighted];
}

//关注按钮点击
- (IBAction)collectionBtnClick:(UIButton *)sender {
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

@end
