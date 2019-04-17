//
//  HXCategories.h
//  HXCategories
//
//  Created by 侯荡荡 on 2019/4/17.
//

#ifndef HXCategories_h
#define HXCategories_h

#import "NSArray+HXSafe.h"
#import "NSObject+HXLocalNotification.h"
#import "NSString+HXAddition.h"
#import "NSString+HXSize.h"
#import "NSString+HXValidate.h"
#import "UIBarButtonItem+HXCustomView.h"
#import "UIButton+HXAction.h"
#import "UIButton+HXPosition.h"
#import "UIColor+HXConvert.h"
#import "UIColor+HXGradient.h"
#import "UIFont+HXSize.h"
#import "UIImage+HXAddition.h"
#import "UILabel+HXAlign.h"
#import "UITableViewCell+HXResizeIndicator.h"
#import "UITextView+HXCategory.h"
#import "UIView+HXCoordinate.h"
#import "UIView+HXScreenshot.h"
#import "UIView+HXShake.h"
#import "UIView+HXToast.h"
#import "UINavigationController+HXSwipeBack.h"
#import "UIViewController+HXSetup.h"


///获取`Version`对外显示版本号
#define HX_SHORT_VERSION                              [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
///获取`Build`构建版本号
#define HX_BUILD_VERSION                              [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
///获取`Device`版本号信息
#define HX_SYSTEM_VERSION                             [[UIDevice currentDevice] systemVersion]
///获取当前时间戳
#define HX_CURRENT_TIMESTAMP                          [NSString stringWithFormat:@"%ld", (long)([[NSDate date] timeIntervalSince1970] * 1000)]

///版本判断
#define HX_SYSTEM_VERSION_EQUAL_TO(v)                 ([HX_SYSTEM_VERSION compare:v options:NSNumericSearch] == NSOrderedSame)
#define HX_SYSTEM_VERSION_GREATER_THAN(v)             ([HX_SYSTEM_VERSION compare:v options:NSNumericSearch] == NSOrderedDescending)
#define HX_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([HX_SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedAscending)
#define HX_SYSTEM_VERSION_LESS_THAN(v)                ([HX_SYSTEM_VERSION compare:v options:NSNumericSearch] == NSOrderedAscending)
#define HX_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)    ([HX_SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedDescending)

///主屏幕
#define HX_MAIN_SCREEN                                [[UIScreen mainScreen] bounds]
///屏幕的分辨率 当结果为1时，显示的是普通屏幕，结果为2时，显示的是Retian屏幕
#define HX_SCREEN_SCALE                               [[UIScreen mainScreen] scale]
///主屏幕的高度
#define HX_SCREEN_HEIGHT                              [[UIScreen mainScreen] bounds].size.height
///主屏幕的宽度
#define HX_SCREEN_WIDTH                               [[UIScreen mainScreen] bounds].size.width
///状态栏高度
#define HX_STATUSBAR_HEIGHT                           ([UIView hx_statusBarHeight])
///导航条高度
#define HX_NAVIGATIONBAR_HEIGHT                       ([UIView hx_navigationBarHeight])
///状态栏和导航条高度
#define HX_STA_NAV_HEIGHT                             ([UIView hx_statusBarHeight] + [UIView hx_navigationBarHeight])
///标签栏高度
#define HX_TABBAR_HEIGHT                              ([UIView hx_tabbarHeight])
///iPhoneX底部可触长条高度
#define HX_TOUCHBAR_HEIGHT                            ([UIView hx_touchbarHeight])
///默认TabViewCell高度
#define HX_CELL_DEFAULT_HEIGHT                        (44.0f)
///英文状态下键盘的高度
#define HX_EN_KEYBOARD_HEIGHT                         (216.0f)
///中文状态下键盘的高度
#define HX_CN_KEYBOARD_HEIGHT                         (252.0f)
///keyWindow
#define HX_KEYWINDOW                                  [UIApplication sharedApplication].keyWindow

#endif /* HXCategories_h */
