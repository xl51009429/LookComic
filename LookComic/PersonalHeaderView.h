//
//  PersonalHeaderView.h
//  LookComic
//
//  Created by 解梁 on 16/5/25.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonalHeaderView;

@protocol PersonalHeaderViewDelegate <NSObject>

- (void)iconButtonClickedInPersonalHeaderView:(PersonalHeaderView *)personalHeaderView;

@end

@interface PersonalHeaderView : UIView

@property (nonatomic, assign)id<PersonalHeaderViewDelegate> delegate;

@end
