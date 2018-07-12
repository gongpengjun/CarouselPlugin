//
//  WeakTimerTarget.h
//  PaoBa
//
//  Created by wujian on 4/18/16.
//  Copyright © 2016 wesk痕. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TimerHandler)(id userInfo);

@interface WeakTimerTarget : NSObject

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                     target:(id)aTarget
                                   selector:(SEL)aSelector
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats;

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval
                            target:(id)aTarget
                          selector:(SEL)aSelector
                          userInfo:(id)userInfo
                           repeats:(BOOL)repeats;

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(TimerHandler)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats;

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval
                             block:(TimerHandler)block
                          userInfo:(id)userInfo
                           repeats:(BOOL)repeats;


@end
