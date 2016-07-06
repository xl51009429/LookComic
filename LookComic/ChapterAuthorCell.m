//
//  ChapterAuthorCell.m
//  LookComic
//
//  Created by 解梁 on 16/5/11.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "ChapterAuthorCell.h"
#import <UIImageView+WebCache.h>

@interface ChapterAuthorCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nickName;

@end
@implementation ChapterAuthorCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - setter getter方法

- (void)setUser:(UserModel *)user
{
    _user = user;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:user.avatar_url]];
    _nickName.text = user.nickname;
}

@end
