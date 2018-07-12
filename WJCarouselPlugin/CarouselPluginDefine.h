//
//  CarouselPluginDefine.h
//  WJCarouselPlugin
//
//  Created by wujian on 2018/7/12.
//  Copyright © 2018年 wesk痕. All rights reserved.
//

#ifndef CarouselPluginDefine_h
#define CarouselPluginDefine_h

#define kFont(i)           [UIFont systemFontOfSize:i]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define SCREEN_SIZE         [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH        SCREEN_SIZE.width
#define SCREEN_HEIGHT       SCREEN_SIZE.height

#endif /* CarouselPluginDefine_h */
