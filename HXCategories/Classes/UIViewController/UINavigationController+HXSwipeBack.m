//
//  UINavigationController+HXSwipeBack.m
//  HXInclusiveFinance
//
//  Created by 侯荡荡 on 2018/4/24.
//  Copyright © 2018年 Huaxiaxincai. All rights reserved.
//

#import "UINavigationController+HXSwipeBack.h"
#import <objc/runtime.h>

#define APP_WINDOW              [UIApplication sharedApplication].delegate.window
#define APP_SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define APP_SCREEN_BOUNDS       [UIScreen mainScreen].bounds

/** 滑动偏移量临界值 `<120` 会取消返回 `>=120` 会pop */
#define MAX_PAN_DISTANCE        120
/** 在某范围内允许滑动手势，默认全屏 */
#define PAN_ENABLE_DISTANCE     APP_SCREEN_WIDTH


/*********************************** HXScreenShotView ***********************************/

@interface HXScreenShotView : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *maskView;
@end

@implementation HXScreenShotView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:APP_SCREEN_BOUNDS];
        [self addSubview:_imageView];
        
        _maskView = [[UIView alloc] initWithFrame:APP_SCREEN_BOUNDS];
        _maskView.backgroundColor = [UIColor clearColor];
        [self addSubview:_maskView];
    }
    return self;
}

@end

/*********************************** UIViewController (HXSwipeBack) ***********************************/

@implementation UIViewController (HXSwipeBack)

