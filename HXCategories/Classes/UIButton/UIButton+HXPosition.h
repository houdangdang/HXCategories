//
//  UIButton+HXPosition.h
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/5/9.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HXButtonEdgeInsetsStyle) {
    HXButtonEdgeInsetsStyleTop, // image在上，label在下
    HXButtonEdgeInsetsStyleLeft, // image在左，label在右
    HXButtonEdgeInsetsStyleBottom, // image在下，label在上
    HXButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (HXPosition)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(HXButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
