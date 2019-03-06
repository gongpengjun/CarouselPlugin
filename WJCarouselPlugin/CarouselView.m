//
//  CarouselView.m
//  WJCarouselPlugin
//
//  Created by wujian on 2018/7/12.
//  Copyright © 2018年 wesk痕. All rights reserved.
//

#import "CarouselView.h"
#import "CarouselPluginDefine.h"
#import <Masonry.h>

@interface CarouselView ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation CarouselView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = RGBCOLOR(102, 102, 102);
        _titleLabel.font = kFont(40);
        _titleLabel.textColor = [UIColor colorWithRed:0x18/255.0f green:0xC4/255.0f blue:0x7C/255.0f alpha:1];
        [self addSubview:_titleLabel];

        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    return self;
}

- (void)updateContentViewWithTitle:(NSString *)title
{
    _titleLabel.text = title;
    [_titleLabel sizeToFit];
}

@end