- (BOOL)hx_prefersNavigationBarHidden {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setHx_prefersNavigationBarHidden:(BOOL)hx_prefersNavigationBarHidden {
    objc_setAssociatedObject(self,
                             @selector(hx_prefersNavigationBarHidden),
                             @(hx_prefersNavigationBarHidden),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hx_interactivePopDisabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setHx_interactivePopDisabled:(BOOL)hx_interactivePopDisabled {
    objc_setAssociatedObject(self,
                             @selector(hx_interactivePopDisabled),
                             @(hx_interactivePopDisabled),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hx_recognizeSimultaneouslyEnable {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setHx_recognizeSimultaneouslyEnable:(BOOL)hx_recognizeSimultaneouslyEnable {
    objc_setAssociatedObject(self,
                             @selector(hx_recognizeSimultaneouslyEnable),
                             @(hx_recognizeSimultaneouslyEnable),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


/*********************************** UIViewController (SwipeBackPrivate) ***********************************/

typedef void (^_HXViewControllerWillAppearInjectBlock)(UIViewController *viewController, BOOL animated);

@interface UIViewController (SwipeBackPrivate)
@property (nonatomic, copy) _HXViewControllerWillAppearInjectBlock hx_willAppearInjectBlock;
@end

@implementation UIViewController (SwipeBackPrivate)
/*
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(hx_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}
*/
- (void)hx_viewWillAppear:(BOOL)animated {
    [self hx_viewWillAppear:animated];
    if (self.hx_willAppearInjectBlock) {
        self.hx_willAppearInjectBlock(self, animated);
    }
}

- (_HXViewControllerWillAppearInjectBlock)hx_willAppearInjectBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHx_willAppearInjectBlock:(_HXViewControllerWillAppearInjectBlock)hx_willAppearInjectBlock {
    objc_setAssociatedObject(self, @selector(hx_willAppearInjectBlock), hx_willAppearInjectBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end


/*********************************** UINavigationController (HXSwipeBack) ***********************************/

@implementation UINavigationController (HXSwipeBack)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            @selector(viewDidLoad),
            @selector(pushViewController:animated:),
            @selector(popToViewController:animated:),
            @selector(popToRootViewControllerAnimated:),
            @selector(popViewControllerAnimated:),
            @selector(initWithRootViewController:)
        };
        for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
            SEL originalSelector = selectors[index];
            SEL swizzledSelector = NSSelectorFromString([@"hx_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
            Method originalMethod = class_getInstanceMethod(self, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
            if (class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
    });
}

- (void)hx_viewDidLoad {
    [self hx_viewDidLoad];
    self.interactivePopGestureRecognizer.enabled = NO;
    self.showViewOffsetScale = 1 / 3.0;
    self.showViewOffset = self.showViewOffsetScale * APP_SCREEN_WIDTH;
    self.screenShotView.hidden = YES;
    self.popGestureStyle = HXFullscreenPopGestureGradientStyle;// 默认渐变
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    popRecognizer.delegate = self;
    [self.view addGestureRecognizer:popRecognizer]; // 自定义的滑动返回手势
    
    UIViewController *vc = [self.viewControllers firstObject];
    if (vc) {
        [self hx_setupViewControllerBasedNavigationBarAppearanceIfNeeded:vc];
    }
}

- (void)hx_setupViewControllerBasedNavigationBarAppearanceIfNeeded:(UIViewController *)appearingViewController {
    if (!self.hx_viewControllerBasedNavigationBarAppearanceEnabled) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    _HXViewControllerWillAppearInjectBlock block = ^(UIViewController *viewController, BOOL animated) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf setNavigationBarHidden:viewController.hx_prefersNavigationBarHidden animated:animated];
        }
    };
    appearingViewController.hx_willAppearInjectBlock = block;
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    if (disappearingViewController && !disappearingViewController.hx_willAppearInjectBlock) {
        disappearingViewController.hx_willAppearInjectBlock = block;
    }
}

#pragma mark - 重写父类方法

- (instancetype)hx_initWithRootViewController:(UIViewController *)rootViewController {
    [self hx_setupViewControllerBasedNavigationBarAppearanceIfNeeded:rootViewController];
    return [self hx_initWithRootViewController:rootViewController];
}

- (void)hx_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        [self createScreenShot];
    }
    [self hx_setupViewControllerBasedNavigationBarAppearanceIfNeeded:viewController];
    if (![self.viewControllers containsObject:viewController]) {
        [self hx_pushViewController:viewController animated:animated];
    }
}

- (UIViewController *)hx_popViewControllerAnimated:(BOOL)animated {
    [self.childVCImages removeLastObject];
    return [self hx_popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)hx_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSArray *viewControllers = [self hx_popToViewController:viewController animated:animated];
    if (self.childVCImages.count >= viewControllers.count){
        for (int i = 0; i < viewControllers.count; i++) {
            [self.childVCImages removeLastObject];
        }
    }
    return viewControllers;
}

- (NSArray<UIViewController *> *)hx_popToRootViewControllerAnimated:(BOOL)animated {
    [self.childVCImages removeAllObjects];
    return [self hx_popToRootViewControllerAnimated:animated];
}

- (void)dragging:(UIPanGestureRecognizer *)recognizer{
    // 如果只有1个子控制器,停止拖拽
    if (self.viewControllers.count <= 1) return;
    // 在x方向上移动的距离
    CGFloat tx = [recognizer translationInView:self.view].x;
    
    // 在x方向上移动的距离除以屏幕的宽度
    CGFloat width_scale = 0.0;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // 添加截图到最后面
        width_scale = 0;
        self.screenShotView.hidden = NO;
        self.screenShotView.imageView.image = [self.childVCImages lastObject];
        self.screenShotView.imageView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -self.showViewOffset, 0);
        self.screenShotView.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    } else if (recognizer.state == UIGestureRecognizerStateChanged){
        if (tx < 0 ) { return; }
        // 移动view
        width_scale = tx / APP_SCREEN_WIDTH;
        self.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,tx, 0);
        self.screenShotView.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4 - width_scale * 0.5];
        self.screenShotView.imageView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -self.showViewOffset + tx * self.showViewOffsetScale, 0);
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        //NSLog(@"velocity.x==>>>%f,tx===>>>%f",velocity.x,tx);
        BOOL reset = velocity.x < 0;
        
        CGFloat timeInterval = 0.3;
        if (velocity.x > 1000) {
            timeInterval -= velocity.x/1500;
        }
        if (timeInterval < 0) {
            timeInterval = 0.1;
        }
        // 决定pop还是还原
        if ( (tx >= MAX_PAN_DISTANCE && !reset) || (!reset && velocity.x > 1000)) { // pop回去
            [UIView animateWithDuration:timeInterval animations:^{
                self.screenShotView.maskView.backgroundColor = [UIColor clearColor];
                self.screenShotView.imageView.transform = reset ? CGAffineTransformTranslate(CGAffineTransformIdentity, -self.showViewOffset, 0) : CGAffineTransformIdentity;
                self.view.transform = reset ? CGAffineTransformIdentity : CGAffineTransformTranslate(CGAffineTransformIdentity, APP_SCREEN_WIDTH, 0);
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                self.screenShotView.hidden = YES;
                self.view.transform = CGAffineTransformIdentity;
                self.screenShotView.imageView.transform = CGAffineTransformIdentity;
            }];
        } else { // 还原回去
            [UIView animateWithDuration:0.15 animations:^{
                self.screenShotView.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4 + width_scale * 0.5];
                self.view.transform = CGAffineTransformIdentity;
                self.screenShotView.imageView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -self.showViewOffset, 0);
            } completion:^(BOOL finished) {
                self.screenShotView.imageView.transform = CGAffineTransformIdentity;
            }];
        }
    }
}

