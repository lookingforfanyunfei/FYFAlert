//
//  UIFont+FYFExtension.m
//  FYFCategory
//
//  Created by 范云飞 on 2021/8/26.
//

#import "UIFont+FYFExtension.h"
#import "NSString+FYFExtension.h"

@implementation UIFont (FYFExtension)

- (CGFloat)fyf_lineHeight {
    return [@" " fyf_sizeWithFont:self maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].height;
}

/**
 苹方字体

 @param fontWeight 字体粗细（字重)
 @param fontSize 字体大小
 @return 返回指定字重大小的苹方字体
 */
+ (UIFont *)fyf_pingFangSCWithWeight:(FYFFontWeightStyle)fontWeight size:(CGFloat)fontSize {
    if (fontWeight < FYFFontWeightStyleMedium || fontWeight > FYFFontWeightStyleThin) {
        fontWeight = FYFFontWeightStyleRegular;
    }

    NSString *fontName = @"PingFangSC-Regular";
    switch (fontWeight) {
        case FYFFontWeightStyleMedium:
            fontName = @"PingFangSC-Medium";
            break;
        case FYFFontWeightStyleSemibold:
            fontName = @"PingFangSC-Semibold";
            break;
        case FYFFontWeightStyleLight:
            fontName = @"PingFangSC-Light";
            break;
        case FYFFontWeightStyleUltralight:
            fontName = @"PingFangSC-Ultralight";
            break;
        case FYFFontWeightStyleRegular:
            fontName = @"PingFangSC-Regular";
            break;
        case FYFFontWeightStyleThin:
            fontName = @"PingFangSC-Thin";
            break;
    }
    
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
 
    return font ?: [UIFont systemFontOfSize:fontSize];  // 如果没有苹方字体，做一下容错处理
}

/// 获取指定字号的苹方"常规体"
/// @param fontSize 字号
+ (UIFont *)fyf_pingFangSCRegularSize:(CGFloat)fontSize {
    return [self fyf_pingFangSCWithWeight:FYFFontWeightStyleRegular size:fontSize];
}

/// 获取指定字号的苹方"中黑体"
/// @param fontSize 字号
+ (UIFont *)fyf_pingFangSCMediumSize:(CGFloat)fontSize {
    return [self fyf_pingFangSCWithWeight:FYFFontWeightStyleMedium size:fontSize];
}

/// 获取指定字号的苹方"细体"
/// @param fontSize 字号
+ (UIFont *)fyf_pingFangSCThinSize:(CGFloat)fontSize {
    return [self fyf_pingFangSCWithWeight:FYFFontWeightStyleThin size:fontSize];
}

/// 获取指定字号的苹方"中粗体"
/// @param fontSize 字号
+ (UIFont *)fyf_pingFangSCSemiboldSize:(CGFloat)fontSize {
    return [self fyf_pingFangSCWithWeight:FYFFontWeightStyleSemibold size:fontSize];
}

/** 创建字体的方法 对字体不存在产生的nil容错 */
+ (UIFont *)fyf_fontWithName:(NSString *)fontName scalesize:(CGFloat)fontSize {
    if (!fontName) {
        return [UIFont systemFontOfSize:fontSize];
    }
    
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    if (!font) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}

+ (UIFont *)fyf_pingFangSCRegularScaleSize:(CGFloat)fontSize {
    return [self fyf_pingFangSCRegularSize:fontSize];
}


@end
