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
@property (nonatomic, strong) UIImageView *gemImageView;
@property (nonatomic, strong) UILabel *numLabel;

@end

@implementation CarouselView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.gemImageView];
        [self addSubview:self.numLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(self);
        }];
        
        [_gemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(5);
            make.centerY.equalTo(self.titleLabel);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
        
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.gemImageView.mas_right).offset(2);
            make.centerY.equalTo(self.titleLabel);
        }];
    }
    return self;
}

- (void)loadContentViewWithIndex:(NSInteger)index
{
    _titleLabel.text = [NSString stringWithFormat:@"上拉下滑123456::::%ld",index];
    _numLabel.text = @"X14";
    [_titleLabel sizeToFit];
    [_numLabel sizeToFit];
}

#pragma mark - setter/getter
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = RGBCOLOR(102, 102, 102);
        _titleLabel.font = kFont(12);
    }
    return _titleLabel;
}

- (UIImageView *)gemImageView
{
    if (!_gemImageView) {
        _gemImageView = [UIImageView new];
        _gemImageView.image = [UIImage imageNamed:@"gem"];
    }
    return _gemImageView;
}

- (UILabel *)numLabel
{
    if (!_numLabel) {
        _numLabel = [UILabel new];
        _numLabel.textColor = RGBCOLOR(102, 102, 102);
        _numLabel.font = kFont(11);
    }
    return _numLabel;
}
@end
