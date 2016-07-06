//
//  SearchBar.h
//  LookComic
//
//  Created by 解梁 on 16/5/13.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchBar;

@protocol SearchBarDelegate <NSObject>

- (void)searchBar:(SearchBar *)searchBar didChangedWithValue:(NSString *)value;
- (void)searchBarHaveNilValue:(SearchBar *)searchBar;

@end

@interface SearchBar : UITextField

@property (nonatomic, assign)id<SearchBarDelegate> barDelegate;

@end
