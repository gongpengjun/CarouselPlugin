//
//  AppDelegate.m
//  WJCarouselPlugin
//
//  Created by wujian on 2018/7/12.
//  Copyright © 2018年 wesk痕. All rights reserved.
//

#import "CarouselPlugin.h"
#import "WeakTimerTarget.h"
//#import <Masonry.h>

@interface CarouselPlugin () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *scrollView;

@property (nonatomic, weak) UIView   *firstView;
@property (nonatomic, weak) UIView   *secondView;
@property (nonatomic, weak) UIView   *thirdView;

@property (nonatomic, weak) id<CarouselPluginDelegate> delegate;

/** 页面 size **/
@property (nonatomic, assign) CGSize scrollViewSize;
/** 当前页面index **/
@property (nonatomic, assign) NSInteger currentViewIndex;
/** timer **/
@property (nonatomic, strong) NSTimer   *viewTimer;
/** 试图个数 **/
@property (nonatomic, assign) NSInteger viewCount;

/** 滚动方向 默认朝上滚**/
@property (nonatomic, assign) ViewScrollDirection scrollDirection;
/** 是否水平 默认是false 垂直 受scrollDirection 影响**/
@property (nonatomic, assign) BOOL horizontalDir;
/** 是否支持拖动 默认不支持**/
@property (nonatomic, assign) BOOL dragEnable;
/** 页面停留时间 默认3秒 **/
@property (nonatomic, assign) CGFloat viewDwellTime;
/** 页面滚动的时间 **/
@property (nonatomic, assign) CGFloat viewScrollTime;

@end

#define kViewDwellTimeInterval 3
#define KViewScrollTimeInterval 0.3
@implementation CarouselPlugin

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewDwellTime = kViewDwellTimeInterval;
        self.viewScrollTime = KViewScrollTimeInterval;
        self.dragEnable = YES;
//        self.scrollView.userInteractionEnabled = self.dragEnable = YES;
        self.scrollDirection = ViewScrollDirectionUp;
        self.horizontalDir = NO;
    }
    return self;
}

#pragma mark - privateMethod
- (void)refreshScrollViewConfig
{
    if (self.horizontalDir) {
        _scrollView.contentSize = CGSizeMake(3 * self.scrollViewSize.width, 0);
        [_scrollView setContentOffset:CGPointMake(self.scrollViewSize.width, 0) animated:NO];
    }
    else{
        _scrollView.contentSize = CGSizeMake(0, 3 * self.scrollViewSize.height);
        [_scrollView setContentOffset:CGPointMake(0, self.scrollViewSize.height) animated:NO];
    }
    
    _scrollView.scrollEnabled = self.dragEnable;
    _scrollView.pagingEnabled = self.dragEnable;
}

- (void)addScrollSubView:(int)index
{
    if ((index == 0 && _firstView) || (index == 1 && _secondView) || (index == 2 && _thirdView)) {
        return;
    }

    CGFloat contentWidth = self.scrollViewSize.width;
    CGFloat contentHeight = self.scrollViewSize.height;
    UIView *view = [self.delegate carouselPlugin:self viewForIndex:0];
    [self.scrollView addSubview:view];
    if (index == 0) {
        view.frame = CGRectMake(0, 0, contentWidth, contentHeight);
        self.firstView = view;
    }
    else if (index == 1)
    {
        view.frame = CGRectMake(self.horizontalDir?contentWidth:0, self.horizontalDir?0:contentHeight, contentWidth, contentHeight);
        self.secondView = view;
    }
    else if (index == 2)
    {
        view.frame = CGRectMake(self.horizontalDir?contentWidth*2:0, self.horizontalDir?0:contentHeight*2, contentWidth, contentHeight);
        self.thirdView = view;
    }
}

- (void)dealloc
{
    NSLog(@"dealloc");
}

#pragma mark - publicMethod
- (void)setCurrentScrollDirection:(ViewScrollDirection)direction
{
    self.scrollDirection = direction;
    if (direction == ViewScrollDirectionLeft || direction == ViewScrollDirectionRight) {
        self.horizontalDir = true;
    }
    else{
        self.horizontalDir = false;
    }
}

- (void)setCurrentScrollDrag:(BOOL)dragEnable
{
    self.scrollView.userInteractionEnabled = dragEnable;
}

- (void)setCurrentSubViewDwellTime:(CGFloat)time
{
    self.viewDwellTime = time;
}

- (void)setCurrentSubViewScrollTime:(CGFloat)time
{
    self.viewScrollTime = time;
}

- (void)loadScrollViewFrame:(CGRect)frame delegate:(id<CarouselPluginDelegate>)delegate
{
    self.scrollViewSize = frame.size;
    self.delegate = delegate;
    self.scrollView.frame = frame;
}

- (UIScrollView *)currentScrollView
{
    return self.scrollView;
}

