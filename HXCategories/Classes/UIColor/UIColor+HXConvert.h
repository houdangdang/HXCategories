//
//  UIColor+HXConvert.h
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/4/26.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HXConvert)
/**
 *  RGB转HSB
 *
 *  @param color RGB值（UIColor对象）
 *  @param delta 亮度的值
 *
 *  @return UIColor对象
 */
+ (UIColor *)hx_colorRGBConvertToHSB:(UIColor *)color withBrighnessDelta:(CGFloat)delta;
/**
 *  RGB转HSB
 *
 *  @param color RGB值（UIColor对象）
 *  @param delta 透明度的值
 *
 *  @return UIColor对象
 */
+ (UIColor *)hx_colorRGBConvertToHSB:(UIColor *)color withAlphaDelta:(CGFloat)delta;
/**
 *  获取Hex值的UIColor对象
 *
 *  @param hex 颜色Hex值（例：0x123456 -> 0x代表#）
 *
 *  @return UIColor对象
 */
+ (UIColor *)hx_colorWithHex:(NSInteger)hex;
/**
 *  获取Hex值的UIColor对象
 *
 *  @param hex   hex 颜色Hex值（例：0x123456 -> 0x代表#）
 *  @param alpha 透明度的值
 *
 *  @return UIColor对象
 */
+ (UIColor *)hx_colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;
/**
 *  获取RGB值的UIColor对象
 *
 *  @param r red值
 *  @param g green值
 *  @param b blue值
 *
 *  @return UIColor对象
 */
+ (UIColor *)hx_colorWithRGB:(NSUInteger)r green:(NSInteger)g blue:(NSUInteger)b;
/**
 *  获取RGB值的UIColor对象
 *
 *  @param r red值
 *  @param g green值
 *  @param b blue值
 *  @param a 透明度的值
 *
 *  @return UIColor对象
 */
+ (UIColor *)hx_colorWithRGB:(NSUInteger)r green:(NSInteger)g blue:(NSUInteger)b alpha:(CGFloat)a;
@end
