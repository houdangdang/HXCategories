//
//  UIView+HXToast.m
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/4/27.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import "UIView+HXToast.h"
#import "NSString+HXSize.h"
#import "UIView+HXCoordinate.h"

static const CGFloat HXMaxWidthScale            = 0.8;  //最大宽度比例
static const CGFloat HXMaxHeightScale           = 0.8;  //最大高度比例
static const CGFloat HXHorizontalPadding        = 10.0; //横排间距
static const CGFloat HXVerticalPadding          = 10.0; //竖排间距
static const CGFloat HXFitPadding               = 60.0; //居上或居下的间距
static const CGFloat HXCornerRadius             = 5.0;  //显示图圆角大小
static const CGFloat HXOpacity                  = 0.7;  //不透明度
static const CGFloat HXFontSize                 = 16.0; //显示文字大小
static const CGFloat HXMaxTitleLines            = 0;    //标题最大显示行数（0表示可换行）
static const CGFloat HXMaxMessageLines          = 0;    //信息最大显示行数（0表示可换行）
static const CGFloat HXFadeDuration             = 0.2;  //消失时间
static const CGFloat HXDisplayDuration          = 3.0;  //默认显示时长
static const CGFloat HXShadowOpacity            = 0.0;//0.8;  //阴影不透明度
static const CGFloat HXShadowRadius             = 2.0;  //阴影半径
static const CGFloat HXImageViewWidth           = 80.0; //设置图片的最大宽度
static const CGFloat HXImageViewHeight          = 80.0; //设置图片的最大高度
static const CGSize  HXShadowOffset             = { 2.0, 2.0 };  //阴影偏移量
static const BOOL    HXDisplayShadow            = YES;  //是否显示阴影（default：YES）
static const NSString * HXDefaultPosition       = @"bottom"; //默认显示在底部
static BOOL  dispalyErrorAnimationed            = NO; //动画是否在执行

#define TAG_OF_MESSAGE_VIEW             99990
#define TAG_OF_ERROR_VIEW               99991
#define TAG_OF_ERROR_LABEL              99992

@implementation UIView (HXToast)

- (void)hx_displayMessage:(NSString *)message {
    [self hx_displayMessage:message duration:HXDisplayDuration position:HXDefaultPosition];
}

- (void)hx_displayMessage:(NSString *)message duration:(CGFloat)interval position:(id)position {
    [[self viewWithTag:TAG_OF_MESSAGE_VIEW] removeFromSuperview];
    UIView *view = [self hx_viewForMessage:message title:nil image:nil];
    [self hx_displayView:view duration:interval position:position];
}

- (void)hx_displayView:(UIView *)view duration:(CGFloat)interval position:(id)point {
    
    view.center = [self hx_centerPointForPosition:point withSuperView:view];
    view.alpha = 0.0;
    [self addSubview:view];
    
    [UIView animateWithDuration:HXFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         view.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:HXFadeDuration
                                               delay:interval
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              view.alpha = 0.0;
                                          } completion:^(BOOL finished) {
                                              [view removeFromSuperview];
                                          }];
                     }];
}

- (CGPoint)hx_centerPointForPosition:(id)point withSuperView:(UIView *)superView {
    
    if([point isKindOfClass:[NSString class]]) {
        
        if([point caseInsensitiveCompare:@"top"] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width/2, (superView.frame.size.height / 2) + HXFitPadding);
        } else if([point caseInsensitiveCompare:@"bottom"] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width/2, (self.bounds.size.height - (superView.frame.size.height / 2)) - HXFitPadding);
        } else if([point caseInsensitiveCompare:@"center"] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        }
    } else if ([point isKindOfClass:[NSValue class]]) {
        return [point CGPointValue];
    }
    
    return [self hx_centerPointForPosition:HXDefaultPosition withSuperView:superView];
}

