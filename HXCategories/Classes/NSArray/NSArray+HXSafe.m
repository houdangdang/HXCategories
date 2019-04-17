//
//  NSArray+HXSafe.m
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/5/16.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import "NSArray+HXSafe.h"

@implementation NSArray (HXSafe)

- (id)hx_objectAtIndex:(NSUInteger)index {
    
    if (self.count == 0) {
        return nil;
    }
    
    if (index > MAX(self.count - 1, 0)) {
        return nil;
    }
    
    return [self objectAtIndex:index];
}

@end
