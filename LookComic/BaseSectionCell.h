//
//  BaseSectionCell.h
//  LookComic
//
//  Created by 解梁 on 16/5/9.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionModel.h"

@class BaseSectionCell;

@protocol BaseSectionCellDelegate <NSObject>

- (void)baseSectionCell:(BaseSectionCell *)baseSectionCell didSelectedAtBookID:(NSNumber *)bookID;

- (void)baseSectionCell:(BaseSectionCell *)baseSectionCell didSelectedAtSectionTitle:(NSString *)sectionTitle;

@end

@interface BaseSectionCell : UICollectionViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic, retain)SectionModel *section;

@property (nonatomic, assign)id<BaseSectionCellDelegate> delegate;

- (void)registerCell;

@end
