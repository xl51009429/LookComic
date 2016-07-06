//
//  OtherLoginView.h
//  LookComic
//
//  Created by 解梁 on 16/5/26.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OtherLoginView;

@protocol OtherLoginViewDelegate <NSObject>

- (void)otherLoginView:(OtherLoginView *)otherLoginView didselectedAtIndex:(NSInteger)index;

@end

@interface OtherLoginView : UIView

@property (nonatomic, assign)id<OtherLoginViewDelegate> delegate;

@end
