//
//  CALayer+FYFExtension.h
//  FYFCategory
//
//  Created by 范云飞 on 2021/9/7.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,FYFGradientLayerDirection) {
    FYFGradientLayerDirectionHorizontal = 0,
    FYFGradientLayerDirectionVertical = 1
};

@interface CALayer (FYFExtension)

@property (nonatomic,assign) CGFloat fyf_left;
@property (nonatomic,assign) CGFloat fyf_top;
@property (nonatomic,assign) CGFloat fyf_right;
@property (nonatomic,assign) CGFloat fyf_bottom;

@property (nonatomic,assign) CGFloat fyf_width;
@property (nonatomic,assign) CGFloat fyf_height;
@property (nonatomic,assign) CGSize  fyf_size;
@property (nonatomic,assign) CGPoint fyf_origin;

@property (nonatomic,assign) CGFloat fyf_centerX;
@property (nonatomic,assign) CGFloat fyf_centerY;

- (UIImage *)fyf_snapshotImage;

/// 渐变图层，间隙等分
/// @param frame 位置大小
/// @param colors 颜色数组
/// @param direction 0:水平方向，1:垂直方向
+ (instancetype)fyf_gradientLayerWithFrame:(CGRect)frame colors:(NSArray<UIColor*> *)colors direction:(FYFGradientLayerDirection)direction;

/// 垂直渐变图层,间隙等分
+ (instancetype)fyf_verticalGradientLayerWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor;

/// 水平渐变图层,间隙等分
+ (instancetype)fyf_horizontalGradientLayerWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor;

@end

NS_ASSUME_NONNULL_END
