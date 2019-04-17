//
//  UIButton+HXAction.m
//  HXInclusiveFinance
//
//  Created by Mike on 2018/5/8.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import "UIButton+HXAction.h"

@implementation UIButton (HXAction)

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [super sendAction:action to:target forEvent:event];
}

@end
