//
//  UIView+HXScreenshot.m
//  HXInclusiveFinance
//
//  Created by Mike on 2018/5/17.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import "UIView+HXScreenshot.h"

@implementation UIView (HXScreenshot)

- (UIImage *)hx_screenshot {
    
    //UIGraphicsBeginImageContextWithOptions截图不清晰，
    //建议使用UIGraphicsBeginImageContextWithOptions
    //    UIGraphicsBeginImageContext(self.bounds.size);//截图不清晰
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);//截图清晰
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //NSData *imageData = UIImagePNGRepresentation(image);//生成PNG格式，无法设置图片质量
    //生成JPG格式，参数二（范围：0.0 ~ 1.0）图片质量递增
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    image = [UIImage imageWithData:imageData];
    
    return image;
    
}


- (UIImage *)hx_screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0f, -contentOffset.y);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(image, 0.55);
    image = [UIImage imageWithData:imageData];
    
    return image;
}

- (UIImage *)hx_screenshotInFrame:(CGRect)frame {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), frame.origin.x, frame.origin.y);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    
    return image;
}

@end
