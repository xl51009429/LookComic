//
//  LeftImageContentCell.m
//  LookComic
//
//  Created by 解梁 on 16/5/9.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "LeftImageContentCell.h"
#import <UIImageView+WebCache.h>

@interface LeftImageContentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;



@end
@implementation LeftImageContentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(TopicsModel *)model
{
    _model = model;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    _titleLabel.text = model.title;
    _descriptionLabel.text = model.descri;
}

@end
