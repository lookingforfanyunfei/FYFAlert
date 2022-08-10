//
//  CALayer+FYFExtension.m
//  FYFCategory
//
//  Created by 范云飞 on 2021/9/7.
//

#import "CALayer+FYFExtension.h"
#import "FYFCommonUtil.h"

@implementation CALayer (FYFExtension)

- (CGFloat)fyf_left {
    return self.frame.origin.x;
}

- (void)setFyf_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = fyf_CGRectFlatted(frame);
}

- (CGFloat)fyf_top {
    return self.frame.origin.y;
}

- (void)setFyf_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = fyf_CGRectFlatted(frame);
}

- (CGFloat)fyf_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setFyf_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = fyf_CGRectFlatted(frame);
}

- (CGFloat)fyf_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setFyf_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = fyf_CGRectFlatted(frame);
}

- (CGFloat)fyf_centerX {
    return self.frame.origin.x + self.frame.size.width * 0.5;
}

- (void)setFyf_centerX:(CGFloat)centerX {
    CGRect frame = self.frame;
    frame.origin.x = centerX - frame.size.width * 0.5;
    self.frame = frame;
}

- (CGFloat)fyf_centerY {
    return self.frame.origin.y + self.frame.size.height * 0.5;
}

- (void)setFyf_centerY:(CGFloat)centerY {
    CGRect frame = self.frame;
    frame.origin.y = centerY - frame.size.height * 0.5;
    self.frame = frame;
}

- (CGFloat)fyf_width {
    return self.frame.size.width;
}

- (void)setFyf_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = fyf_CGRectFlatted(frame);
}

- (CGFloat)fyf_height {
    return self.frame.size.height;
}

- (void)setFyf_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = fyf_CGRectFlatted(frame);
}

- (void)setFyf_size:(CGSize)fyf_size {
    CGRect frame = self.frame;
    frame.size = fyf_size;
    self.frame = frame;
}

- (CGSize)fyf_size {
    return self.frame.size;
}

- (void)setFyf_origin:(CGPoint)fyf_origin {
    CGRect frame = self.frame;
    frame.origin = fyf_origin;
    self.frame = frame;
}

- (CGPoint)fyf_origin {
    return self.frame.origin;
}

- (UIImage *)fyf_snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (instancetype)fyf_verticalGradientLayerWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    return [self fyf_gradientLayerWithFrame:frame colors:@[startColor, endColor] direction:1];
}

+ (instancetype)fyf_horizontalGradientLayerWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    return [self fyf_gradientLayerWithFrame:frame colors:@[startColor, endColor] direction:0];
}

+ (instancetype)fyf_gradientLayerWithFrame:(CGRect)frame colors:(NSArray<UIColor*> *)colors direction:(FYFGradientLayerDirection)direction {
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = frame;
    if (colors == nil || colors.count == 0) {
        return layer;
    }
    
    if (colors.count == 1) {
        layer.locations = @[@0,@1.0];
        layer.colors = @[(__bridge id)(colors.firstObject.CGColor),(__bridge id) (colors.firstObject.CGColor)];
    } else {
        NSMutableArray *locations = [NSMutableArray array];
        NSMutableArray *layerColors = [NSMutableArray array];
        
        CGFloat dl = 1.0f / (colors.count - 1);
        for (NSUInteger idx = 0; idx < colors.count - 1; idx += 1) {
            [locations addObject:@(idx * dl)];
            
            [layerColors addObject:(__bridge id)(colors[idx].CGColor)];
        }
        [locations addObject:@(1.0)];
        [layerColors addObject:(__bridge id)(colors.lastObject.CGColor)];
        layer.locations = locations;
        layer.colors = layerColors;
    }
    
    switch (direction) {
        // 水平
        case FYFGradientLayerDirectionHorizontal:
            layer.startPoint = CGPointMake(0, 0.5);
            layer.endPoint = CGPointMake(1, 0.5);
            break;
        // 垂直
        case FYFGradientLayerDirectionVertical:
            layer.startPoint = CGPointMake(0.5, 0);
            layer.endPoint = CGPointMake(0.5, 1);
        default:
            layer.startPoint = CGPointMake(0.5, 0);
            layer.endPoint = CGPointMake(0.5, 1);
            break;
    }
    return layer;
}

@end
