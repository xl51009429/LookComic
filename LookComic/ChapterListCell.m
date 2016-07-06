//
//  ChapterListCell.m
//  LookComic
//
//  Created by 解梁 on 16/5/10.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "ChapterListCell.h"
#import <UIImageView+WebCache.h>
#import "XLUtil.h"

@interface ChapterListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeCountButton;


@end

@implementation ChapterListCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - setter方法

- (void)setChapter:(ChapterModel *)chapter
{
    _chapter = chapter;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:chapter.cover_image_url]];
    _titleLabel.text = chapter.title;
    _createTimeLabel.text = [XLUtil convertToTimeStringWithNumber:chapter.created_at];
    [_likeCountButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [_likeCountButton setTitle:[NSString stringWithFormat:@" %@",chapter.likes_count] forState:UIControlStateNormal];
}

@end
