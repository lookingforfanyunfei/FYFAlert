//
//  UILabel+FYFExtension.h
//  FYFCategory
//
//  Created by 范云飞 on 2022/6/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (FYFExtension)

@end

@interface UILabel (FYFFactory)

/// 创建UILabel的方法
/// @param text <#text description#>
/// @param textColor textColor description
/// @param backgroundColor 默认[UIColor whiteColor]
/// @param font <#font description#>
+ (UILabel *)fyf_createLabelWithText:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font;

/// 创建UILabel的方法
/// @param text <#text description#>
/// @param textColor textColor description
/// @param highlightedTextColor highlightedTextColor description
/// @param backgroundColor 默认[UIColor whiteColor]
/// @param font <#font description#>
+ (UILabel *)fyf_createLabelWithText:(NSString *)text textColor:(UIColor *)textColor highlightedTextColor:(UIColor *)highlightedTextColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font;

/// 创建UILabel的基础方法
/// @param text <#text description#>
/// @param textColor 默认[UIColor blackColor]
/// @param highlightedTextColor, 默认nil
/// @param backgroundColor 默认[UIColor whiteColor]
/// @param font 默认[UIFont systemFontOfSize:14]
/// @param textAlignment 默认NSTextAlignmentLeft
+ (UILabel *)fyf_createLabelWithText:(NSString *)text textColor:(UIColor *)textColor highlightedTextColor:(UIColor *)highlightedTextColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;

/// 创建UILabel的基础方法
/// @param text <#text description#>
/// @param textColor 默认[UIColor blackColor]
/// @param highlightedTextColor, 默认nil
/// @param backgroundColor 默认[UIColor whiteColor]
/// @param font 默认[UIFont systemFontOfSize:14]
/// @param textAlignment 默认NSTextAlignmentLeft
/// @param numberOfLines 默认1行
+ (UILabel *)fyf_createLabelWithText:(NSString *)text textColor:(UIColor *)textColor   highlightedTextColor:(UIColor *)highlightedTextColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines ;

/// 创建UILabel的基础方法
/// @param text <#text description#>
/// @param textColor 默认[UIColor blackColor]
/// @param highlightedTextColor, 默认nil
/// @param backgroundColor 默认[UIColor whiteColor]
/// @param font 默认[UIFont systemFontOfSize:14]
/// @param textAlignment 默认NSTextAlignmentLeft
/// @param numberOfLines 默认1行
/// @param lineBreakMode 默认NSLineBreakByWordWrapping
+ (UILabel *)fyf_createLabelWithText:(NSString *)text textColor:(UIColor *)textColor highlightedTextColor:(UIColor *)highlightedTextColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end

NS_ASSUME_NONNULL_END