// 截屏
- (void)createScreenShot {
    if (self.childViewControllers.count == self.childVCImages.count+1) {
        UIGraphicsBeginImageContextWithOptions(APP_WINDOW.bounds.size, YES, 0);
        [APP_WINDOW.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.childVCImages addObject:image];
    }
}

#pragma mark - UIGestureRecognizerDelegate

// 手势代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (self.visibleViewController.hx_interactivePopDisabled) return NO;
    if (self.viewControllers.count <= 1) return NO;
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint point = [touch locationInView:gestureRecognizer.view];
        if (point.x < PAN_ENABLE_DISTANCE) {//设置手势触发区
            return YES;
        }
    }
    return NO;
}

// 是否与其他手势共存，一般使用默认值(默认返回NO：不与任何手势共存)
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.visibleViewController.hx_recognizeSimultaneouslyEnable) {
        if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")] || [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIPanGestureRecognizer")] ) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Getter and Setter

- (NSMutableArray<UIImage *> *)childVCImages {
    NSMutableArray *images = objc_getAssociatedObject(self, _cmd);
    if (!images) {
        images = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, images, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return images;
}

- (HXScreenShotView *)screenShotView {
    HXScreenShotView *shotView = objc_getAssociatedObject(self, _cmd);
    if (!shotView) {
        shotView = [[HXScreenShotView alloc] init];
        shotView.hidden = YES;
        [APP_WINDOW insertSubview:shotView atIndex:0];
        objc_setAssociatedObject(self, _cmd, shotView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return shotView;
}

- (void)setHx_viewControllerBasedNavigationBarAppearanceEnabled:(BOOL)hx_viewControllerBasedNavigationBarAppearanceEnabled {
    objc_setAssociatedObject(self, @selector(hx_viewControllerBasedNavigationBarAppearanceEnabled), @(hx_viewControllerBasedNavigationBarAppearanceEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (BOOL)hx_viewControllerBasedNavigationBarAppearanceEnabled {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) {
        return number.boolValue;
    }
    self.hx_viewControllerBasedNavigationBarAppearanceEnabled = YES;
    return YES;
}

- (void)setShowViewOffset:(CGFloat)showViewOffset {
    objc_setAssociatedObject(self, @selector(showViewOffset), @(showViewOffset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)showViewOffset {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setShowViewOffsetScale:(CGFloat)showViewOffsetScale {
    objc_setAssociatedObject(self, @selector(showViewOffsetScale), @(showViewOffsetScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)showViewOffsetScale {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (HXFullscreenPopGestureStyle)popGestureStyle {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setPopGestureStyle:(HXFullscreenPopGestureStyle)popGestureStyle {
    objc_setAssociatedObject(self, @selector(popGestureStyle), @(popGestureStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (popGestureStyle == HXFullscreenPopGestureShadowStyle) {
        self.screenShotView.maskView.hidden = YES;
        // 设置阴影
        self.view.layer.shadowColor = [[UIColor grayColor] CGColor];
        self.view.layer.shadowOpacity = 0.7;
        self.view.layer.shadowOffset = CGSizeMake(-3, 0);
        self.view.layer.shadowRadius = 10;
    } else if (popGestureStyle == HXFullscreenPopGestureGradientStyle) {
        self.screenShotView.maskView.hidden = NO;
    }
}

@end
