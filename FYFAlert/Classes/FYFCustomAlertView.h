//
//  FYFCustomAlertView.h
//  FYFAlert
//
//  Created by 范云飞 on 2021/9/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FYFCustomAlertBlock)(void);

@interface FYFCustomAlertView : UIView

/// 确定按钮回调
@property (nonatomic, copy) FYFCustomAlertBlock confirmHandler;
/// 取消按钮回调
@property (nonatomic, copy) FYFCustomAlertBlock cancelHandler;

/// 初始化弹框
/// @param view 父视图
/// @param title 标题
/// @param messageAttributedString 内容富文本
/// @param cancelTitle 取消按钮标题
/// @param confirmTitle 确定按钮标题
/// @param cancelHandler 取消回调
/// @param confirmHandler 确定回调
+ (void)fyf_customAlertInView:(UIView *_Nullable)view title:(NSString *_Nullable)title messageAttributedString:(NSAttributedString * _Nullable )messageAttributedString cancelTitle:(NSString *_Nullable)cancelTitle confirmTitle:(NSString *_Nullable)confirmTitle cancelHandler:(void(^ _Nullable )(void))cancelHandler confirmHandler:(void(^ _Nullable )(void))confirmHandler;

/// 初始化弹框
/// @param view 父视图
/// @param title 标题
/// @param message 内容
/// @param cancelTitle 取消按钮标题
/// @param confirmTitle 确定按钮标题
/// @param cancelHandler 取消回调
/// @param confirmHandler 确定回调
+ (void)fyf_customAlertInView:(UIView *_Nullable)view title:(NSString *_Nullable)title message:(NSString *_Nullable)message cancelTitle:(NSString *_Nullable)cancelTitle confirmTitle:(NSString *_Nullable)confirmTitle cancelHandler:(void(^ _Nullable )(void))cancelHandler confirmHandler:(void(^ _Nullable )(void))confirmHandler;

/// 初始化弹框
/// @param view 父视图
/// @param title 标题
/// @param message 内容
/// @param cancelTitle 取消按钮标题
/// @param cancelHandler 取消回调
+ (void)fyf_customAlertInView:(UIView *_Nullable)view title:(NSString *_Nullable)title message:(NSString *_Nullable)message cancelTitle:(NSString *_Nullable)cancelTitle cancelHandler:(void(^ _Nullable )(void))cancelHandler;

/// 初始化弹框
/// @param view 父视图
/// @param title 标题
/// @param message 内容
/// @param confirmTitle 确定按钮标题
/// @param confirmHandler 确定回调
+ (void)fyf_customAlertInView:(UIView *_Nullable)view title:(NSString *_Nullable)title message:(NSString *_Nullable)message confirmTitle:(NSString *_Nullable)confirmTitle confirmHandler:(void(^ _Nullable )(void))confirmHandler;

/// 实例弹框
/// @param parentView 父视图
/// @param title 标题
/// @param message 内容
/// @param cancelTitle 取消按钮标题
/// @param confirmTitle 确定按钮标题
- (instancetype)initWithParentView:(UIView *_Nullable)parentView title:(NSString *_Nullable)title message:(NSString *_Nullable)message cancelTitle:(NSString *_Nullable)cancelTitle confirmTitle:(NSString *_Nullable)confirmTitle;

/// 实例弹框
/// @param parentView 父视图
/// @param title 标题
/// @param messageAttributedString 内容富文本
/// @param cancelTitle 取消按钮标题
/// @param confirmTitle 确定按钮标题
- (instancetype)initWithParentView:(UIView *_Nullable)parentView title:(NSString *_Nullable)title messageAttributedString:(NSAttributedString * _Nullable )messageAttributedString cancelTitle:(NSString *_Nullable)cancelTitle confirmTitle:(NSString *_Nullable)confirmTitle;

/// show
- (void)show;

/// dismiss
- (void)hide;

@end


NS_ASSUME_NONNULL_END
