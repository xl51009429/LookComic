//
//  TopImageContentCell.m
//  LookComic
//
//  Created by 解梁 on 16/5/9.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "TopImageContentCell.h"
#import <UIImageView+WebCache.h>

@interface TopImageContentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



@end
@implementation TopImageContentCell

- (void)setModel:(TopicsModel *)model
{
    _model = model;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    _titleLabel.text = model.title;
}

@end
