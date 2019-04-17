#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HXCategories.h"
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

FOUNDATION_EXPORT double HXCategoriesVersionNumber;
FOUNDATION_EXPORT const unsigned char HXCategoriesVersionString[];

