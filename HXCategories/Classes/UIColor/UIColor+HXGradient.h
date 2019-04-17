//
//  UIColor+HXGradient.h
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/6/21.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HXGradient)
//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;
@end
