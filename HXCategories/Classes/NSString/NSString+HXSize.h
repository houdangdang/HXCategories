//
//  NSString+HXSize.h
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/4/26.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HXSize)

/**
 *  固定宽度计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 *  @param lineSpacing 文字之间的间距
 *  @return 文字的高度
 */
- (CGFloat)hx_heightWithFont:(UIFont *)font constrainedMaxWidth:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;

/**
 *  固定高度计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 *  @param lineSpacing 文字之间的间距
 *  @return 计算文字的宽度
 */
- (CGFloat)hx_widthWithFont:(UIFont *)font constrainedMaxHeight:(CGFloat)height lineSpacing:(CGFloat)lineSpacing;

/**
 *  固定宽度计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 *  @param lineSpacing 文字之间的间距
 *  @return 固定宽度计算文字的大小
 */
- (CGSize)hx_sizeWithFont:(UIFont *)font constrainedMaxWidth:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;

/**
 *  固定高度计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 *  @param lineSpacing 文字之间的间距
 *  @return 固定高度计算文字的大小
 */
- (CGSize)hx_sizeWithFont:(UIFont *)font constrainedMaxHeight:(CGFloat)height lineSpacing:(CGFloat)lineSpacing;

/**
 *  给定宽高范围计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param size   给定宽高范围
 *  @param lineSpacing 文字之间的间距
 *  @return 给定宽高范围计算文字的大小
 */
- (CGSize)hx_sizeWithFont:(UIFont *)font constrainedSize:(CGSize)size lineSpacing:(CGFloat)lineSpacing;
@end
