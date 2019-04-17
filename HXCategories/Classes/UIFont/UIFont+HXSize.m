//
//  UIFont+HXSize.m
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/5/18.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import "UIFont+HXSize.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation UIFont (HXSize)

+ (void)load {
    
    Method newSystemFontMethod = class_getClassMethod([self class], @selector(hx_systemFontOfSize:));
    Method systemFontMethod = class_getClassMethod([self class], @selector(systemFontOfSize:));
    method_exchangeImplementations(newSystemFontMethod, systemFontMethod);
    
    Method newBoldSystemFontMethod = class_getClassMethod([self class], @selector(hx_boldSystemFontOfSize:));
    Method boldSystemFontMethod = class_getClassMethod([self class], @selector(boldSystemFontOfSize:));
    method_exchangeImplementations(newBoldSystemFontMethod, boldSystemFontMethod);
    
    Method newFontWithNameMethod = class_getClassMethod([self class], @selector(hx_fontWithName:size:));
    Method fontWithNameMethod = class_getClassMethod([self class], @selector(fontWithName:size:));
    method_exchangeImplementations(newFontWithNameMethod, fontWithNameMethod);
    
}

+ (UIFont *)hx_systemFontOfSize:(CGFloat)fontSize {
    
    NSString *screenHeight = [NSString stringWithFormat:@"%@",@([[UIScreen mainScreen] bounds].size.height)];
    
    UIFont *newFont = nil;
    if ([screenHeight compare:@"568" options:NSNumericSearch] != NSOrderedDescending) {
        /// 屏幕高度小于等于568
        newFont = [UIFont hx_systemFontOfSize:fontSize - 1];
    } else if ([screenHeight compare:@"667" options:NSNumericSearch] == NSOrderedDescending) {
        /// 屏幕高度大于667
        newFont = [UIFont hx_systemFontOfSize:fontSize + 1];
    } else {
        newFont = [UIFont hx_systemFontOfSize:fontSize];
    }
    return newFont;
}

+ (UIFont *)hx_boldSystemFontOfSize:(CGFloat)fontSize {
    
    NSString *screenHeight = [NSString stringWithFormat:@"%@",@([[UIScreen mainScreen] bounds].size.height)];
    
    UIFont *newFont = nil;
    if ([screenHeight compare:@"568" options:NSNumericSearch] != NSOrderedDescending) {
        /// 屏幕高度小于等于568
        newFont = [UIFont hx_boldSystemFontOfSize:fontSize - 1];
    } else if ([screenHeight compare:@"667" options:NSNumericSearch] == NSOrderedDescending) {
        /// 屏幕高度大于667
        newFont = [UIFont hx_boldSystemFontOfSize:fontSize + 1];
    } else {
        newFont = [UIFont hx_boldSystemFontOfSize:fontSize];
    }
    return newFont;
}

+ (UIFont *)hx_fontWithName:(NSString *)fontName size:(CGFloat)fontSize {
    
    NSString *screenHeight = [NSString stringWithFormat:@"%@",@([[UIScreen mainScreen] bounds].size.height)];
    
    UIFont *newFont = nil;
    if ([screenHeight compare:@"568" options:NSNumericSearch] != NSOrderedDescending) {
        /// 屏幕高度小于等于568
        newFont = [UIFont hx_fontWithName:fontName size:fontSize - 1];
    } else if ([screenHeight compare:@"667" options:NSNumericSearch] == NSOrderedDescending) {
        /// 屏幕高度大于667
        newFont = [UIFont hx_fontWithName:fontName size:fontSize + 1];
    } else {
        newFont = [UIFont hx_fontWithName:fontName size:fontSize];
    }
    return newFont;
}


@end
