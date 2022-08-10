//
//  UILabel+FYFExtension.m
//  FYFCategory
//
//  Created by 范云飞 on 2022/6/30.
//

#import "UILabel+FYFExtension.h"

@implementation UILabel (FYFExtension)

@end

@implementation UILabel (FYFFactory)

/// 创建UILabel的方法
/// @param text <#text description#>
/// @param textColor textColor description
/// @param backgroundColor 默认[UIColor whiteColor]
/// @param font <#font description#>
+ (UILabel *)fyf_createLabelWithText:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font {
    return [self fyf_createLabelWithText:text textColor:textColor highlightedTextColor:nil backgroundColor:backgroundColor font:font textAlignment:NSTextAlignmentLeft numberOfLines:1 lineBreakMode:NSLineBreakByWordWrapping];
}

/// 创建UILabel的方法
/// @param text <#text description#>
/// @param textColor textColor description
/// @param highlightedTextColor highlightedTextColor description
/// @param backgroundColor 默认[UIColor whiteColor]
/// @param font <#font description#>
+ (UILabel *)fyf_createLabelWithText:(NSString *)text textColor:(UIColor *)textColor highlightedTextColor:(UIColor *)highlightedTextColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font {
    return [self fyf_createLabelWithText:text textColor:textColor highlightedTextColor:highlightedTextColor backgroundColor:backgroundColor font:font textAlignment:NSTextAlignmentLeft numberOfLines:1 lineBreakMode:NSLineBreakByWordWrapping];
}

/// 创建UILabel的基础方法
/// @param text <#text description#>
/// @param textColor 默认[UIColor blackColor]
/// @param highlightedTextColor, 默认nil
/// @param backgroundColor 默认[UIColor whiteColor]
/// @param font 默认[UIFont systemFontOfSize:14]
/// @param textAlignment 默认NSTextAlignmentLeft
+ (UILabel *)fyf_createLabelWithText:(NSString *)text textColor:(UIColor *)textColor highlightedTextColor:(UIColor *)highlightedTextColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment {
    return [self fyf_createLabelWithText:text textColor:textColor highlightedTextColor:highlightedTextColor backgroundColor:backgroundColor font:font textAlignment:textAlignment numberOfLines:1 lineBreakMode:NSLineBreakByWordWrapping];
}

/// 创建UILabel的基础方法
/// @param text <#text description#>
/// @param textColor 默认[UIColor blackColor]
/// @param highlightedTextColor, 默认nil
/// @param backgroundColor 默认[UIColor whiteColor]
/// @param font 默认[UIFont systemFontOfSize:14]
/// @param textAlignment 默认NSTextAlignmentLeft
/// @param numberOfLines 默认1行
+ (UILabel *)fyf_createLabelWithText:(NSString *)text textColor:(UIColor *)textColor   highlightedTextColor:(UIColor *)highlightedTextColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines  {
    return [self fyf_createLabelWithText:text textColor:textColor highlightedTextColor:highlightedTextColor backgroundColor:backgroundColor font:font textAlignment:textAlignment numberOfLines:numberOfLines lineBreakMode:NSLineBreakByWordWrapping];
}

/// 创建UILabel的基础方法
/// @param text <#text description#>
/// @param textColor 默认[UIColor blackColor]
/// @param highlightedTextColor, 默认nil
/// @param backgroundColor 默认[UIColor whiteColor]
/// @param font 默认[UIFont systemFontOfSize:14]
/// @param textAlignment 默认NSTextAlignmentLeft
/// @param numberOfLines 默认1行
/// @param lineBreakMode 默认NSLineBreakByWordWrapping
+ (UILabel *)fyf_createLabelWithText:(NSString *)text textColor:(UIColor *)textColor  highlightedTextColor:(UIColor *)highlightedTextColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines lineBreakMode:(NSLineBreakMode)lineBreakMode {
    UILabel *label  = [[UILabel alloc] init];
    label.text = text;
    if (textColor) {
        label.textColor = textColor;
    } else {
        label.textColor = [UIColor blackColor];
    }
    if (highlightedTextColor) {
        label.highlightedTextColor = highlightedTextColor;
    }
    if (backgroundColor) {
        label.backgroundColor = backgroundColor;
    } else {
        label.backgroundColor = [UIColor whiteColor];
    }
    if (font) {
        label.font = font;
    } else {
        label.font = [UIFont systemFontOfSize:14];
    }
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLines;
    label.lineBreakMode = lineBreakMode;
    return label;
}


@end
