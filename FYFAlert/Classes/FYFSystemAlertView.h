//
//  FYFSystemAlertView.h
//  FYFAlert
//
//  Created by 范云飞 on 2021/9/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FYFSystemAlertView : UIView
/// 只有单个确定按钮的alert
/// @param rootController pesentViewController
/// @param title 标题
/// @param message 内容
/// @param confirmButtonTitle 确定按钮标题
/// @param confirmHandler 确定按钮回调
+ (void)fyf_systemAlertInVc:(UIViewController * _Nullable )rootController title:(NSString * _Nullable )title message:(NSString * _Nullable )message confirmButtonTitle:(NSString * _Nullable )confirmButtonTitle confirmHandler:(void(^ _Nullable )(void))confirmHandler;

/// 同时有取消和确定按钮的alert
/// @param rootController pesentViewController
/// @param title 标题
/// @param message 内容
/// @param cancleButtonTitle 取消按钮标题
/// @param confirmButtonTitle 确定按钮标题
/// @param cancelHandler 取消按钮回调
/// @param confirmHandler 确定按钮回调
+ (void)fyf_systemAlertInVc:(UIViewController * _Nullable )rootController title:(NSString * _Nullable )title message:(NSString * _Nullable )message cancleButtonTitle:(NSString * _Nullable )cancleButtonTitle confirmButtonTitle:(NSString * _Nullable )confirmButtonTitle cancelHandler:(void(^ _Nullable )(void))cancelHandler confirmHandler:(void(^ _Nullable )(void))confirmHandler;

/// 同时有取消和确定按钮的alert
/// @param rootController pesentViewController
/// @param title 标题
/// @param message 内容
/// @param messageFontSize message 字体大小， 默认为14
/// @param cancleButtonTitle 取消按钮标题
/// @param cancleButtonTitleColor 取消按钮标题颜色
/// @param confirmButtonTitle 确定按钮标题
/// @param confirmButtonTitleColor 确定按钮标题颜色
/// @param cancelHandler 取消按钮回调
/// @param confirmHandler 确定按钮回调
+ (void)fyf_systemAlertInVc:(UIViewController * _Nullable )rootController title:(NSString * _Nullable )title message:(NSString * _Nullable )message messageFontSize:(CGFloat)messageFontSize cancleButtonTitle:(NSString * _Nullable )cancleButtonTitle cancleButtonTitleColor:(UIColor *_Nullable)cancleButtonTitleColor confirmButtonTitle:(NSString * _Nullable )confirmButtonTitle confirmButtonTitleColor:(UIColor *_Nullable)confirmButtonTitleColor cancelHandler:(void(^ _Nullable )(void))cancelHandler confirmHandler:(void(^ _Nullable )(void))confirmHandler;

/// 系统ActionSheet
/// @param rootController pesentViewController
/// @param title 标题
/// @param message 内容
/// @param cancelButtonTitle 取消按钮
/// @param destructiveButtonTitle destructiveButtonTitle
/// @param otherButtonTitles otherButtonTitles
+ (void)fyf_systemAlertInVc:(UIViewController * _Nullable )rootController title:(NSString * _Nullable )title message:(NSString *_Nullable)message cancelButtonTitle:(NSString *_Nullable )cancelButtonTitle destructiveButtonTitle:(NSString * _Nullable)destructiveButtonTitle otherButtonTitles:(NSArray * _Nullable)otherButtonTitles handler:(void(^ _Nullable)(UIAlertController * __nonnull alertController, UIAlertAction * __nonnull action, NSInteger buttonIndex))handler;
@end


NS_ASSUME_NONNULL_END
