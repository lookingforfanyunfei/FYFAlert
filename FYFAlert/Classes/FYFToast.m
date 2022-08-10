//
//  FYFToast.m
//  FYFAlert
//
//  Created by 范云飞 on 2021/9/9.
//

#import "FYFToast.h"
#import <MBProgressHUD/MBProgressHUD.h>

static NSMutableArray <MBProgressHUD*>*FYFRecordToastViews = nil;

@interface FYFToast () <MBProgressHUDDelegate>

@end

@implementation FYFToast

- (void)dealloc {
    if (FYFRecordToastViews) {
        [FYFRecordToastViews removeAllObjects];
        FYFRecordToastViews = nil;
    }
}

+ (FYFToast *)toast {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        if (!FYFRecordToastViews) {
            FYFRecordToastViews = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (void)fyf_hiddenAllToasts {
    [self fyf_hideAllToastInView:nil animated:YES];
}

- (void)fyf_hiddenToastInView:(UIView *)view {
    [self fyf_hideAllToastInView:view animated:YES];
}

- (void)fyf_showToastAutoHidden:(NSString *)tips {
    UIWindow *keyWindow = [self fyf_systemKeyboardView];
    [self fyf_showToastAutoHidden:tips inView:keyWindow];
}

- (void)fyf_showToastAutoHidden:(NSString *)tips inView:(UIView *)view {
    [self fyf_showToastAutoHidden:tips inView:view completion:nil];
}

- (void)fyf_showToastAutoHidden:(NSString *)tips inView:(UIView *)view completion:(void(^)(void))completion {
    [self fyf_showToastAutoHidden:tips showIndicator:NO inView:view completion:completion];
}

- (void)fyf_showToastAutoHidden:(NSString *)tips showIndicator:(BOOL)showIndicator inView:(UIView *)view completion:(void(^)(void))completion {
    CGFloat seconds = tips.length / 10.0f;
    if (seconds > 3) {
        seconds = 3;
    } else if (seconds < 0.5) {
        seconds = 0.5;
    }
    
    [self fyf_showToast:tips inView:view showIndicator:showIndicator hiddenAfterSeconds:seconds completion:completion];
}

- (void)fyf_showToast:(NSString *)tips {
    [self fyf_showToast:tips showIndicator:YES];
}

- (void)fyf_showToast:(NSString *)tips showIndicator:(BOOL)showIndicator {
    [self fyf_showToast:tips showIndicator:showIndicator hiddenAfterSeconds:0];
}

- (void)fyf_showToast:(NSString *)tips hiddenAfterSeconds:(CGFloat)hiddenAfterSeconds {
    [self fyf_showToast:tips showIndicator:NO hiddenAfterSeconds:hiddenAfterSeconds];
}

- (void)fyf_showToast:(NSString *)tips showIndicator:(BOOL)showIndicator hiddenAfterSeconds:(CGFloat)hiddenAfterSeconds {
    UIWindow *keyWindow = [self fyf_systemKeyboardView];
    [self fyf_showToast:tips inView:keyWindow showIndicator:showIndicator hiddenAfterSeconds:hiddenAfterSeconds];
}

- (void)fyf_showToast:(NSString *)tips inView:(UIView *)view {
    [self fyf_showToast:tips inView:view showIndicator:YES hiddenAfterSeconds:0];
}

- (void)fyf_showToast:(NSString *)tips inView:(UIView *)view hiddenAfterSeconds:(CGFloat)hiddenAfterSeconds {
    [self fyf_showToast:tips inView:view showIndicator:NO hiddenAfterSeconds:hiddenAfterSeconds];
}

- (void)fyf_showToast:(NSString *)tips inView:(UIView *)view hiddenAfterSeconds:(CGFloat)hiddenAfterSeconds completion:(void(^)(void))completion {
    [self fyf_showToast:tips inView:view showIndicator:NO hiddenAfterSeconds:hiddenAfterSeconds completion:completion];
}

- (void)fyf_showToast:(NSString *)tips inView:(UIView *)view showIndicator:(BOOL)showIndicator {
    [self fyf_showToast:tips inView:view showIndicator:showIndicator hiddenAfterSeconds:0];
}

- (void)fyf_showToast:(NSString *)tips inView:(UIView *)view showIndicator:(BOOL)showIndicator hiddenAfterSeconds:(CGFloat)hiddenAfterSeconds {
    [self fyf_showToast:tips inView:view showIndicator:showIndicator hiddenAfterSeconds:hiddenAfterSeconds completion:nil];
}

- (void)fyf_showToast:(NSString *)tips inView:(UIView *)view showIndicator:(BOOL)showIndicator hiddenAfterSeconds:(CGFloat)hiddenAfterSeconds completion:(void(^)(void))completion {
    if (!view) {
        return;
    }
    //有的场景不需要显示文字,这里调整成转子和文字都没有的时候返回
    if ((!tips || [tips length] < 1) && !showIndicator) {
        return ;
    }

    //先隐藏之前的toast，避免多个toast重叠显示
    [self fyf_hiddenAllToasts];
    
    MBProgressHUD *hud = [self fyf_createHUDWithView:view];
    hud.detailsLabel.text = tips;
    
    if (!showIndicator) {
        hud.mode = MBProgressHUDModeText;
    }
    if (hiddenAfterSeconds > 0) {
        [hud hideAnimated:YES afterDelay:hiddenAfterSeconds];
    }
    hud.completionBlock = completion;
    
    [self fyf_updateToastViews:hud];
}

- (void)fyf_showLoadingWithTitle:(NSString *)title {
    UIWindow *keyWindow = [self fyf_systemKeyboardView];
    [self fyf_showLoadingWithTitle:title inView:keyWindow];
}

- (void)fyf_showLoadingWithTitle:(NSString *)title inView:(UIView *)view {
    if (!view) {
        return;
    }
    //先隐藏之前的toast，避免多个toast重叠显示
    [self fyf_hiddenAllToasts];
    
    MBProgressHUD *hud = [self fyf_createHUDWithView:view];
    hud.detailsLabel.text = title;
    hud.userInteractionEnabled = YES;
    hud.minShowTime = 0;
    
    [self fyf_updateToastViews:hud];
}

/// 获取键盘的父类window 弹出的时候不会被键盘遮住
- (UIWindow *)fyf_systemKeyboardView {
    return [UIApplication sharedApplication].keyWindow;
}

/// 初始化MBProgressHUD实例
/// @param view 父视图
- (MBProgressHUD *)fyf_createHUDWithView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.delegate  = self;
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.defaultMotionEffectsEnabled = NO;
    hud.contentColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:14.0f];
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.label.textColor = [UIColor whiteColor];
    hud.label.font = [UIFont systemFontOfSize:17.0f];
    return hud;
}

