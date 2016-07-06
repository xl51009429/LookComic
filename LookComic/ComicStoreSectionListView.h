//
//  ComicStoreSectionListView.h
//  LookComic
//
//  Created by 解梁 on 16/5/6.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ComicStoreSectionListView;

@protocol ComicStoreSectionListViewDelegate <NSObject>

- (void)comicStoreSectionListView:(ComicStoreSectionListView *)comicStoreSectionListView didSelectItemAtBookID:(NSNumber *)bookID;

- (void)comicStoreSectionListView:(ComicStoreSectionListView *)comicStoreSectionListView didSelectItemAtSectionTitle:(NSString *)sectionTitle;

@end

@interface ComicStoreSectionListView : UICollectionView

@property (nonatomic, strong)NSArray *bannerArray;     //轮播图数组
@property (nonatomic, strong)NSArray *sectionArray;    //内容的栏目数组

@property (nonatomic, assign)id<ComicStoreSectionListViewDelegate> comicDelegate;

@end
