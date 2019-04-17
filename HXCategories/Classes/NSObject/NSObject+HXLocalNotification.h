//
//  NSObject+HXLocalNotification.h
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/6/7.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HXLocalNotification)
/**
 *   注册通知 为NSObject 扩展本地通知的分类
 *
 *   @param   time          距离当前时间为多少秒发送通知
 *   @param   content       推送通知的内容
 *   @param   key           注册通知的key值
 */
- (void)hx_registerLocalNotification:(NSInteger)time content:(NSString *)content key:(NSString *)key;

/**
 *   取消通知
 *
 *  @param   key   根据key值取消对应通知
 */
- (void)hx_cancelLocalNotificationWithKey:(NSString *)key;
@end
