//
//  ComicChapterFlowLayout.m
//  LookComic
//
//  Created by 解梁 on 16/5/10.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "ComicChapterFlowLayout.h"
#import "ChapterMainHeaderView.h"

@interface ComicChapterFlowLayout ()

@property (nonatomic, assign)CGFloat height;

@end
@implementation ComicChapterFlowLayout

- (instancetype)init
{
    if (self = [super init]) {
        _height = kChapterHeaderHeight;
    }
    return self;
}

- (CGSize)collectionViewContentSize
{
    CGSize size = [super collectionViewContentSize];
    size.height += _height ;
    return size;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [[super layoutAttributesForElementsInRect:rect]copy];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        CGRect frame = attribute.frame;
        frame.origin.y += _height;
        attribute.frame = frame;
    }
    
    UICollectionViewLayoutAttributes *headerAttri = [self layoutAttributesForSupplementaryViewOfKind:chapterMainHeaderViewKind atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    headerAttri.zIndex = 100;
    NSMutableArray *arr = [NSMutableArray arrayWithArray:attributes];
    [arr addObject:headerAttri];
    
    return arr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * attribute = [[UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath] copy];
    CGFloat offset_Y = self.collectionView.contentOffset.y;
    CGFloat height = 0.0;
    if (offset_Y >= (_height - 64)) {
        height = 64;
    }else{
        height = _height - offset_Y;
    }
    attribute.frame = CGRectMake(0, offset_Y, kScreenWidth, height);
    return attribute;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
