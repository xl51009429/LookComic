//
//  SearchComicView.h
//  LookComic
//
//  Created by 解梁 on 16/5/12.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchComicCell.h"

@class SearchComicView;

@protocol SearchComicViewDelegate <NSObject>

- (void)searchComicViewDidScroll:(SearchComicView *)searchComicView;
- (void)searchComicView:(SearchComicView *)searchComicView didSelectedAtTopicID:(NSNumber *)topicID;

@end

@interface SearchComicView : UICollectionView

@property (nonatomic, retain)NSArray *topics;
@property (nonatomic, assign)id<SearchComicViewDelegate> viewDelegate;

@end
