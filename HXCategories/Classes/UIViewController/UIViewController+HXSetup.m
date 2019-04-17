//
//  UIViewController+HXSetup.m
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/4/26.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import "UIViewController+HXSetup.h"
#import "HXCategories.h"

@implementation UIViewController (HXSetup)

- (void)hx_setNavigationBarBackgroundImage:(UIImage *)image {
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.layer.shadowOpacity = 0.0;
}

- (void)hx_setNavigationBarBackgroundImageName:(NSString *)imageName {
    
    //默认是半透明的
    self.navigationController.navigationBar.translucent = NO;
    UIImage *backgroundImage = nil;
    if (imageName) {
        backgroundImage = [UIImage imageNamed:imageName];
    } else {
        backgroundImage = [UIImage hx_imageWithColor:[UIColor whiteColor]
                                              opaque:YES
                                                size:CGSizeMake(HX_SCREEN_WIDTH, HX_STA_NAV_HEIGHT)];
    }
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage
                                                  forBarMetrics:UIBarMetricsDefault];
}

- (void)hx_setNavigationBarBackgroundColor:(UIColor *)color showShadow:(BOOL)show {
    
    if (!color) color = [UIColor whiteColor];
    UIImage *backgroundImage = [UIImage hx_imageWithColor:color
                                                   opaque:YES
                                                     size:CGSizeMake(HX_SCREEN_WIDTH, HX_STA_NAV_HEIGHT)];
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage
                                                  forBarMetrics:UIBarMetricsDefault];
    
    //1.设置阴影颜色
    self.navigationController.navigationBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    //2.设置阴影偏移范围
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 3);
    //3.设置阴影颜色的透明度
    self.navigationController.navigationBar.layer.shadowOpacity = show ? 0.2 : 0.0;
    //4.设置阴影半径
    self.navigationController.navigationBar.layer.shadowRadius = 3;
    //5.设置阴影路径
    self.navigationController.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationController.navigationBar.bounds].CGPath;
}

- (void)hx_setNavigationControllerTitle:(NSString *)title titleColor:(UIColor *)color {
    
    self.title                    = title;
    CGSize titleSize              = [title hx_sizeWithFont:[UIFont systemFontOfSize:18.f]
                                      constrainedMaxHeight:44
                                               lineSpacing:0];
    
    UILabel *label = (UILabel *)[self.view viewWithTag:8800];
    if (label) [label removeFromSuperview];
    
    UILabel *titleLabel           = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                              0,
                                                                              titleSize.width,
                                                                              titleSize.height)];
    titleLabel.font               = [UIFont boldSystemFontOfSize:18.0];
    titleLabel.textColor          = color ? color : [UIColor blackColor];
    titleLabel.text               = title;
    titleLabel.textAlignment      = NSTextAlignmentCenter;
    titleLabel.backgroundColor    = [UIColor clearColor];
    titleLabel.tag                = 8800;
    self.navigationItem.titleView = titleLabel;
    /*
    /// 暂时注释、保留此方法
    self.navigationItem.titleView.alpha = 0;
    [UIView animateWithDuration:0.15 animations:^{
        self.navigationItem.titleView.alpha = 1;
    }];
     */
}

- (void)hx_setLeftBarButtonWithTitle:(NSString *)title action:(SEL)action {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title
                                                         textColor:[UIColor blackColor]
                                                          textFont:[UIFont systemFontOfSize:15.f]
                                                            target:self
                                                            action:action];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)hx_setLeftBarButtonWithIcon:(NSString *)iconName action:(SEL)action {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithIcon:iconName
                                                  highlightedIcon:nil
                                                     itemAligment:HXUIBarButtonItemAligmentLeft
                                                           target:self
                                                           action:action];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)hx_setRightBarButtonWithTitle:(NSString *)title action:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title
                                                         textColor:[UIColor blackColor]
                                                          textFont:[UIFont systemFontOfSize:15.f]
                                                            target:self
                                                            action:action];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)hx_setRightBarButtonWithIcon:(NSString *)iconName action:(SEL)action {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithIcon:iconName
                                                  highlightedIcon:nil
                                                     itemAligment:HXUIBarButtonItemAligmentRight
                                                           target:self
                                                           action:action];
    self.navigationItem.rightBarButtonItem = item;
}



