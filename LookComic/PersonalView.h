//
//  PersonalView.h
//  LookComic
//
//  Created by 解梁 on 16/5/25.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonalView;

@protocol PersonalViewDelegate <NSObject>

- (void)PersonalView:(PersonalView *)personalView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)iconButtonClickedInPersonalView:(PersonalView *)personalView;

@end

@interface PersonalView : UITableView

@property (nonatomic, assign)id<PersonalViewDelegate> personalDelegate;

@end
