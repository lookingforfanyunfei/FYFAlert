//
//  UIFont+FYFExtension.h
//  FYFCategory
//
//  Created by 范云飞 on 2021/8/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FYFFontWeightStyle) {
    FYFFontWeightStyleMedium,        // 中黑体
    FYFFontWeightStyleSemibold,      // 中粗体
    FYFFontWeightStyleLight,         // 细体
    FYFFontWeightStyleUltralight,    // 极细体
    FYFFontWeightStyleRegular,       // 常规体
    FYFFontWeightStyleThin,          // 纤细体
};


@interface UIFont (FYFExtension)

/// 单行高，这里使用的是 nsstring方法计算的行高，项目中用的比较多
/// @note 也可以直接使用 自带属性 lineHeight
@property (nonatomic, readonly, assign) CGFloat fyf_lineHeight;
/**
 苹方字体

 @param fontWeight 字体粗细（字重)
 @param fontSize 字体大小
 @return 返回指定字重大小的苹方字体
 */
+ (UIFont *)fyf_pingFangSCWithWeight:(FYFFontWeightStyle)fontWeight size:(CGFloat)fontSize;

/// 获取指定字号的苹方"常规体"
/// @param fontSize 字号
+ (UIFont *)fyf_pingFangSCRegularSize:(CGFloat)fontSize;

/// 获取指定字号的苹方"中黑体"
/// @param fontSize 字号
+ (UIFont *)fyf_pingFangSCMediumSize:(CGFloat)fontSize;

/// 获取指定字号的苹方"细体"
/// @param fontSize 字号
+ (UIFont *)fyf_pingFangSCThinSize:(CGFloat)fontSize;

/// 获取指定字号的苹方"中粗体"
/// @param fontSize 字号
+ (UIFont *)fyf_pingFangSCSemiboldSize:(CGFloat)fontSize;

/** 创建字体的方法 对字体不存在产生的nil容错 */
+ (UIFont *)fyf_fontWithName:(NSString *)fontName
                  scalesize:(CGFloat)fontSize;
//** 外界传没有缩放扩大的常规字体号，这个方法里面统一处理 */
+ (UIFont *)fyf_pingFangSCRegularScaleSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
