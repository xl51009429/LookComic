//
//  ChapterListView.h
//  LookComic
//
//  Created by 解梁 on 16/5/10.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicsModel.h"
#import "ChapterMainHeaderView.h"

@class ChapterListView;

@protocol ChapterListViewDelegate <NSObject>

- (void)chapterListView:(ChapterListView *)chapterListView didSelectedAtChapterID:(NSNumber *)chapterID;

@end

@interface ChapterListView : UICollectionView

@property (nonatomic,retain)TopicsModel *topic;
@property (nonatomic,assign)id<ChapterListViewDelegate> chapterDelegate;
@property (nonatomic,copy)BackButtonEvent backButtonEvent;

@end
