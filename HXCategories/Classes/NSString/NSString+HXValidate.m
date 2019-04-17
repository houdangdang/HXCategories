//
//  NSString+HXValidate.m
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/4/26.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import "NSString+HXValidate.h"

/// 验证码长度
#define HX_VERIFY_CODE_LENGTH  6

@implementation NSString (HXValidate)

- (BOOL)hx_isValidateByRegex:(NSString *)regex{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)hx_isValidMobileNumber {
    NSString * const MOBILE = @"^1(3|4|5|6|7|8|9)\\d{9}$";
    return [self hx_isValidateByRegex:MOBILE];
}

- (BOOL)hx_isValidVerifyCode {
    NSString * const VERIFYCODE = [NSString stringWithFormat:@"^d{%d}$", HX_VERIFY_CODE_LENGTH];
    return [self hx_isValidateByRegex:VERIFYCODE];
}

- (BOOL)hx_isValidBankCardNumber {
    NSString * const BANKCARD = @"^(\\d{15}|\\d{16}|\\d{17}|\\d{18}|\\d{19}|\\d{20})$";
    return [self hx_isValidateByRegex:BANKCARD];
}

- (BOOL)hx_isValidIdentityCard {
    
    NSString *identityCard = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([identityCard length] != 18) return NO;
    
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@",year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@",leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))",yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd, @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",regex];
    if (![regexTest evaluateWithObject:identityCard]) return NO;
    
    int summary = ([identityCard substringWithRange:NSMakeRange(0,1)].intValue +
                   [identityCard substringWithRange:NSMakeRange(10,1)].intValue) * 7 +
                  ([identityCard substringWithRange:NSMakeRange(1,1)].intValue +
                   [identityCard substringWithRange:NSMakeRange(11,1)].intValue) * 9 +
                  ([identityCard substringWithRange:NSMakeRange(2,1)].intValue +
                   [identityCard substringWithRange:NSMakeRange(12,1)].intValue) * 10 +
                  ([identityCard substringWithRange:NSMakeRange(3,1)].intValue +
                   [identityCard substringWithRange:NSMakeRange(13,1)].intValue) * 5 +
                  ([identityCard substringWithRange:NSMakeRange(4,1)].intValue +
                   [identityCard substringWithRange:NSMakeRange(14,1)].intValue) * 8 +
                  ([identityCard substringWithRange:NSMakeRange(5,1)].intValue +
                   [identityCard substringWithRange:NSMakeRange(15,1)].intValue) * 4 +
                  ([identityCard substringWithRange:NSMakeRange(6,1)].intValue +
                   [identityCard substringWithRange:NSMakeRange(16,1)].intValue) * 2 +
                   [identityCard substringWithRange:NSMakeRange(7,1)].intValue * 1 +
                   [identityCard substringWithRange:NSMakeRange(8,1)].intValue * 6 +
                   [identityCard substringWithRange:NSMakeRange(9,1)].intValue * 3;
    
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    //判断校验位
    checkBit = [checkString substringWithRange:NSMakeRange(remainder, 1)];
    return [checkBit isEqualToString:[[identityCard substringWithRange:NSMakeRange(17, 1)] uppercaseString]];
}

- (BOOL)hx_isValidChinese {
    NSString * const CHINESE = @"^[\u4e00-\u9fa5]*$";
    return [self hx_isValidateByRegex:CHINESE];
}

- (BOOL)hx_isValidZip {
     NSString * const ZIP = @"[1-9]\\d{5}(?!\\d)";
    return [self hx_isValidateByRegex:ZIP];
}

- (BOOL)hx_isExistedSpace {
    return ([self rangeOfString:@" "].length > 0);
}

- (BOOL)hx_isExistedChinese {
    for (NSInteger i = 0; i< [self length]; i++) {
        NSInteger a = [self characterAtIndex:i];
        if ( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)hx_isExistedNumberAndLetter {
    
    BOOL result = NO;
    
    //数字条件
    NSRegularExpression *numRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]"
                                                                                          options:NSRegularExpressionCaseInsensitive
                                                                                            error:nil];
    //符合数字条件的有几个字节
    NSUInteger numMatchCount = [numRegularExpression numberOfMatchesInString:self
                                                                     options:NSMatchingReportProgress
                                                                       range:NSMakeRange(0, self.length)];
    //英文字条件
    NSRegularExpression *letterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]"
                                                                                             options:NSRegularExpressionCaseInsensitive
                                                                                               error:nil];
    //符合英文字条件的有几个字节
    NSUInteger letterMatchCount = [letterRegularExpression numberOfMatchesInString:self
                                                                           options:NSMatchingReportProgress
                                                                             range:NSMakeRange(0, self.length)];
    
    if (numMatchCount == self.length) {
        //全部符合数字，表示沒有英文
    } else if (letterMatchCount == self.length) {
        //全部符合英文，表示沒有数字
    } else if (numMatchCount + letterMatchCount == self.length) {
        //符合英文和符合数字条件的相加等于密码长度
    } else {
        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
    }
    
    if (numMatchCount > 0 && letterMatchCount > 0) {
        result = YES;
    } else {
        result = NO;
    }
    return result;
}

+ (BOOL)hx_isExistedEmoji:(NSString *)string {
    
    if ([self hx_isBlank:string]) {
        return NO;
    }
    NSString *pattern = @"[^\\u0000-\\uFFFF]";
    NSError *error = nil;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern
                                                                      options:NSRegularExpressionCaseInsensitive
                                                                        error:&error];
    NSArray *result = [regex matchesInString:string
                                     options:NSMatchingReportProgress
                                       range:NSMakeRange(0, string.length)];
    
    return result.count > 0;
}

+ (BOOL)hx_isBlank:(NSString *)string {
    
    BOOL result = NO;
    if (string == nil || string == NULL) {
        result = YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        result = YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        result = YES;
    }
    return result;
}

+ (BOOL)hx_isValidPwd:(NSString *)string {
    NSString *passowrdRegex = @"^[0-9a-zA-Z]{6,36}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passowrdRegex];
    return [passwordTest evaluateWithObject:string];
}

@end
