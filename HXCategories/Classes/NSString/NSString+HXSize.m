//
//  NSString+HXSize.m
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/4/26.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import "NSString+HXSize.h"

@implementation NSString (HXSize)

- (CGSize)hx_sizeWithConstrainedSize:(CGSize)size font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing {
    
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize expectedSize = CGSizeZero;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode            = NSLineBreakByWordWrapping;
        paragraphStyle.lineSpacing              = lineSpacing;
        NSDictionary *attributes                = @{NSFontAttributeName:textFont,
                                                    NSParagraphStyleAttributeName:paragraphStyle.copy};
        expectedSize                            = [self boundingRectWithSize:size
                                                                     options:NSStringDrawingUsesLineFragmentOrigin |
                                                   NSStringDrawingUsesFontLeading
                                                                  attributes:attributes
                                                                     context:nil].size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        expectedSize = [self sizeWithFont:font
                        constrainedToSize:size
                            lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
    }
    return CGSizeMake(ceil(expectedSize.width), ceil(expectedSize.height));
}

- (CGFloat)hx_heightWithFont:(UIFont *)font constrainedMaxWidth:(CGFloat)width lineSpacing:(CGFloat)lineSpacing {
    return [self hx_sizeWithConstrainedSize:CGSizeMake(width, CGFLOAT_MAX) font:font lineSpacing:lineSpacing].height;
}

- (CGFloat)hx_widthWithFont:(UIFont *)font constrainedMaxHeight:(CGFloat)height lineSpacing:(CGFloat)lineSpacing {
    return [self hx_sizeWithConstrainedSize:CGSizeMake(CGFLOAT_MAX, height) font:font lineSpacing:lineSpacing].width;
}

- (CGSize)hx_sizeWithFont:(UIFont *)font constrainedMaxWidth:(CGFloat)width lineSpacing:(CGFloat)lineSpacing {
    return [self hx_sizeWithConstrainedSize:CGSizeMake(width, CGFLOAT_MAX) font:font lineSpacing:lineSpacing];
}

- (CGSize)hx_sizeWithFont:(UIFont *)font constrainedMaxHeight:(CGFloat)height lineSpacing:(CGFloat)lineSpacing {
    return [self hx_sizeWithConstrainedSize:CGSizeMake(CGFLOAT_MAX, height) font:font lineSpacing:lineSpacing];
}

- (CGSize)hx_sizeWithFont:(UIFont *)font constrainedSize:(CGSize)size lineSpacing:(CGFloat)lineSpacing {
    return [self hx_sizeWithConstrainedSize:size font:font lineSpacing:lineSpacing];
}

@end
