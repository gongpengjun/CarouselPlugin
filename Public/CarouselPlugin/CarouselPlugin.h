//
//  AppDelegate.m
//  WJCarouselPlugin
//
//  Created by wujian on 2018/7/12.
//  Copyright © 2018年 wesk痕. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CarouselPlugin;
@protocol CarouselPluginDelegate <NSObject>

@required
- (UIView *)carouselPlugin:(CarouselPlugin *)carouselPlugin viewForIndex:(NSInteger)index;

- (NSInteger)numberOfViewsInCarouselPlugin:(CarouselPlugin *)carouselPlugin;

- (void)reloadCurrentView:(UIView *)view viewForIndex:(NSInteger)index;

@optional


@end

typedef NS_ENUM(NSInteger, ViewScrollDirection) {
    /** 朝上滚 **/
    ViewScrollDirectionUp = 0,
    /** 朝下滚 **/
    ViewScrollDirectionDown,
    /** 朝左滚 **/
    ViewScrollDirectionLeft,
    /** 朝右滚 **/
    ViewScrollDirectionRight
};

@interface CarouselPlugin : NSObject


/** 设置当前滚动试图的方向 默认朝上 **/
- (void)setCurrentScrollDirection:(ViewScrollDirection)direction;

/** 设置当前页面是否支持拖动(左右或上下) 默认不支持**/
- (void)setCurrentScrollDrag:(BOOL)dragEnable;

/** 设置试图停留时间。默认3秒 **/
- (void)setCurrentSubViewDwellTime:(CGFloat)time;

/** 页面朝着某个方向滚动的时间 默认是0.3秒 **/
- (void)setCurrentSubViewScrollTime:(CGFloat)time;

/** 页面滚动的动画选项 **/
- (void)setViewScrollAnimationOptions:(UIViewAnimationOptions)options;

/** 初始化scrollView 设置frame和代理 滚动的视图大小等于frame.size**/
- (void)loadScrollViewFrame:(CGRect)frame delegate:(id<CarouselPluginDelegate>)delegate;

/** 获取当前ScrollView **/
- (UIScrollView *)currentScrollView;

/** 展示界面 **/
- (void)startRefreshScollView;

/** 释放页面元素 **/
- (void)releaseContentView;
@end