- (UIView *)hx_viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image {
    
    if((message == nil) && (title == nil) && (image == nil)) return nil;
    
    UILabel *messageLabel = nil;
    UILabel *titleLabel = nil;
    UIImageView *imageView = nil;
    
    
    UIView *wrapperView = [self viewWithTag:TAG_OF_MESSAGE_VIEW];
    if (wrapperView == nil) {
        wrapperView = [[UIView alloc] init];
        wrapperView.tag = TAG_OF_MESSAGE_VIEW;
    }
    
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = HXCornerRadius;
    
    if (HXDisplayShadow) {
        wrapperView.layer.shadowColor = [UIColor blackColor].CGColor;
        wrapperView.layer.shadowOpacity = HXShadowOpacity;
        wrapperView.layer.shadowRadius = HXShadowRadius;
        wrapperView.layer.shadowOffset = HXShadowOffset;
    }
    
    wrapperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:HXOpacity];
    
    if(image != nil) {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(HXHorizontalPadding, HXVerticalPadding, HXImageViewWidth, HXImageViewHeight);
    }
    
    CGFloat imageWidth, imageHeight, imageLeft;
    
    if(imageView != nil) {
        imageWidth = imageView.bounds.size.width;
        imageHeight = imageView.bounds.size.height;
        imageLeft = HXHorizontalPadding;
    } else {
        imageWidth = imageHeight = imageLeft = 0.0;
    }
    
    if (title != nil) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = HXMaxTitleLines;
        titleLabel.font = [UIFont boldSystemFontOfSize:HXFontSize];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.alpha = 1.0;
        titleLabel.text = title;
        
        CGSize maxSizeTitle = CGSizeMake((self.bounds.size.width * HXMaxWidthScale) - imageWidth, self.bounds.size.height * HXMaxHeightScale);
        CGSize expectedSizeTitle = [title hx_sizeWithFont:titleLabel.font constrainedSize:maxSizeTitle lineSpacing:0];
        titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = HXMaxMessageLines;
        messageLabel.font = [UIFont systemFontOfSize:HXFontSize];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        CGSize maxSizeMessage = CGSizeMake((self.bounds.size.width * HXMaxWidthScale) - imageWidth, self.bounds.size.height * HXMaxHeightScale);
        CGSize expectedSizeMessage = [message hx_sizeWithFont:messageLabel.font constrainedSize:maxSizeMessage lineSpacing:0];
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    
    if(titleLabel != nil) {
        titleWidth = titleLabel.bounds.size.width;
        titleHeight = titleLabel.bounds.size.height;
        titleTop = HXVerticalPadding;
        titleLeft = imageLeft + imageWidth + HXHorizontalPadding;
    } else {
        titleWidth = titleHeight = titleTop = titleLeft = 0.0;
    }
    
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;
    
    if(messageLabel != nil) {
        messageWidth = messageLabel.bounds.size.width;
        messageHeight = messageLabel.bounds.size.height;
        messageLeft = imageLeft + imageWidth + HXHorizontalPadding;
        messageTop = titleTop + titleHeight + HXVerticalPadding;
    } else {
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
    }
    
    
    CGFloat longerWidth = MAX(titleWidth, messageWidth);
    CGFloat longerLeft = MAX(titleLeft, messageLeft);
    
    CGFloat wrapperWidth = MAX((imageWidth + (HXHorizontalPadding * 2)), (longerLeft + longerWidth + HXHorizontalPadding));
    CGFloat wrapperHeight = MAX((messageTop + messageHeight + HXVerticalPadding), (imageHeight + (HXVerticalPadding * 2)));
    
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    if(titleLabel != nil) {
        titleLabel.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight);
        [wrapperView addSubview:titleLabel];
    }
    
    if(messageLabel != nil) {
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        [wrapperView addSubview:messageLabel];
    }
    
    if(imageView != nil) {
        [wrapperView addSubview:imageView];
    }
    
    return wrapperView;
}

/*----------------------------------------------------------------------------------------*/
- (void)hx_displayError:(NSString *)error {
    [self hx_displayError:error duration:HXDisplayDuration];
}

- (void)hx_displayError:(NSString *)error duration:(CGFloat)interval {
    UIView *view = [self viewForError:error];
    [self hx_displayErrorView:view duration:interval];
}

- (void)hx_displayErrorView:(UIView *)errorView duration:(CGFloat)interval{
    
    if (dispalyErrorAnimationed) { return; }
    
    errorView.alpha = 0.0;
    [self addSubview:errorView];
    
    [UIView animateWithDuration:HXFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         dispalyErrorAnimationed = YES;
                         errorView.top = 0;
                         errorView.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:HXFadeDuration
                                               delay:interval
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              dispalyErrorAnimationed = YES;
                                              errorView.bottom = 0.f;
                                              errorView.alpha = 0.0;
                                          } completion:^(BOOL finished) {
                                              [errorView removeFromSuperview];
                                              dispalyErrorAnimationed = NO;
                                          }];
                     }];
}

- (UIView *)viewForError:(NSString *)error {
    
    if(error == nil || dispalyErrorAnimationed) return nil;
    
    UILabel *errorLabel = nil;
    
    UIView *wrapperView = [self viewWithTag:TAG_OF_ERROR_VIEW];
    if (wrapperView == nil) {
        wrapperView = [[UIView alloc] init];
        wrapperView.tag = TAG_OF_ERROR_VIEW;
    }
    wrapperView.backgroundColor = [UIColor colorWithRed:255.f/255.f green:244.f/255.f blue:219.f/255.f alpha:0.f];
    
    CGSize errorSize = CGSizeZero;
    
    if (error != nil) {
        errorLabel = [[UILabel alloc] init];
        errorLabel.numberOfLines = HXMaxMessageLines;
        errorLabel.font = [UIFont systemFontOfSize:14.f];
        errorLabel.lineBreakMode = NSLineBreakByWordWrapping;
        errorLabel.textColor = [UIColor colorWithRed:255.f/255.f green:46.f/255.f blue:46.f/255.f alpha:0.f];
        errorLabel.backgroundColor = [UIColor clearColor];
        errorLabel.alpha = 1.0;
        errorLabel.text = error;
        
        CGSize maxSizeError = CGSizeMake(self.bounds.size.width - 30, MAXFLOAT);
        errorSize = [error hx_sizeWithFont:errorLabel.font constrainedSize:maxSizeError lineSpacing:0];
        errorLabel.frame = CGRectMake(0.0, 0.0, errorSize.width, errorSize.height);
    }
    
    CGFloat wrapperWidth = self.bounds.size.width;
    CGFloat wrapperHeight = MAX((MAX(errorSize.height, 20) + 10), 44);
    
    wrapperView.frame = CGRectMake(0.0, -64.f, wrapperWidth, wrapperHeight);
    
    CGFloat errorWidth, errorHeight, errorLeft, errorTop;
    
    if(errorLabel != nil) {
        errorWidth = errorLabel.bounds.size.width;
        errorHeight = errorLabel.bounds.size.height;
        errorLeft = 15.f;
        errorTop = (wrapperHeight - errorHeight) / 2;
    } else {
        errorWidth = errorHeight = errorLeft = errorTop = 0.0;
    }
    
    if(errorLabel != nil) {
        errorLabel.frame = CGRectMake(errorLeft, errorTop, errorWidth, errorHeight);
        [wrapperView addSubview:errorLabel];
    }
    
    return wrapperView;
}


@end
