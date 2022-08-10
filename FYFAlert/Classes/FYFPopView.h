//
//  FYFPopView.h
//  FYFAlert
//
//  Created by 范云飞 on 2021/9/9.
//

#import <UIKit/UIKit.h>

/// 显示动画样式
typedef NS_ENUM(NSInteger, FYFAnimationMode) {
    FYFAnimationModeNone = 0, // 中心位置， 无动画
    FYFAnimationModeFade = 1, // 中心位置， 渐变出现
    FYFAnimationModeScale = 2, // 中心位置， 缩放 先放大后恢复至原大小
    FYFAnimationModeFromTop = 3, // 顶部， 平滑淡入动画
    FYFAnimationModeFromBottom = 4,// 底部， 平滑淡入动画
    FYFAnimationModeSpringFromTop = 5, // 顶部， 平滑淡入动画 带弹簧
    FYFAnimationModeSpringFromBottom = 6 // 底部， 平滑淡入动画 带弹簧
};

NS_ASSUME_NONNULL_BEGIN

@interface FYFPopView : UIView

/// 弹框容器， 默认keyWindow
@property (nonatomic, weak, readonly) UIView *parentView;
/// 自定义view
@property (nonatomic, strong, readonly) UIView *customView;
/// pop动画弹窗样式 默认FYFAnimationModeFade
@property (nonatomic, assign, readonly) FYFAnimationMode animationMode;
/// 显示时动画时长,默认0.3s, 不设置则使用默认的动画时长, animationMode设置成FYFAnimationModeNone 该属性无效
@property (nonatomic, assign, readwrite) NSTimeInterval animationDuration;
/// 显示时动画延迟时长,默认0.1s, 不设置则使用默认的动画延迟时长, animationMode设置成FYFAnimationModeNone 该属性无效
@property (nonatomic, assign, readwrite) NSTimeInterval delayDuration;
/// 点击遮罩是否移除弹窗，默认为YES
@property (nonatomic, assign, readwrite) BOOL dismissWhenClickMaskView;
/// 是否监听屏幕旋转，默认为YES
@property (nonatomic, assign, readwrite) BOOL isObserverScreenRotation;
/// 弹窗水平方向(x轴偏移量)偏移量默认0.0
@property (nonatomic, assign, readwrite) CGFloat xAxisOffset;
/// 弹窗垂直方向(y轴偏移量)偏移量,默认0.0
/// note:animationMode为FYFAnimationModeFromTop|FYFAnimationModeSpringFromTop时，此属性会覆盖customView.ks_top
@property (nonatomic, assign, readwrite) CGFloat yAxisOffset;
/// 遮罩alpha, 默认0.5
@property (nonatomic, assign, readwrite) CGFloat maskAlpha;
/// customView圆角方向设置  默认UIRectCornerAllCorners  当cornerRadius > 0时生效
@property (nonatomic, assign) UIRectCorner rectCorners;
/// customView圆角大小, 默认6
@property (nonatomic, assign) CGFloat cornerRadius;
/// 是否规避键盘, 默认为YES
@property (nonatomic, assign) BOOL isAvoidKeyboard;
/// 弹窗规避键盘的距离, 默认30
@property (nonatomic, assign) CGFloat avoidKeyboardSpace;
/// pop回调
@property (nonatomic, copy, readwrite) void(^popHandler)(void);
/// dismiss回调
@property (nonatomic, copy, readwrite) void(^dismissHandler)(void);

/// 初始化FYFPopView实例
/// @param customView 自定义view
/// @param parentView 父视图,为空时指定为keyWindow
/// @param animationMode pop动画类型
+ (instancetype)initWithCustomView:(UIView * _Nullable)customView parentView:(UIView *_Nullable)parentView animationMode:(FYFAnimationMode)animationMode;

/// 判断是否正在pop
- (BOOL)isPoping;

/// pop
- (void)pop;

/// dismiss
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
