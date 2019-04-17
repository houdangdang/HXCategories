//
//  NSString+HXValidate.h
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/4/26.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HXValidate)

/**
 *  判断是不是正确的手机格式
 *
 *  @return 判断值
 */
- (BOOL)hx_isValidMobileNumber;

/**
 *  判断是不是正确的验证码格式
 *
 *  @return 判断值
 */
- (BOOL)hx_isValidVerifyCode;

/**
 *  判断是不是正确的银行卡号
 *
 *  @return 判断值
 */
- (BOOL)hx_isValidBankCardNumber;

/**
 *  判断是不是正确的身份证格式
 *
 *  @return 判断值
 */
- (BOOL)hx_isValidIdentityCard;

/**
 *  判断是不是中文格式
 *
 *  @return 判断值
 */
- (BOOL)hx_isValidChinese;

/**
 *  判断是不是正确的邮政编码
 *
 *  @return 判断值
 */
- (BOOL)hx_isValidZip;

/**
 *  判断是不是含有空格
 *
 *  @return 判断值
 */
- (BOOL)hx_isExistedSpace;

/**
 *  判断是不是含有中文
 *
 *  @return 判断值
 */
- (BOOL)hx_isExistedChinese;

/**
 *  判断是不是同时含有数字和字母
 *
 *  @return 判断值
 */
- (BOOL)hx_isExistedNumberAndLetter;

/**
 *  判断字符串是否含有Emoji表情
 *
 *  @param string 要判断的字符串
 *
 *  @return 判断值
 */
+ (BOOL)hx_isExistedEmoji:(NSString *)string;

/**
 *  判断字符串是否为空(空格、nil、null都会返回YES)
 *
 *  @param string 要判断的值
 *
 *  @return 判断值
 */
+ (BOOL)hx_isBlank:(NSString *)string;

/**
 *  判断密码是否合法(6~36位)
 *
 *  @param string 要判断的值
 *
 *  @return 判断值
 */
+ (BOOL)hx_isValidPwd:(NSString *)string;


@end
