//
//  UIView+HXCoordinate.h
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/4/26.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HXCoordinate)

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;

/**
 *  导航条高度
 */
+ (CGFloat)hx_navigationBarHeight;

/**
 *  状态栏高度
 */
+ (CGFloat)hx_statusBarHeight;

/**
 *  tabbar高度
 */
+ (CGFloat)hx_tabbarHeight;

/**
 *  iPhoneX底部可触长条高度
 */
+ (CGFloat)hx_touchbarHeight;

+ (BOOL)hx_isiPhoneX;

@end
