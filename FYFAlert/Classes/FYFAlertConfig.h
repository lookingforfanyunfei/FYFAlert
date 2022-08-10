//
//  FYFAlertConfig.h
//  FYFAlert
//
//  Created by 范云飞 on 2022/6/1.
//

#import <Foundation/Foundation.h>


@interface FYFAlertViewConfig : NSObject

+ (FYFAlertViewConfig *)shareConfig;

/// 标题字体，默认[UIFont ks_pingFangSCMediumSize:18]
@property (nonatomic, strong) UIFont *titleFont;
/// 标题颜色，默认FYFColorFromRGB(0x000000)
@property (nonatomic, strong) UIColor *titleColor;

/// 内容字体，默认[UIFont ks_pingFangSCRegularSize:14]
@property (nonatomic, strong) UIFont *messageFont;
/// 内容颜色，默认FYFColorFromRGB(0x000000)
@property (nonatomic, strong) UIColor *messageColor;

/// 取消按钮字体，默认[UIFont ks_pingFangSCRegularSize:15]
@property (nonatomic, strong) UIFont *cancelButtonFont;
/// 取消按钮字体颜色，默认FYFColorFromRGB(0x000000)
@property (nonatomic, strong) UIColor *cancelButtonTitleColor;

/// 确认按钮字体，默认[UIFont ks_pingFangSCRegularSize:15]
@property (nonatomic, strong) UIFont *confirmButtonFont;
/// 确认按钮字体颜色，默认FYFColorFromRGB(0x266EFF)
@property (nonatomic, strong) UIColor *confirmButtonTitleColor;

/// 标题距离弹框顶部的距离，默认KSViewScale(24)
@property (nonatomic, assign) CGFloat titleTopMargin;
/// 标题距离弹框左右的距离，默认KSViewScale(12)
@property (nonatomic, assign) CGFloat titleLeftRightMargin;

/// 消息距离title底部的距离，默认KSViewScale(16)
@property (nonatomic, assign) CGFloat messageTopMargin;
/// 消息距离弹框左右的距离，默认KSViewScale(24)
@property (nonatomic, assign) CGFloat messageLeftRightMargin;
/// 消息距离底部按钮顶部的距离，默认KSViewScale(20)
@property (nonatomic, assign) CGFloat messageBottomMargin;

/// 按钮的高度，默认KSViewScale(44)
@property (nonatomic, assign) CGFloat buttonHeight;
/// 弹框宽度，默认KSDeviceWidth - 2*KSViewScale(48)
@property (nonatomic, assign) CGFloat contentWith;
/// 弹框圆角，默认4
@property (nonatomic, assign) CGFloat radius;

/// 弹框高度，默认KSViewScale(224)，是根据内容动态计算出来的，无需设置
@property (nonatomic, assign, readonly) CGFloat contentHeight;

/// 遮罩透明度， 默认0.5
@property (nonatomic, assign) CGFloat alpha;

@end

NS_ASSUME_NONNULL_BEGIN

@interface FYFAlertConfig : NSObject

@end

NS_ASSUME_NONNULL_END