- (void)fyf_updateToastViews:(MBProgressHUD *)hud {
    if (![FYFRecordToastViews containsObject:hud]) {
        [FYFRecordToastViews addObject:hud];
    }
}

- (void)fyf_hideAllToastInView:(UIView *)view animated:(BOOL)animated {
    NSArray *toastViews = [self fyf_allToastInView:view];
    for (MBProgressHUD *toastView in toastViews) {
        [toastView hideAnimated:animated];
    }
    if (FYFRecordToastViews.count) {
        [FYFRecordToastViews removeAllObjects];
    }
}

- (nullable NSArray<MBProgressHUD *>*)fyf_allToastInView:(UIView *)view {
    if (!view) {
        return FYFRecordToastViews.count > 0 ? [FYFRecordToastViews mutableCopy] : nil;
    }
    NSMutableArray *toastViews = [[NSMutableArray alloc] init];
    for (UIView *toastView in FYFRecordToastViews) {
        if (toastView.superview == view && [toastView isKindOfClass:[MBProgressHUD class]]) {
            [toastViews addObject:toastView];
        }
    }
    return toastViews.count > 0 ? [toastViews mutableCopy] : nil;
}

#pragma mark - MBProgressHUDDelegate
//保证FYFRecordToastViews移除所有的元素
- (void)hudWasHidden:(MBProgressHUD *)hud {
    if ([FYFRecordToastViews containsObject:hud]) {
        [FYFRecordToastViews removeObject:hud];
    }
}


@end

