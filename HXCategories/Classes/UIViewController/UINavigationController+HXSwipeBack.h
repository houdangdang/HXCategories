//
//  UINavigationController+HXSwipeBack.h
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/4/24.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HXSwipeBack)

/// 隐藏NavigationBar（默认NO）
@property (nonatomic, assign) BOOL hx_prefersNavigationBarHidden;
/// 关闭某个控制器的pop手势（默认NO）
@property (nonatomic, assign) BOOL hx_interactivePopDisabled;
/// 自定义的滑动返回手势是否与其他手势共存，一般使用默认值(默认返回NO：不与任何手势共存)
@property (nonatomic, assign) BOOL hx_recognizeSimultaneouslyEnable;

@end

typedef NS_ENUM(NSInteger,HXFullscreenPopGestureStyle) {
    HXFullscreenPopGestureGradientStyle,   // 根据滑动偏移量背景颜色渐变
    HXFullscreenPopGestureShadowStyle      // 侧边阴影效果，类似系统的滑动样式
};

@interface UINavigationController (HXSwipeBack)<UIGestureRecognizerDelegate>
/// 滑动返回时侧边阴影效果
@property (nonatomic, assign) HXFullscreenPopGestureStyle popGestureStyle;
@property (nonatomic, assign) BOOL hx_viewControllerBasedNavigationBarAppearanceEnabled;
@end
