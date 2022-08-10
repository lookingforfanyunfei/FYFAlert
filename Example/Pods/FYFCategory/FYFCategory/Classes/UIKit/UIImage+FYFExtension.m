//
//  UIImage+FYFExtension.m
//  FYFCategory
//
//  Created by 范云飞 on 2021/9/7.
//

#import "UIImage+FYFExtension.h"

@implementation UIImage (FYFExtension)

/// 创建一个size为(1, 1)的纯色的UIImage
/// @param color 图片的颜色
+ (UIImage *)fyf_imageWithColor:(UIColor *)color {
    return [self fyf_imageWithColor:color
                               size:CGSizeMake(1.0f, 1.0f)];
}

/// 创建一个指定size的纯色的UIImage
/// @param color 图片的颜色
/// @param size 图片的尺寸
+ (UIImage *)fyf_imageWithColor:(UIColor *)color size:(CGSize)size {
    return [self fyf_imageWithColor:color
                               size:size
                       cornerRadius:0
                         rectCorner:UIRectCornerAllCorners];
}

/// 创建一个指定size的纯色有圆角的UIImage
/// @param color 图片的颜色
/// @param size 图片的尺寸
/// @param radius 图片的圆角
+ (UIImage *)fyf_imageWithColor:(UIColor *)color
                           size:(CGSize)size
                   cornerRadius:(CGFloat)radius {
    return [self fyf_imageWithColor:color
                               size:size
                       cornerRadius:radius
                         rectCorner:UIRectCornerAllCorners];
}

