//
//  UIBarButtonItem+HXCustomView.m
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/4/25.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import "UIBarButtonItem+HXCustomView.h"

@implementation UIBarButtonItem (HXCustomView)

- (id)initWithIcon:(NSString *)icon
   highlightedIcon:(NSString *)highlighted
      itemAligment:(HXUIBarButtonItemAligment)aligment
            target:(id)target
            action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:icon];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    
    //设置图片偏移
    switch (aligment) {
        case HXUIBarButtonItemAligmentLeft:
            [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            //[button setImageEdgeInsets:UIEdgeInsetsMake(0.f, -image.size.width - 10.f, 0.f, 0.f)];
            break;
        case HXUIBarButtonItemAligmentMiddle:
            break;
        case HXUIBarButtonItemAligmentRight:
            [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            //[button setImageEdgeInsets:UIEdgeInsetsMake(0.f, 0.f, 0.f, -image.size.width)];
            break;
    }
    button.bounds = (CGRect){CGPointZero, CGSizeMake(44.f, 44.f)};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:button];
}

- (id)initWithTitle:(NSString *)title
          textColor:(UIColor *)color
           textFont:(UIFont *)font
             target:(id)target
             action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    // 计算文字宽度（适应于iOS7.0+）
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = 0;
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize fontSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 44)
                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       attributes:attributes
                                          context:nil].size;
    // 根据文字宽度设置button的frame
    button.bounds = (CGRect){CGPointZero, fontSize};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [self initWithCustomView:button];
}

@end
