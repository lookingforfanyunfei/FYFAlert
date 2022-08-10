//
//  FYFToast.h
//  FYFAlert
//
//  Created by 范云飞 on 2021/9/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FYFToast : NSObject

+ (FYFToast *)toast;

/// 隐藏当前屏幕上所有的toast
- (void)fyf_hiddenAllToasts;

/// 隐藏指定父视图上的toast
/// @param view 父视图
- (void)fyf_hiddenToastInView:(UIView *)view;

/// keyWindow上显示提示信息（自动隐藏）
/// @param tips 提示信息
- (void)fyf_showToastAutoHidden:(NSString *)tips;

/// 在指定父视图上显示提示信息（自动隐藏）
/// @param tips 提示信息
/// @param view 父视图
- (void)fyf_showToastAutoHidden:(NSString *)tips inView:(UIView *)view;

/// 在指定父视图上显示提示信息（自动隐藏）
/// @param tips 提示信息
/// @param view 父视图
/// @param completion 结束回调
- (void)fyf_showToastAutoHidden:(NSString *)tips inView:(UIView *)view completion:(void(^)(void))completion;

/// 在指定父视图上显示提示信息
/// @param tips 提示信息
/// @param showIndicator YES显示转子, NO不显示转子
/// @param view 父视图
/// @param completion 结束回调
- (void)fyf_showToastAutoHidden:(NSString *)tips showIndicator:(BOOL)showIndicator inView:(UIView *)view completion:(void(^)(void))completion;

/// keyWindow上显示提示信息
/// @param tips 提示信息
- (void)fyf_showToast:(NSString *)tips;

/// keyWindow上显示提示信息（可设定是否显示转子）
/// @param tips 提示信息
/// @param showIndicator YES显示转子, NO不显示转子
- (void)fyf_showToast:(NSString *)tips showIndicator:(BOOL)showIndicator;

/// keyWindow上显示提示信息（可设定自动隐藏时间）
/// @param tips 提示信息
/// @param hiddenAfterSeconds 自动隐藏时间(s)
- (void)fyf_showToast:(NSString *)tips hiddenAfterSeconds:(CGFloat)hiddenAfterSeconds;

/// keyWindow上显示提示信息（可设定自动隐藏时间、是否显示转子）
/// @param tips 提示信息
/// @param showIndicator YES显示转子, NO不显示转子
/// @param hiddenAfterSeconds 自动隐藏时间（s）
- (void)fyf_showToast:(NSString *)tips showIndicator:(BOOL)showIndicator hiddenAfterSeconds:(CGFloat)hiddenAfterSeconds;

/// 在指定父视图上显示提示信息
/// @param tips 提示信息
/// @param view 父视图
- (void)fyf_showToast:(NSString *)tips inView:(UIView *)view;

/// 在指定父视图上显示提示信息（可设定自动隐藏时间）
/// @param tips 提示信息
/// @param view 父视图
/// @param hiddenAfterSeconds 自动隐藏时间（s）
- (void)fyf_showToast:(NSString *)tips inView:(UIView *)view hiddenAfterSeconds:(CGFloat)hiddenAfterSeconds;

/// 在指定父视图上显示提示信息 （可以设定自动隐藏时间，可以设置结束回调）
/// @param tips 提示信息
/// @param view 父视图
/// @param hiddenAfterSeconds 自动隐藏时间（s）
/// @param completion 结束回调
- (void)fyf_showToast:(NSString *)tips inView:(UIView *)view hiddenAfterSeconds:(CGFloat)hiddenAfterSeconds completion:(void(^)(void))completion;

/// 在指定父视图上显示提示信息（可设定是否显示转子）
/// @param tips 提示信息
/// @param view 父视图
/// @param showIndicator 是否显示转子：YES为显示，NO为不显示
- (void)fyf_showToast:(NSString *)tips inView:(UIView *)view showIndicator:(BOOL)showIndicator;

/// 在指定父视图上显示提示信息（可设定是否显示转子，可设定自动隐藏时间）
/// @param tips 提示信息
/// @param view 父视图
/// @param showIndicator 是否显示转子：YES为显示，NO为不显示
/// @param hiddenAfterSeconds 自动隐藏时间（s）
- (void)fyf_showToast:(NSString *)tips inView:(UIView *)view showIndicator:(BOOL)showIndicator hiddenAfterSeconds:(CGFloat)hiddenAfterSeconds;

/// 在指定父视图上提示信息（可设定是否显示转子，可设定自动隐藏时间，可设定结束回调）
/// @param tips 提示信息
/// @param view 父视图
/// @param showIndicator 是否显示转子：YES为显示，NO为不显示
/// @param hiddenAfterSeconds 自动隐藏时间
/// @param completion 结束回调
- (void)fyf_showToast:(NSString *)tips inView:(UIView *)view showIndicator:(BOOL)showIndicator hiddenAfterSeconds:(CGFloat)hiddenAfterSeconds completion:(void(^)(void))completion;

/// 显示loading （父视图为KeyWindow）
/// @param title 加载文案
/// @param view 父视图
- (void)fyf_showLoadingWithTitle:(NSString *)title;

/// 显示loading
/// @param title 加载文案
/// @param view 父视图
- (void)fyf_showLoadingWithTitle:(NSString *)title inView:(UIView *)view;

@end


NS_ASSUME_NONNULL_END
