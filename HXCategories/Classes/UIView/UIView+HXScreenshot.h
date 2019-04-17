//
//  UIView+HXScreenshot.h
//  HXInclusiveFinance
//
//  Created by Mike on 2018/5/17.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HXScreenshot)

/**
 *  截图
 *
 *  @return 截图后的UIImage对象
 */
- (UIImage *)hx_screenshot;
/**
 *  截图
 *
 *  @param contentOffset 内容偏移
 *
 *  @return 截图后的UIImage对象
 */
- (UIImage *)hx_screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset;
/**
 *  截图
 *
 *  @param frame 在某个区域内
 *
 *  @return 截图后的UIImage对象
 */
- (UIImage *)hx_screenshotInFrame:(CGRect)frame;

@end
