//
//  UIImage+HXAddition.h
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/4/26.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HXAddition)
+ (UIImage *)hx_imageWithColor:(UIColor *)color opaque:(BOOL)opaque size:(CGSize)size;
+ (UIImage *)hx_imageWithColor:(UIColor *)color opaque:(BOOL)opaque size:(CGSize)size shape:(UIBezierPath *)shape;
+ (UIImage *)hx_roundedImageWithColor:(UIColor *)color opaque:(BOOL)opaque size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;
- (UIImage *)hx_resizableImage;
- (UIImage *)hx_fixOrientation;

//毛玻璃效果
- (UIImage*) hx_boxblurImageWithBlur:(CGFloat)blur exclusionPath:(UIBezierPath *)exclusionPath;
+ (UIImage *)hx_boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

//设置圆角
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;

/**
 *  重新绘制图片(改变图片颜色)
 *
 *  @param color 填充色
 *
 *  @return UIImage
 */
- (UIImage *)hx_imageWithColor:(UIColor *)color;

@end
