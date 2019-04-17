//
//  UITableViewCell+HXResizeIndicator.m
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/7/20.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import "UITableViewCell+HXResizeIndicator.h"

@implementation UITableViewCell (HXResizeIndicator)

- (void)updateDisclosureIndicatorSize {
    UIButton *arrowButton = [self arrowButton];
    UIImage *image =  [UIImage imageNamed:@"icon_arrow_normal"];
    [arrowButton setBackgroundImage:image forState:UIControlStateNormal];
}

- (UIButton *)arrowButton {
    for (UIView *view in self.subviews)
        if ([view isKindOfClass:[UIButton class]])
            return (UIButton *)view;
    return nil;
}

@end
