//
//  UIScreen+FYFExtension.m
//  FYFCategory
//
//  Created by 范云飞 on 2021/9/7.
//

#import "UIScreen+FYFExtension.h"

@implementation UIScreen (FYFExtension)

+ (CGFloat)fyf_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)fyf_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)fyf_screenScale {
    return [UIScreen mainScreen].scale;
}

@end