- (void)startRefreshScollView
{
    [self refreshScrollViewConfig];

    self.viewCount = [self.delegate numberOfViewsInCarouselPlugin:self];
    if (self.viewCount == 0) {
        return;
    }
    
    /** 展示3个坑位 ps:不可拖动等情况可以只占两个坑位的**/
    for(int i = 0; i < 3 ; i ++) {
        [self addScrollSubView:i];
    }

    _currentViewIndex = 0;
    [self.delegate reloadCurrentView:self.secondView viewForIndex:0];
    
    //preload next view
    if (self.viewCount > 1) {
        if (self.scrollDirection == ViewScrollDirectionRight || self.scrollDirection == ViewScrollDirectionDown) {
            //向👉👇 加载前一张视图 (self.viewCount-1)
            [self.delegate reloadCurrentView:self.firstView viewForIndex:(self.viewCount-1)];
        }
        else
        {   //向👈👆 加载后一张视图 (1)
            [self.delegate reloadCurrentView:self.thirdView viewForIndex:1];
        }
        [self startViewTimer];
    }
    else{
        if (self.horizontalDir) {
            [_scrollView setContentOffset:CGPointMake(self.scrollViewSize.width, 0) animated:NO];
        }
        else{
            [_scrollView setContentOffset:CGPointMake(0, self.scrollViewSize.height) animated:NO];
        }
        _scrollView.scrollEnabled = NO;
        [self releaseViewTimer];
    }
}

- (void)releaseContentView
{
    [self releaseViewTimer];
    self.viewCount = 0;
    _currentViewIndex = 0;
    if (_firstView) {
        [_firstView removeFromSuperview];
        _firstView = nil;
    }
    if (_secondView) {
        [_secondView removeFromSuperview];
        _secondView = nil;
    }
    if (_thirdView) {
        [_thirdView removeFromSuperview];
        _thirdView = nil;
    }
}

#pragma mark - NSTimer
/** 开启timer **/
- (void)startViewTimer
{
    [self releaseViewTimer];
    if (!_viewTimer) {
        _viewTimer = [WeakTimerTarget timerWithTimeInterval:(self.viewDwellTime+self.viewScrollTime) target:self selector:@selector(viewScroll) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_viewTimer forMode:NSRunLoopCommonModes];
    }
}

/** 释放timer **/
- (void)releaseViewTimer
{
    if (_viewTimer)
    {
        if (_viewTimer.isValid) {
            [_viewTimer invalidate];
        }
        _viewTimer = nil;
    }
}

- (void)viewScroll
{
    [UIView animateWithDuration:self.viewScrollTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        switch (self.scrollDirection) {
            case ViewScrollDirectionLeft:
                [self.scrollView setContentOffset:CGPointMake(self.scrollViewSize.width*2, 0) animated:NO];
                break;
            case ViewScrollDirectionRight:
                [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
                break;
            case ViewScrollDirectionUp:
                [self.scrollView setContentOffset:CGPointMake(0, self.scrollViewSize.height*2) animated:NO];
                break;
            case ViewScrollDirectionDown:
                [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        [self scrollViewDidEndDecelerating:self.scrollView];
    }];
}

/** 刷新页面 **/
- (void)reloadViews
{
    if (self.viewCount == 0) {
        [self releaseViewTimer];
        return;
    }
    NSUInteger firstViewIndex, thirdViewIndex;
    
    CGPoint offset = [_scrollView contentOffset];
    
    if (self.horizontalDir) {
        //水平
        if (offset.x > self.scrollViewSize.width) { //向右滑动
            _currentViewIndex = (_currentViewIndex+1) % self.viewCount;
        }
        else if(offset.x < self.scrollViewSize.width) { //向左滑动
            _currentViewIndex = (_currentViewIndex + self.viewCount -1) % self.viewCount;
        }
    }
    else{
        //垂直
        if (offset.y > self.scrollViewSize.height) { //向下滑动
            _currentViewIndex = (_currentViewIndex+1) % self.viewCount;
        }
        else if(offset.y < self.scrollViewSize.height) { //向上滑动
            _currentViewIndex = (_currentViewIndex + self.viewCount-1) % self.viewCount;
        }
    }
    
    [self.delegate reloadCurrentView:self.secondView viewForIndex:_currentViewIndex];
    
    if (self.dragEnable) {
        //可拖动的 展示前后两张视图 (0,1,2)
        firstViewIndex = (_currentViewIndex + self.viewCount - 1) % self.viewCount;
        [self.delegate reloadCurrentView:self.firstView viewForIndex:firstViewIndex];
        thirdViewIndex = (_currentViewIndex  + 1) % self.viewCount;
        [self.delegate reloadCurrentView:self.thirdView viewForIndex:thirdViewIndex];
    }
    else
    {
        if (self.scrollDirection == ViewScrollDirectionLeft || self.scrollDirection == ViewScrollDirectionUp) {
            //向👈👆 加载后一张视图 (1,2)
            thirdViewIndex = (_currentViewIndex  + 1) % self.viewCount;
            [self.delegate reloadCurrentView:self.thirdView viewForIndex:thirdViewIndex];
        }
        else
        {   //向👉👇 加载前一张视图 (0,1)
            firstViewIndex = (_currentViewIndex + self.viewCount - 1) % self.viewCount;
            [self.delegate reloadCurrentView:self.firstView viewForIndex:firstViewIndex];
        }
    }
}


#pragma mark - UIScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self releaseViewTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startViewTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reloadViews];
    if (self.horizontalDir) {
        [_scrollView setContentOffset:CGPointMake(self.scrollViewSize.width, 0) animated:NO];
    }
    else{
        [_scrollView setContentOffset:CGPointMake(0, self.scrollViewSize.height) animated:NO];
    }
}

#pragma mark - setter/getter
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.bounces = NO;
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}

@end
