//
//  ChapterHeaderView.h
//  LookComic
//
//  Created by 解梁 on 16/5/10.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicsModel.h"

static NSString *chapterMainHeaderViewKind = @"chapterMainHeaderViewKind";

typedef void(^BackButtonEvent)();

@interface ChapterMainHeaderView : UICollectionReusableView

@property (nonatomic, retain)TopicsModel *topic;
@property (nonatomic, copy)BackButtonEvent backButtonEvent;

@end
