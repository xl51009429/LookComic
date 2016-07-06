//
//  MycollectionCell.m
//  LookComic
//
//  Created by 解梁 on 16/5/17.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "MycollectionCell.h"
#import <UIImageView+WebCache.h>

@interface MycollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end
@implementation MycollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setter 方法

- (void)setTopic:(TopicsModel *)topic
{
    _topic = topic;
    //设置cell的子view值
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:topic.cover_image_url] placeholderImage:[UIImage imageNamed:@"community_cover_item"]];
    _titleLabel.text = topic.title;
    _authorLabel.text = topic.user.nickname;
    [_likeButton setTitle:[XLUtil convertToStringWithNumber:topic.likes_count] forState:UIControlStateNormal];
    [_commentButton setTitle:[XLUtil convertToStringWithNumber:topic.comments_count] forState:UIControlStateNormal];
}

@end
