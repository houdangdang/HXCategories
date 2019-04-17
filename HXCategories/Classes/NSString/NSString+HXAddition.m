//
//  NSString+HXAddition.m
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/4/27.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import "NSString+HXAddition.h"
#import "HXCategories.h"

@implementation NSString (HXAddition)

- (NSString *)stringValue {
    return self;
}

- (NSString *)hx_removeEmoji {
    
    if ([NSString hx_isBlank:self]) {
        return @"";
    }
    
    NSError *error = nil;
    NSString *pattern = @"[^\\u0000-\\uFFFF]";
    
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern
                                                                      options:NSRegularExpressionCaseInsensitive
                                                                        error:&error];
    NSArray *result = [regex matchesInString:self
                                     options:NSMatchingReportProgress
                                       range:NSMakeRange(0, self.length)];
    
    regex = result.count > 0 ? regex : nil;
    NSString *processedString = [regex stringByReplacingMatchesInString:self
                                                                options:NSMatchingReportProgress
                                                                  range:NSMakeRange(0, self.length)
                                                           withTemplate:@""];
    return processedString;
}

+ (NSString *)hx_randomString {
    
    NSString *string = [[NSString alloc]init];
    for (NSInteger i = 0; i < 32; i++) {
        NSInteger number = arc4random() % 36;
        if (number < 10) {
            NSInteger figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%li", (long)figure];
            string = [string stringByAppendingString:tempString];
        }else {
            NSInteger figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return [string stringByAppendingString:HX_CURRENT_TIMESTAMP];
}

- (NSString *)hx_stringFormatterWithCurrency {
    
    NSRange range = [self rangeOfString:@"."];
    NSMutableString *string ;
    
    if(range.location != NSNotFound) {
        //保存两位小数,不能直接用%.2f,因为默认会四舍五入.
            string = [NSMutableString stringWithString:[[NSString stringWithFormat:@"%@000",self] substringToIndex:range.location + 3]];
    } else {
        string = [NSMutableString stringWithString:[NSString stringWithFormat:@"%.2f",[self doubleValue]]];
    }
    
    NSRange range2 = [string rangeOfString:@"."];
    if (range2.location > 3) {
        for(NSInteger i = range2.location - 3; i > 0; i -= 3) {
            [string insertString:@","atIndex:i];
        }
    }
    if(range.location != NSNotFound && range.location == 0)
        [string insertString:@"0" atIndex:0];
    return string;
}

- (NSString *)hx_stringPointAfterTwoNumWithCurrency {
    
    NSRange range = [self rangeOfString:@"."];
    NSMutableString *string ;
    
    if(range.location != NSNotFound) {
        //保存两位小数,不能直接用%.2f,因为默认会四舍五入.
        string = [NSMutableString stringWithString:[[NSString stringWithFormat:@"%@000",self] substringToIndex:range.location + 3]];
        if(range.location == 0)
            [string insertString:@"0" atIndex:0];
        return [string stringValue];
    }
    return self;
}

- (NSString *)hx_stringFormatterBandCardNum{
    /*
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    long count = [self length] / 4 + ([self length] % 4 != 0 ? 1 : 0);
    
    for (NSUInteger i = 0; i < count; i++) {
        if(i < count - 1) {
            if(i == 0)
                [stringWithAddedSpaces appendString:[self substringWithRange:NSMakeRange(i * 4, 4)]];
            else
                [stringWithAddedSpaces appendString:@"****"];
            [stringWithAddedSpaces appendString:@" "];
        }
        else {
            [stringWithAddedSpaces appendString:[self substringWithRange:NSMakeRange(i * 4, [self length] - i * 4)]];
        }
    }
    
    return [stringWithAddedSpaces stringValue];
     */
    
    NSString *headerStr = [self substringToIndex:4];
    NSString *endStr = [self substringWithRange:NSMakeRange(self.length - 4, 4)];
    NSString *result = [NSString stringWithFormat:@"%@ **** **** **** %@",headerStr, endStr];
    return result;
    
}

@end
