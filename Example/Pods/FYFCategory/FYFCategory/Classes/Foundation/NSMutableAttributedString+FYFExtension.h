//
//  NSMutableAttributedString+FYFExtension.h
//  FYFCategory
//
//  Created by 范云飞 on 2022/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (FYFExtension)

/// 为子字符串添加颜色
/// @param color <#color description#>
/// @param substring <#substring description#>
- (void)fyf_addColor:(UIColor *)color substring:(NSString *)substring;

/// 为子字符串添加背景色
/// @param color <#color description#>
/// @param substring <#substring description#>
- (void)fyf_addBackgroundColor:(UIColor *)color substring:(NSString *)substring;

/// 为子字符串添加下划线
/// @param substring <#substring description#>
- (void)fyf_addUnderlineForSubstring:(NSString *)substring;

/// 为子字符串添加横线
/// @param thickness <#thickness description#>
/// @param substring <#substring description#>
- (void)fyf_addStrikeThrough:(int)thickness substring:(NSString *)substring;

/// 设置子字符串阴影
/// @param color <#color description#>
/// @param width <#width description#>
/// @param height <#height description#>
/// @param radius <#radius description#>
/// @param substring <#substring description#>
- (void)fyf_addShadowColor:(UIColor *)color width:(int)width height:(int)height radius:(int)radius substring:(NSString *)substring;

/// 设置字符串字体
/// @param fontName <#fontName description#>
/// @param fontSize <#fontSize description#>
/// @param substring <#substring description#>
- (void)fyf_addFontWithName:(NSString *)fontName size:(int)fontSize substring:(NSString *)substring;

/// 设置子字符串字体
/// @param font <#font description#>
/// @param substring <#substring description#>
- (void)fyf_addFont:(UIFont *)font substring:(NSString *)substring;

/// 设置子字符串alignment
/// @param alignment <#alignment description#>
/// @param substring <#substring description#>
- (void)fyf_addAlignment:(NSTextAlignment)alignment substring:(NSString *)substring;

@end

NS_ASSUME_NONNULL_END
