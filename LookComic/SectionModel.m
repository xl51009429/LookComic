//
//  SectionModel.m
//  LookComic
//
//  Created by 解梁 on 16/5/6.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "SectionModel.h"

@interface SectionModel ()

@property (nonatomic, copy)NSArray *contentCounts;
@property (nonatomic, copy)NSArray *contentCellHeights;

@end
@implementation SectionModel

#pragma mark - setter getter方法

- (void)setType:(NSInteger)type
{
    _type = type;
    
    _contentCount = type < 2?[self.contentCounts[type] integerValue]:[self.contentCounts[(type-2)%3 + 2] integerValue];
    
    _contentCellHeight = type < 2?[self.contentCellHeights[type] floatValue]:[self.contentCellHeights[(type-2)%3 + 2] floatValue];
}

- (NSArray *)contentCellHeights
{
    if (_contentCellHeights == nil) {
        _contentCellHeights = @[@210,
                                @360,
                                @270,
                                @250,
                                @250];
    }
    return _contentCellHeights;
}

- (NSArray *)contentCounts
{
    if (_contentCounts == nil) {
        _contentCounts = @[@14,
                           @6,
                           @3,
                           @4,
                           @2];
    }
    return _contentCounts;
}

@end