- (void)hx_setCancelAutomaticallyAdjusts {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        if (@available(iOS 11.0, *)) {
            self.automaticallyAdjustsScrollViewInsets = YES;
            return;
        }
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)hx_setViewBackgroundColor {
    self.view.backgroundColor = [UIColor colorWithRed:245.f/255.f green:245.f/255.f blue:245.f/255.f alpha:1.f];
}

- (void)hx_setBackItemWithTarget:(id)target
                        backIcon:(NSString *)backIcon
                      backAction:(SEL)backAction
                       closeIcon:(NSString *)closeIcon
                     closeAction:(SEL)closeAction {
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 88, 44)];
    
    UIButton *backbButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backImage = [UIImage imageNamed:backIcon];
    [backbButton setImage:backImage forState:UIControlStateNormal];
    [backbButton setImageEdgeInsets:UIEdgeInsetsMake(0, - backImage.size.width, 0, 0)];
    backbButton.frame = CGRectMake(0, 0, 44, 44);
    [backbButton addTarget:target action:backAction forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:backbButton];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeImage = [UIImage imageNamed:closeIcon];
    [closeButton setImage:closeImage forState:UIControlStateNormal];
    closeButton.frame = CGRectMake(44, 0, 44, 44);
    [closeButton addTarget:target action:closeAction forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:closeButton];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
}

- (void)hx_setBackItemWithTarget:(id)target
                       backTitle:(NSString *)backTitle
                      backAction:(SEL)backAction
                      closeTitle:(NSString *)closeTitle
                     closeAction:(SEL)closeAction {
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    UIButton *backbButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backbButton.frame = CGRectMake(0, 0, 100 - 44, 44);
    [backbButton setTitle:backTitle forState:UIControlStateNormal];
    backbButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    backbButton.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [backbButton addTarget:target action:backAction forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:backbButton];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(100 - 44, 0, 44, 44);
    [closeButton setTitle:closeTitle forState:UIControlStateNormal];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:15.f];;
    [closeButton addTarget:target action:closeAction forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:closeButton];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];;
}

- (void)hx_hiddenLeftItemButton {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithIcon:nil
                                                  highlightedIcon:nil
                                                     itemAligment:HXUIBarButtonItemAligmentLeft
                                                           target:self
                                                           action:nil];
    //修改导航栏左右按钮的坐标
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil
                                                                                    action:nil];
    //这个数值可以根据情况自由变化
    negativeSpacer.width = -10;
    
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, item];
}

- (void)hx_hiddenRightItemButton {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithIcon:nil
                                                  highlightedIcon:nil
                                                     itemAligment:HXUIBarButtonItemAligmentRight
                                                           target:self
                                                           action:nil];
    //修改导航栏左右按钮的坐标
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil
                                                                                    action:nil];
    //这个数值可以根据情况自由变化
    negativeSpacer.width = -10;
    
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, item];
}

- (UIImageView *)findNavigationBarlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findNavigationBarlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)hx_hiddenNavgationBarLine {
    [[self findNavigationBarlineImageViewUnder:self.navigationController.navigationBar] setHidden:YES];
}

- (void)hx_showNavigationBarLine {
    [[self findNavigationBarlineImageViewUnder:self.navigationController.navigationBar] setHidden:NO];
}


- (void)hx_setBackItemWithIcon:(NSString *)icon {
    
    icon = icon ?: @"icon_back_black";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithIcon:icon
                                                  highlightedIcon:nil
                                                     itemAligment:HXUIBarButtonItemAligmentLeft
                                                           target:self
                                                           action:@selector(hx_onBack)];
    
    self.navigationItem.leftBarButtonItem = item;
}

- (void)hx_onBack {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.view endEditing:YES];
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}


@end
