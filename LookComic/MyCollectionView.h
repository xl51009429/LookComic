//
//  MyCollectionView.h
//  LookComic
//
//  Created by 解梁 on 16/5/16.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicsModel.h"

@class MyCollectionView;

@protocol MyCollectionViewDelegate <NSObject>

- (void)myCollectionView:(MyCollectionView *)myCollectionView didSelectedAtTopicID:(NSNumber *)topicID;

@end

@interface MyCollectionView : UITableView

@property (nonatomic, retain)NSMutableArray *topics;
@property (nonatomic, assign)id<MyCollectionViewDelegate> viewDelegate;

@end
