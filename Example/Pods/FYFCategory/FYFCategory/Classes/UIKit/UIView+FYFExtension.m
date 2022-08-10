/*
 #####################################################################
 # File    : UIView+FYFExtension.m
 # Project : Pods
 # Created : 2021/8/24 10:16 AM
 # DevTeam : Kingstar Development Team
 # Author  : fanyunfei
 # Notes   : UIView的所有分类
 #####################################################################
 ### Change Logs   ###################################################
 #####################################################################
 ---------------------------------------------------------------------
 # Date  :
 # Author:
 # Notes :
 #
 #####################################################################
 */
#import "UIView+FYFExtension.h"
#import <objc/runtime.h>
#import "FYFCommonUtil.h"

@implementation UIView (FYFExtension)

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
    return self.center.x;
}

- (void)setFyf_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)fyf_centerY {
    return self.center.y;
}

- (void)setFyf_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)fyf_width {
    return self.frame.size.width;
}

- (void)setFyf_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = fyf_CGRectFlatted(frame);
}

- (CGFloat)Fyf_height {
    return self.frame.size.height;
}

- (void)setFyf_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = fyf_CGRectFlatted(frame);
}

- (CGSize)fyf_size {
    return self.frame.size;
}

- (void)setFyf_size:(CGSize)fyf_size {
    CGRect frame = self.frame;
    frame.size = fyf_size;
    self.frame = frame;
}

- (CGPoint)fyf_origin {
    return self.frame.origin;
}

- (void)setFyf_origin:(CGPoint)fyf_origin {
    CGRect frame = self.frame;
    frame.origin = fyf_origin;
    self.frame = frame;
}

@end

@implementation UIView (FYFTools)


- (UIViewController *)fyf_viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (UITapGestureRecognizer *)fyf_addTapGesture:(id)target action:(SEL)action {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
    tap.delegate = target;
    return tap;
}

@end

@implementation UIView (FYFSnapshot)
- (UIImage *)fyf_snapshotImage {
    return [self fyf_snapshotImageWithSize:self.bounds.size];
}

- (UIImage *)fyf_snapshotImageWithSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, self.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end


@implementation UIView (FYFSubViews)


- (UIView *)fyf_superviewWithClass:(Class)superviewClass {
    UIView *findView = self;
    
    while (nil != findView) {
        findView = [findView superview];
        if ([findView isKindOfClass:superviewClass]) {
            break;
        }
    }
    
    return findView;
}

- (UIView *)fyf_subviewWithClass:(Class)subViewClass {
    UIView *findView = nil;
    
    for(UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:subViewClass]) {
            findView = aView;
            break;
        } else {
            findView = [aView fyf_subviewWithClass:subViewClass];
            if (nil != findView) {
                break;
            }
        }
    }
    
    return findView;
}

- (void)fyf_removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}


@end


@implementation UIView (FYFLayers)

- (void)fyf_drawShadowWithShadowColor:(UIColor *)shadowColor opacity:(CGFloat)opacity
                               radius:(CGFloat)radius offset:(CGSize)offset
                         cornerRadius:(CGFloat)cornerRadius {
    // 阴影颜色
    self.layer.shadowColor = shadowColor.CGColor;
    // 阴影透明度，默认0
    self.layer.shadowOpacity = opacity;
    // 阴影半径，默认3
    self.layer.shadowRadius = radius;
    // 阴影偏移，默认(0, -3)
    self.layer.shadowOffset = offset;
    // 圆角
    self.layer.cornerRadius = cornerRadius;
}

- (void)fyf_cornerRect:(UIRectCorner)corners radius:(CGFloat)cornerRadius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
