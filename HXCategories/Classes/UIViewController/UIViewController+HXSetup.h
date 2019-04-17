//
//  UIViewController+HXSetup.h
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/4/26.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HXSetup)

/**
 *  设置导航条的背景图片
 *  @param image 导航条背景图片
 */
- (void)hx_setNavigationBarBackgroundImage:(UIImage *)image;

/**
 *  设置导航条的背景图片
 *  @param imageName 导航条背景图片
 */
- (void)hx_setNavigationBarBackgroundImageName:(NSString *)imageName;

/**
 *  设置控制器的导航条及颜色
 *
 *  @param color 导航条颜色(color = nil 时默认白色)
 *  @param show  导航条是否添加阴影
 */
- (void)hx_setNavigationBarBackgroundColor:(UIColor *)color showShadow:(BOOL)show;

/**
 *  设置控制器的标题及颜色
 *
 *  @param title 显示的标题
 *  @param color 标题的颜色(color = nil 时默认白色)
 */
- (void)hx_setNavigationControllerTitle:(NSString *)title titleColor:(UIColor *)color;

/**
 *  设置导航条左按钮
 *
 *  @param title  显示的文字
 *  @param action 点击事件
 */
- (void)hx_setLeftBarButtonWithTitle:(NSString *)title action:(SEL)action;

/**
 *  设置导航条左按钮
 *
 *  @param iconName  显示的图片名
 *  @param action 点击事件
 */
- (void)hx_setLeftBarButtonWithIcon:(NSString *)iconName action:(SEL)action;

/**
 *  设置导航条右按钮
 *
 *  @param title  显示的文字
 *  @param action 点击事件
 */
- (void)hx_setRightBarButtonWithTitle:(NSString *)title action:(SEL)action;

/**
 *  设置导航条右按钮
 *
 *  @param iconName  显示的图片名
 *  @param action 点击事件
 */
- (void)hx_setRightBarButtonWithIcon:(NSString *)iconName action:(SEL)action;


/**
 *  automaticallyAdjustsScrollViewInsets根据按所在界面的status bar，
 *  navigationbar，与tabbar的高度，自动调整scrollview的 inset,设置为no，
 *  不让viewController调整，我们自己修改布局即可
 *  iOS11以后，控制器的automaticallyAdjustsScrollViewInsets已经废弃，所以默认就会是YES
 */
- (void)hx_setCancelAutomaticallyAdjusts;

/**
 *  设置控制器默认背景色
 */
- (void)hx_setViewBackgroundColor;

/**
 *  设置导航条左双按钮
 *
 *  @param target 事件目标
 *  @param backIcon 返回icon
 *  @param backAction 返回事件
 *  @param closeIcon 关闭icon
 *  @param closeAction 关闭事件
 */
- (void)hx_setBackItemWithTarget:(id)target
                        backIcon:(NSString *)backIcon
                      backAction:(SEL)backAction
                       closeIcon:(NSString *)closeIcon
                     closeAction:(SEL)closeAction;

/**
 *  设置导航条左双按钮
 *
 *  @param target 事件目标
 *  @param backTitle 返回标题
 *  @param backAction 返回事件
 *  @param closeTitle 关闭标题
 *  @param closeAction 关闭事件
 */
- (void)hx_setBackItemWithTarget:(id)target
                       backTitle:(NSString *)backTitle
                      backAction:(SEL)backAction
                      closeTitle:(NSString *)closeTitle
                     closeAction:(SEL)closeAction;

/**
 *  隐藏导航条左按钮
 */
- (void)hx_hiddenLeftItemButton;

/**
 *  隐藏导航条右按钮
 */
- (void)hx_hiddenRightItemButton;

/**
 *  隐藏导航条下边的线
 */
- (void)hx_hiddenNavgationBarLine;

/**
 *  显示导航条下边的线
 */
- (void)hx_showNavigationBarLine;

/**
 *  设置返回按钮
 *
 *  @param icon 图片名称，icon == nil --> icon = @"icon_back_white"
 */
- (void)hx_setBackItemWithIcon:(NSString *)icon;

/**
 *  返回事件(可重写)
 */
- (void)hx_onBack;


@end