/// 创建一个指定size的纯色可指定圆角位置的UIImage
/// @param color 图片的颜色
/// @param size 图片的尺寸
/// @param radius 图片的圆角
/// @param corner 图片的圆角位置
+ (UIImage *)fyf_imageWithColor:(UIColor *)color
                           size:(CGSize)size
                   cornerRadius:(CGFloat)radius
                     rectCorner:(UIRectCorner)corner {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size,NO,[UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(context, path.CGPath);
    CGContextFillPath(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)fyf_imageByOrientationUp {
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp)
        return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


- (NSString *)fyf_base64EncodingString {
    if (self == nil) {
        return nil;
    }
   
    NSData *data = [UIImagePNGRepresentation(self) base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

/// 图片base64数据转UIImage
+ (nullable UIImage *)fyf_imageWithBase64:(nullable NSString *)base64 {
    if(nil == base64 || base64.length == 0){
        return nil;
    }
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    if(imageData == nil){
        return nil;
    }
    return [UIImage imageWithData:imageData];
}

/// 创建一个指定size的纯色可指定圆角位置及改变颜色偏移位置的UIImage
/// @param color 图片的颜色
/// @param size 图片的尺寸
/// @param offset 偏移量
/// @param radius 图片的圆角
+ (UIImage *)fyf_imageWithColor:(UIColor *)color
                           size:(CGSize)size
                     edgeOffSet:(UIEdgeInsets)offset
                   cornerRadius:(CGFloat)radius {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    rect = UIEdgeInsetsInsetRect(rect, offset);
    
    UIGraphicsBeginImageContextWithOptions(size,NO,[UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(context, path.CGPath);
    CGContextFillPath(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/// 裁剪图片
/// @param rect 指定裁剪位置
- (UIImage *)fyf_cropImageWithRect:(CGRect)rect {
    CGImageRef sourceImageRef = [self CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

/// 压缩图片到目标尺寸
/// @param size  size 内进行缩放后的大小
- (UIImage *)fyf_imageByResizeWithTargetSize:(CGSize)size {
    // 图片尺寸
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    // 目标尺寸
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    // 缩放后的宽高 （因为给的数据不一定等比例缩放大小，所以额外有一个局部变量）
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(self.size, size) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        //缩放比例
        CGFloat scaleFactor = (widthFactor > heightFactor) ? widthFactor : heightFactor;
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if (widthFactor > heightFactor)
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5f;
        else
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5f;
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    //压缩后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/// 图片压缩
/// @param image 原图
/// @param fImageKBytes 需要压缩到的字节数
/// @param block block description
+ (void)fyf_compressedImageFiles:(UIImage *)image imageKB:(CGFloat)fImageKBytes imageBlock:(void(^)(NSData *imageData))block {
    // 二分法压缩图片
    CGFloat compression = 1;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    NSUInteger fImageBytes = fImageKBytes * 1000;//需要压缩的字节Byte，iOS系统内部的进制1000
    if (imageData.length <= fImageBytes){
        block(imageData);
        return;
    }
    CGFloat max = 1;
    CGFloat min = 0;
    // 指数二分处理，s首先计算最小值
    compression = pow(2, -6);
    imageData = UIImageJPEGRepresentation(image, compression);
    if (imageData.length < fImageBytes) {
        // 二分最大10次，区间范围精度最大可达0.00097657；最大6次，精度可达0.015625
        for (int i = 0; i < 6; ++i) {
            compression = (max + min) / 2;
            imageData = UIImageJPEGRepresentation(image, compression);
            // 容错区间范围0.9～1.0
            if (imageData.length < fImageBytes * 0.9) {
                min = compression;
            } else if (imageData.length > fImageBytes) {
                max = compression;
            } else {
                break;
            }
        }
        
        block(imageData);
        return;
    }
 
    // 对于图片太大上面的压缩比即使很小压缩出来的图片也是很大，不满足使用，然后再一步绘制压缩处理
    UIImage *resultImage = [UIImage imageWithData:imageData];
    while (imageData.length > fImageBytes) {
        @autoreleasepool {
            CGFloat ratio = (CGFloat)fImageBytes / imageData.length;
            //使用NSUInteger不然由于精度问题，某些图片会有白边
            CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                     (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
            resultImage = [self fyf_thumbnailForData:imageData maxPixelSize:MAX(size.width, size.height)];
            imageData = UIImageJPEGRepresentation(resultImage, compression);
        }
    }
    // 整理后的图片尽量不要用UIImageJPEGRepresentation方法转换，后面参数1.0并不表示的是原质量转换。
    block(imageData);
}

+ (UIImage *)fyf_thumbnailForData:(NSData *)data maxPixelSize:(NSUInteger)size {
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    CGImageSourceRef source = CGImageSourceCreateWithDataProvider(provider, NULL);
    
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(source, 0, (__bridge CFDictionaryRef) @{
                                                                                                      (NSString *)kCGImageSourceCreateThumbnailFromImageAlways : @YES,
                                                                                                      (NSString *)kCGImageSourceThumbnailMaxPixelSize : @(size),
                                                                                                      (NSString *)kCGImageSourceCreateThumbnailWithTransform : @YES,
                                                                                                      });
    CFRelease(source);
    CFRelease(provider);
    
    if (!imageRef) {
        return nil;
    }
    
    UIImage *toReturn = [UIImage imageWithCGImage:imageRef];
    
    CFRelease(imageRef);
    
    return toReturn;
}


/// 拉伸图片
/// @param leftCapWidth 要拉伸的左侧位置
/// @param topCapHeight 要拉伸的顶部位置
- (UIImage *)fyf_stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight {
    NSInteger rightCap = self.size.width - leftCapWidth - 1;
    NSInteger bottomCap = self.size.height - topCapHeight - 1;
    UIImage *resizableImage = [self resizableImageWithCapInsets:UIEdgeInsetsMake(topCapHeight, leftCapWidth, bottomCap, rightCap)];
    return resizableImage;
}

/// 给图片加圆角
/// @param radius 图片圆角
- (UIImage *)fyf_imageByRoundCornerRadius:(CGFloat)radius {
    return [self fyf_imageByRoundCornerRadius:radius
                                  borderWidth:0
                                  borderColor:nil];
}

/// 给图片加圆角和边框
/// @param radius 图片圆角
/// @param borderWidth 图片边框宽度
/// @param borderColor 图片边框颜色
- (UIImage *)fyf_imageByRoundCornerRadius:(CGFloat)radius
                              borderWidth:(CGFloat)borderWidth
                              borderColor:(nullable UIColor *)borderColor {
    return [self fyf_imageByRoundCornerRadius:radius
                                      corners:UIRectCornerAllCorners
                                  borderWidth:borderWidth
                                  borderColor:borderColor
                               borderLineJoin:kCGLineJoinMiter];
}

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
                           borderLineJoin:(CGLineJoin)borderLineJoin {
    
    if (corners != UIRectCornerAllCorners) {
        UIRectCorner tmp = 0;
        if (corners & UIRectCornerTopLeft) tmp |= UIRectCornerBottomLeft;
        if (corners & UIRectCornerTopRight) tmp |= UIRectCornerBottomRight;
        if (corners & UIRectCornerBottomLeft) tmp |= UIRectCornerTopLeft;
        if (corners & UIRectCornerBottomRight) tmp |= UIRectCornerTopRight;
        corners = tmp;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    
    CGFloat minSize = MIN(self.size.width, self.size.height);
    if (borderWidth < minSize / 2) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, borderWidth)];
        [path closePath];
        
        CGContextSaveGState(context);
        [path addClip];
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextRestoreGState(context);
    }
    
    if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
        CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
        CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
        CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius, borderWidth)];
        [path closePath];
        
        path.lineWidth = borderWidth;
        path.lineJoinStyle = borderLineJoin;
        [borderColor setStroke];
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end


@implementation UIImage (FYFSnapshot)

/// 截图
/// @param view view description
+ (UIImage *)fyf_rendImageWithView:(UIView *)view {
    //      1.开始位图上下文
    UIGraphicsBeginImageContext(view.frame.size);
    //      2.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //    3.截图
    [view.layer renderInContext:ctx];
    //    4.获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //    5.关闭上下文
    UIGraphicsEndImageContext() ;
    
    return newImage;
}

@end

#import <AVFoundation/AVFoundation.h>
#import <CoreImage/CoreImage.h>

static NSString *fyfInputCorrectionLevelL = @"L";//!< L: 7%
static NSString *fyfInputCorrectionLevelM = @"M";//!< M: 15%
static NSString *fyfInputCorrectionLevelQ = @"Q";//!< Q: 25%
static NSString *fyfInputCorrectionLevelH = @"H";//!< H: 30%

@implementation UIImage (FYFQRCode)

/// 生成二维码
/// @param code <#code description#>
/// @param size <#size description#>
+ (UIImage *)fyf_generateQRCode:(NSString *)code size:(CGSize)size {
    NSData *codeData = [code dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator" withInputParameters:@{@"inputMessage": codeData, @"inputCorrectionLevel": fyfInputCorrectionLevelH}];
    UIImage *codeImage = [UIImage fyf_scaleImage:filter.outputImage toSize:size];
    
    return codeImage;
}

/// 生成二维码+logo
/// @param code <#code description#>
/// @param size <#size description#>
/// @param logo <#logo description#>
+ (UIImage *)fyf_generateQRCode:(NSString *)code size:(CGSize)size logo:(UIImage *)logo {
    UIImage *codeImage = [UIImage fyf_generateQRCode:code size:size];
    codeImage = [UIImage fyf_combinateCodeImage:codeImage andLogo:logo];
    
    return codeImage;
}

#pragma mark - Util functions

// 缩放图片(生成高质量图片）
+ (UIImage *)fyf_scaleImage:(CIImage *)image toSize:(CGSize)size {
    
    //! 将CIImage转成CGImageRef
    CGRect integralRect = image.extent;// CGRectIntegral(image.extent);// 将rect取整后返回，origin取舍，size取入
    CGImageRef imageRef = [[CIContext context] createCGImage:image fromRect:integralRect];
    
    //! 创建上下文
    CGFloat sideScale = fminf(size.width / integralRect.size.width, size.width / integralRect.size.height) * [UIScreen mainScreen].scale;// 计算需要缩放的比例
    size_t contextRefWidth = ceilf(integralRect.size.width * sideScale);
    size_t contextRefHeight = ceilf(integralRect.size.height * sideScale);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGContextRef contextRef = CGBitmapContextCreate(nil, contextRefWidth, contextRefHeight, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);// 灰度、不透明
    CGColorSpaceRelease(colorSpaceRef);
    
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);// 设置上下文无插值
    CGContextScaleCTM(contextRef, sideScale, sideScale);// 设置上下文缩放
    CGContextDrawImage(contextRef, integralRect, imageRef);// 在上下文中的integralRect中绘制imageRef
    CGImageRelease(imageRef);
    
    //! 从上下文中获取CGImageRef
    CGImageRef scaledImageRef = CGBitmapContextCreateImage(contextRef);
    CGContextRelease(contextRef);
    
    //! 将CGImageRefc转成UIImage
    UIImage *scaledImage = [UIImage imageWithCGImage:scaledImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    CGImageRelease(scaledImageRef);
    
    return scaledImage;
}

// 合成图片（code+logo）
+ (UIImage *)fyf_combinateCodeImage:(UIImage *)codeImage andLogo:(UIImage *)logo {
    
    UIGraphicsBeginImageContextWithOptions(codeImage.size, YES, [UIScreen mainScreen].scale);
    
    // 将codeImage画到上下文中
    [codeImage drawInRect:(CGRect){.0, .0, codeImage.size.width, codeImage.size.height}];
    
    // 定义logo的绘制参数
    CGFloat logoSide = fminf(codeImage.size.width, codeImage.size.height) / 4;
    CGFloat logoX = (codeImage.size.width - logoSide) / 2;
    CGFloat logoY = (codeImage.size.height - logoSide) / 2;
    CGRect logoRect = (CGRect){logoX, logoY, logoSide, logoSide};
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:logoRect cornerRadius:logoSide / 5];
    [cornerPath setLineWidth:2.0];
    [[UIColor whiteColor] set];
    [cornerPath stroke];
    [cornerPath addClip];
    
    // 将logo画到上下文中
    [logo drawInRect:logoRect];
    
    // 从上下文中读取image
    codeImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return codeImage;
}

@end

