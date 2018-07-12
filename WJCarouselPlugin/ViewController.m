//
//  ViewController.m
//  WJCarouselPlugin
//
//  Created by wujian on 2018/7/12.
//  Copyright © 2018年 wesk痕. All rights reserved.
//

#import "ViewController.h"
#import "CarouselPlugin.h"
#import "CarouselView.h"
#import "CarouselPluginDefine.h"

#define KScrollBottomViewHeight 15

@interface ViewController ()<CarouselPluginDelegate>

@property (nonatomic, strong) CarouselPlugin *carouselPlugin;
@property (nonatomic, strong) UIScrollView *scrollBottomView;

@property (nonatomic, strong) CarouselPlugin *carouselPlugin1;
@property (nonatomic, strong) UIScrollView *scrollBottomView1;

@property (nonatomic, strong) CarouselPlugin *carouselPlugin2;
@property (nonatomic, strong) UIScrollView *scrollBottomView2;

@property (nonatomic, strong) CarouselPlugin *carouselPlugin3;
@property (nonatomic, strong) UIScrollView *scrollBottomView3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _scrollBottomView = [self.carouselPlugin currentScrollView];
    [self.view addSubview:self.scrollBottomView];
    [_carouselPlugin startRefreshScollView];

    
    _scrollBottomView1 = [self.carouselPlugin1 currentScrollView];
    [self.view addSubview:self.scrollBottomView1];
    [_carouselPlugin1 startRefreshScollView];
    
    _scrollBottomView2 = [self.carouselPlugin2 currentScrollView];
    [self.view addSubview:self.scrollBottomView2];
    [_carouselPlugin2 startRefreshScollView];
    
    
    _scrollBottomView3 = [self.carouselPlugin3 currentScrollView];
    [self.view addSubview:self.scrollBottomView3];
    [_carouselPlugin3 startRefreshScollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CarouselPluginDelegate

- (void)reloadCurrentView:(UIView *)view viewForIndex:(NSInteger)index
{
    CarouselView *contentview = (CarouselView *)view;
    [contentview loadContentViewWithIndex:index];
}

- (UIView *)carouselPlugin:(CarouselPlugin *)carouselPlugin viewForIndex:(NSInteger)index
{
    CarouselView *contentview = [[CarouselView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH-30, KScrollBottomViewHeight)];
    return contentview;
}

- (NSInteger)numberOfViewsInCarouselPlugin:(CarouselPlugin *)carouselPlugin
{
    return 2;
}


#pragma mark - setter/getter
- (CarouselPlugin *)carouselPlugin
{
    if (!_carouselPlugin) {
        _carouselPlugin = [CarouselPlugin new];
        [_carouselPlugin setCurrentScrollDirection:ViewScrollDirectionRight];
        [_carouselPlugin setCurrentSubViewScrollTime:5];
        [_carouselPlugin setCurrentSubViewDwellTime:1];
        [_carouselPlugin loadScrollViewFrame:CGRectMake(15, 100, SCREEN_WIDTH-30, KScrollBottomViewHeight) delegate:self];
    }
    return _carouselPlugin;
}

- (CarouselPlugin *)carouselPlugin1
{
    if (!_carouselPlugin1) {
        _carouselPlugin1 = [CarouselPlugin new];
        [_carouselPlugin1 setCurrentScrollDirection:ViewScrollDirectionLeft];
        [_carouselPlugin1 setCurrentSubViewScrollTime:3];
        [_carouselPlugin1 setCurrentScrollDrag:YES];
        [_carouselPlugin1 loadScrollViewFrame:CGRectMake(15, 200, SCREEN_WIDTH-30, KScrollBottomViewHeight) delegate:self];
    }
    return _carouselPlugin1;
}

- (CarouselPlugin *)carouselPlugin2
{
    if (!_carouselPlugin2) {
        _carouselPlugin2 = [CarouselPlugin new];
        [_carouselPlugin2 loadScrollViewFrame:CGRectMake(15, 300, SCREEN_WIDTH-30, KScrollBottomViewHeight) delegate:self];
    }
    return _carouselPlugin2;
}

- (CarouselPlugin *)carouselPlugin3
{
    if (!_carouselPlugin3) {
        _carouselPlugin3 = [CarouselPlugin new];
        [_carouselPlugin3 setCurrentScrollDirection:ViewScrollDirectionDown];
        [_carouselPlugin3 setCurrentSubViewScrollTime:0.5];
        [_carouselPlugin3 setCurrentSubViewDwellTime:2];
        [_carouselPlugin3 loadScrollViewFrame:CGRectMake(15, 400, SCREEN_WIDTH-30, KScrollBottomViewHeight) delegate:self];
    }
    return _carouselPlugin3;
}

@end
