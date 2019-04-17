//
//  UIBarButtonItem+HXCustomView.h
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/4/25.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HXUIBarButtonItemAligment) {
    HXUIBarButtonItemAligmentLeft = 0,
    HXUIBarButtonItemAligmentMiddle,
    HXUIBarButtonItemAligmentRight,
};


@interface UIBarButtonItem (HXCustomView)

/**
 *  设置导航控制器左右按钮
 *
 *  @param icon        正常显示的图片名
 *  @param highlighted 高亮显示的图片名
 *  @param aligment    图片显示位置
 *  @param target      目标对象
 *  @param action      点击事件
 *
 *  @return UIBarButtonItem对象
 */
- (id)initWithIcon:(NSString *)icon
   highlightedIcon:(NSString *)highlighted
      itemAligment:(HXUIBarButtonItemAligment)aligment
            target:(id)target
            action:(SEL)action;

/**
 *  设置导航控制器左右按钮
 *
 *  @param title  显示的文字
 *  @param color  字体颜色
 *  @param font   字体大小
 *  @param target 目标对象
 *  @param action 点击事件
 *
 *  @return UIBarButtonItem对象
 */
- (id)initWithTitle:(NSString *)title
          textColor:(UIColor *)color
           textFont:(UIFont *)font
             target:(id)target
             action:(SEL)action;

@end
