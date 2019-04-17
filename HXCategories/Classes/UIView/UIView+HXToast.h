//
//  UIView+HXToast.h
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/4/27.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HXToast)

/**
 *  提示框（默认时长2s，默认位置居下）
 *
 *  @param message 提示信息文本
 */
- (void)hx_displayMessage:(NSString *)message;

/**
 *  提示框
 *
 *  @param message  提示信息文本
 *  @param interval 显示时长（单位：s）
 *  @param position 显示位置（top、bottom、center）
 */
- (void)hx_displayMessage:(NSString *)message duration:(CGFloat)interval position:(id)position;


/* How to do use ? [self.view displayError:@"提示信息"] */
/**
 *  提示框（从导航条下划出）
 *
 *  @param error 提示错误文本信息
 */
- (void)hx_displayError:(NSString *)error;

/**
 *  提示框（从导航条下划出）
 *
 *  @param error  提提示错误文本信息
 *  @param interval 显示时长（单位：s）
 */
- (void)hx_displayError:(NSString *)error duration:(CGFloat)interval;

@end
