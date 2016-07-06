//
//  ChapterSectionHeaderView.h
//  LookComic
//
//  Created by 解梁 on 16/5/10.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ChapterSectionHeaderButtonKind){
    ChapterSectionHeaderSummaryKind = 1,
    ChapterSectionHeaderContentKind,
    ChapterSectionHeaderSortKind
};

@class ChapterSectionHeaderView;

@protocol ChapterSectionHeaderViewDelegate <NSObject>

- (void)chapterSectionHeaderView:(ChapterSectionHeaderView *)chapterSectionHeaderView didSelectedAtIndex:(ChapterSectionHeaderButtonKind)index headerViewHeight:(CGFloat)height;

@end

@interface ChapterSectionHeaderView : UICollectionReusableView

@property (nonatomic, assign)id<ChapterSectionHeaderViewDelegate> delegate;
@property (nonatomic, copy)NSString *descri;

@end
