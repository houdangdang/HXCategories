//
//  NSString+HXAddition.h
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/4/27.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HXAddition)

/**
 *  防止String类型进行stringValue的转型
 *
 *  @return string对象本身
 */
- (NSString *)stringValue;

/**
 *  移除字符串中的Emoji表情
 *
 *  @return 移除Emoji表情后的字符串
 */
- (NSString *)hx_removeEmoji;

/**
 *  生成随机串(32位随机数 + 当前时间戳)
 *
 *  @return 随机串
 */
+ (NSString *)hx_randomString;

/**
 *  货币格式
 *
 *  @return 货币格式的值(例:1234 -> 1,234.00)
 */
- (NSString *)hx_stringFormatterWithCurrency;

/**
 *  小数点后2位
 *
 *  @return 货币格式的值(例:1234.809 -> 1234.80)
 */
- (NSString *)hx_stringPointAfterTwoNumWithCurrency;

/**
 *  银行卡格式
 *
 *  @return 银行卡格式的值(例:6222678998765437987 -> 6222 **** **** **** 987)
 */
- (NSString *)hx_stringFormatterBandCardNum;

@end
