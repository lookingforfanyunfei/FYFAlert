//
//  UIImage+FYFExtension.h
//  FYFCategory
//
//  Created by 范云飞 on 2021/9/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (FYFExtension)


/// 创建一个size为(1, 1)的纯色的UIImage
/// @param color 图片的颜色
+ (UIImage *)fyf_imageWithColor:(UIColor *)color;

/// 创建一个指定size的纯色的UIImage
/// @param color 图片的颜色
/// @param size 图片的尺寸
+ (UIImage *)fyf_imageWithColor:(UIColor *)color size:(CGSize)size;

/// 创建一个指定size的纯色有圆角的UIImage
/// @param color 图片的颜色
/// @param size 图片的尺寸
/// @param cornerRadius 图片的圆角
+ (UIImage *)fyf_imageWithColor:(UIColor *)color
                           size:(CGSize)size
                   cornerRadius:(CGFloat)cornerRadius;

/// 创建一个指定size的纯色可指定圆角位置的UIImage
/// @param color 图片的颜色
/// @param size 图片的尺寸
/// @param cornerRadius 图片的圆角
/// @param corner 图片的圆角位置
+ (UIImage *)fyf_imageWithColor:(UIColor *)color
                           size:(CGSize)size
                   cornerRadius:(CGFloat)cornerRadius
                     rectCorner:(UIRectCorner)corner;

/// 创建一个指定size的纯色可指定圆角位置及改变颜色偏移位置的UIImage
/// @param color 图片的颜色
/// @param size 图片的尺寸
/// @param offset 偏移量
/// @param cornerRadius 图片的圆角
+ (UIImage *)fyf_imageWithColor:(UIColor *)color
                           size:(CGSize)size
                     edgeOffSet:(UIEdgeInsets)offset
                   cornerRadius:(CGFloat)cornerRadius;


/// 图片base64数据转UIImage
/// @param base64 图片的base64数据转化为图片
+ (nullable UIImage *)fyf_imageWithBase64:(nullable NSString *)base64;

/// 图片方向调整向上，如果本身是正的直接返回self
- (UIImage *)fyf_imageByOrientationUp;

/// 图片转png后的base64数据
- (NSString *)fyf_base64EncodingString;

/// 裁剪图片
/// @param rect 指定裁剪位置
- (UIImage *)fyf_cropImageWithRect:(CGRect)rect;

/// 压缩图片到目标尺寸
/// @param size  size 内进行缩放后的大小
- (UIImage *)fyf_imageByResizeWithTargetSize:(CGSize)size;

/// 图片压缩
/// @param image 原图
/// @param fImageKBytes 需要压缩到的字节数
/// @param block block description
+ (void)fyf_compressedImageFiles:(UIImage *)image imageKB:(CGFloat)fImageKBytes imageBlock:(void(^)(NSData *imageData))block;

/// 拉伸图片
/// @param leftCapWidth 要拉伸的左侧位置
/// @param topCapHeight 要拉伸的顶部位置
- (UIImage *)fyf_stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

/// 给图片加圆角
/// @param radius 图片圆角
- (UIImage *)fyf_imageByRoundCornerRadius:(CGFloat)radius;

/// 给图片加圆角和边框
/// @param radius 图片圆角
/// @param borderWidth 图片边框宽度
/// @param borderColor 图片边框颜色
- (UIImage *)fyf_imageByRoundCornerRadius:(CGFloat)radius
                              borderWidth:(CGFloat)borderWidth
                              borderColor:(nullable UIColor *)borderColor;

/// 给图片加圆角和边框
/// @param radius 图片圆角
/// @param corners 圆角位置
/// @param borderWidth 图片边框宽度
/// @param borderColor 图片边框颜色
/// @param borderLineJoin 边框拐角类型
- (UIImage *)fyf_imageByRoundCornerRadius:(CGFloat)radius
                                  corners:(UIRectCorner)corners
                              borderWidth:(CGFloat)borderWidth
                              borderColor:(nullable UIColor *)borderColor
                           borderLineJoin:(CGLineJoin)borderLineJoin;

@end

NS_ASSUME_NONNULL_END

@interface UIImage (FYFSnapshot)

/// 截图
/// @param view view description
+ (UIImage *)fyf_rendImageWithView:(UIView *)view;

@end


@interface UIImage (FYFQRCode)

/// 生成二维码
/// @param code <#code description#>
/// @param size <#size description#>
+ (UIImage *)fyf_generateQRCode:(NSString *)code size:(CGSize)size;

/// 生成二维码+logo
/// @param code <#code description#>
/// @param size <#size description#>
/// @param logo <#logo description#>
+ (UIImage *)fyf_generateQRCode:(NSString *)code size:(CGSize)size logo:(UIImage *)logo;


@end
