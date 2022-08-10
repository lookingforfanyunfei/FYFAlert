//
//  UIColor+FYFExtension.m
//  FYFCategory
//
//  Created by 范云飞 on 2021/9/1.
//

#import "UIColor+FYFExtension.h"

@implementation UIColor (FYFExtension)

/// RGB color 生成UIColor对象
/// @param rgbValue 例如0xff4e3c
+ (UIColor *)fyf_colorWithRGB:(NSInteger)rgbValue {
    return [UIColor fyf_colorWithRGB:rgbValue alpha:1];
}

/// RGB color + 透明度 生成UIColor对象
/// @param rgbValue 例如0xff4e3c
/// @param alpha 0~1
+ (UIColor *)fyf_colorWithRGB:(NSInteger)rgbValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:alpha];
}

/// 使用HEX命名方式的颜色字符串生成一个UIColor对象
/// @param hexString  例如0xd5d5d5、#d5d5d5、d5d5d5
+ (UIColor *)fyf_colorWithHexString:(NSString *)hexString {
    return [self fyf_colorWithHexString:hexString alpha:1.0];
}

/// 使用HEX命名方式的颜色字符串生成一个UIColor对象
/// @param hexString 例如0xd5d5d5、#d5d5d5、d5d5d5
/// @param alpha 透明度 0~1
+ (UIColor *)fyf_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    NSString *tranString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([hexString containsString:@"grouptableviewbackgroundcolor"]) {
        return [UIColor groupTableViewBackgroundColor];
    } else if ([hexString containsString:@"black"]) {
        return [UIColor blackColor];
    } else if ([hexString containsString:@"darkgray"]) {
        return [UIColor darkGrayColor];
    } else if ([hexString containsString:@"lightgray"]) {
        return [UIColor lightGrayColor];
    } else if ([hexString containsString:@"white"]) {
        return [UIColor whiteColor];
    } else if ([hexString containsString:@"gray"]) {
        return [UIColor grayColor];
    } else if ([hexString containsString:@"red"]) {
        return [UIColor redColor];
    } else if ([hexString containsString:@"green"]) {
        return [UIColor greenColor];
    } else if ([hexString containsString:@"blue"]) {
        return [UIColor blueColor];
    } else if ([hexString containsString:@"cyan"]) {
        return [UIColor cyanColor];
    } else if ([hexString containsString:@"yellow"]) {
        return [UIColor yellowColor];
    } else if ([hexString containsString:@"magenta"]) {
        return [UIColor magentaColor];
    } else if ([hexString containsString:@"orange"]) {
        return [UIColor orangeColor];
    } else if ([hexString containsString:@"purple"]) {
        return [UIColor purpleColor];
    } else if ([hexString containsString:@"brown"]) {
        return [UIColor brownColor];
    } else if ([hexString containsString:@"clear"]) {
        return [UIColor clearColor];
    }
    
    // String should be 6 or 8 characters
    if ([tranString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([tranString hasPrefix:@"0X"]){
        tranString = [tranString substringFromIndex:2];
    }
    
    if ([tranString hasPrefix:@"#"]){
        tranString = [tranString substringFromIndex:1];
    }
    
    if ([tranString length] != 6){
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [tranString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [tranString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [tranString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r/255.f) green:((float) g/255.f) blue:((float) b/255.f) alpha:alpha];
}

@end


@implementation UIColor (FYFRGB)

- (CGFloat)fyf_red {
    CGFloat r = 0, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return r * 255.0;
}

- (CGFloat)fyf_green {
    CGFloat r, g = 0, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return g * 255.0;
}

- (CGFloat)fyf_blue {
    CGFloat r, g, b = 0, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return b * 255.0;
}

- (CGFloat)fyf_alpha {
    return CGColorGetAlpha(self.CGColor);
}

@end
