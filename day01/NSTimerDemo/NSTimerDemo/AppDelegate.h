//
//  AppDelegate.h
//  NSTimerDemo
//
//  Created by student on 15-11-16.
//  Copyright (c) 2015年 郭永峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSTimer * _timer;//用来定时改变label的位置
}

@property (strong, nonatomic) UIWindow *window;

@end
