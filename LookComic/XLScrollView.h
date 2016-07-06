//
//  XLScrollView.h
//  LunBoDemo
//
//  Created by 解梁 on 16/3/8.
//  Copyright © 2016年 XieLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLScrollView;

@protocol XLScrollDelegate <NSObject>

- (void)xlScrollView:(XLScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index;

@end

@interface XLScrollView : UIView

/**
 *  遵循XLScrollDelegate协议的代理对象
 */
@property (nonatomic,assign)id<XLScrollDelegate> delegate;

/**
 *  网络图片加载失败时的默认图片 默认nil
 */
@property (nonatomic,copy)NSString *defaultImage;

/**
 *  轮播时间间隔 默认4.0
 */
@property (nonatomic,assign)NSTimeInterval timeInterval;

/**
 *  轮播图片，可以init方法指定，也可以直接赋值
 */
@property (nonatomic,copy)NSArray *images;

/**
 *  代理模式的初始化方法
 *
 *  @param frame  控件的frame
 *  @param images 轮播图的url数组
 *
 *  @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray *)images;

@end
