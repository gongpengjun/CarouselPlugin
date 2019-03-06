//
//  ViewController.m
//

#import "ViewController.h"
#import "CarouselPlugin.h"
#import "CarouselView.h"
#import "CarouselPluginDefine.h"

#define KScrollBottomViewHeight 50

@interface ViewController ()<CarouselPluginDelegate>
@property (nonatomic, strong) CarouselPlugin *carouselPlugin;
@property (nonatomic, strong) UIScrollView *scrollBottomView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.carouselPlugin = [CarouselPlugin new];
    [self.carouselPlugin setCurrentScrollDirection:ViewScrollDirectionUp];
    [self.carouselPlugin setCurrentSubViewDwellTime:1];
    [self.carouselPlugin setCurrentSubViewScrollTime:1];
    [self.carouselPlugin setViewScrollAnimationOptions:UIViewAnimationOptionCurveEaseOut];
    [self.carouselPlugin loadScrollViewFrame:CGRectMake(15, 300, SCREEN_WIDTH-30, KScrollBottomViewHeight) delegate:self];
    
    self.scrollBottomView = [self.carouselPlugin currentScrollView];
    self.scrollBottomView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.scrollBottomView];
    
    [self.carouselPlugin startRefreshScollView];
}

#pragma mark - CarouselPluginDelegate

- (NSInteger)numberOfViewsInCarouselPlugin:(CarouselPlugin *)carouselPlugin
{
    return 2;
}

- (UIView *)carouselPlugin:(CarouselPlugin *)carouselPlugin viewForIndex:(NSInteger)index
{
    CarouselView *contentview = [[CarouselView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH-30, KScrollBottomViewHeight)];
    NSLog(@"index: %@, contentview: %p",@(index), contentview);
    return contentview;
}

- (void)reloadCurrentView:(UIView *)view viewForIndex:(NSInteger)index
{
    NSLog(@"index: %@, view: %p",@(index), view);
    CarouselView *contentview = (CarouselView *)view;
    if (index % 2 == 0) {
        [contentview updateContentViewWithTitle:@"Searching trips"];
        //contentview.backgroundColor = [UIColor greenColor];
    } else {
        [contentview updateContentViewWithTitle:@"You are online"];
        //contentview.backgroundColor = [UIColor redColor];
    }
}

@end
