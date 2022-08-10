//
//  UIColor+FYFExtension.h
//  FYFCategory
//
//  Created by 范云飞 on 2021/9/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (FYFExtension)

/// RGB color 生成UIColor对象
/// @param rgbValue 例如0xff4e3c
+ (UIColor *)fyf_colorWithRGB:(NSInteger)rgbValue;

/// RGB color + 透明度 生成UIColor对象
/// @param rgbValue 例如0xff4e3c
/// @param alpha 透明度 0~1
+ (UIColor *)fyf_colorWithRGB:(NSInteger)rgbValue alpha:(CGFloat)alpha;

/// 使用HEX命名方式的颜色字符串生成一个UIColor对象
/// @param hexString  例如0xd5d5d5、#d5d5d5、d5d5d5, white,gray etc.
+ (UIColor *)fyf_colorWithHexString:(NSString *)hexString;

/// 使用HEX命名方式的颜色字符串生成一个UIColor对象
/// @param hexString 例如0xd5d5d5、#d5d5d5、d5d5d5,white,gray etc.
/// @param alpha 透明度 0~1
+ (UIColor *)fyf_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
@end


@interface UIColor (FYFRGB)

@property (nonatomic, assign, readonly) CGFloat fyf_red;
@property (nonatomic, assign, readonly) CGFloat fyf_green;
@property (nonatomic, assign, readonly) CGFloat fyf_blue;
@property (nonatomic, assign, readonly) CGFloat fyf_alpha;

@end

NS_ASSUME_NONNULL_END
