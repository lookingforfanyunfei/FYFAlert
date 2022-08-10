/*
 #####################################################################
 # File    : FYFCommonUtil.h
 # Project : Pods
 # Created : 2021/8/24 10:16 AM
 # DevTeam : Kingstar Development Team
 # Author  : fanyunfei
 # Notes   : 像素点的规范化
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
#ifndef FYFCommonUtil_h
#define FYFCommonUtil_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#pragma mark - CGFloat

/**
 *  某些地方可能会将 CGFLOAT_MIN 作为一个数值参与计算（但其实 CGFLOAT_MIN 更应该被视为一个标志位而不是数值），可能导致一些精度问题，所以提供这个方法快速将 CGFLOAT_MIN 转换为 0
 *  issue: https://github.com/Tencent/QMUI_iOS/issues/203
 */
CG_INLINE CGFloat
fyf_removeFloatMin(CGFloat floatValue) {
    return floatValue == CGFLOAT_MIN ? 0 : floatValue;
}

/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */
CG_INLINE CGFloat
fyf_flatSpecificScale(CGFloat floatValue, CGFloat scale) {
    floatValue = fyf_removeFloatMin(floatValue);
    scale = scale ?: [[UIScreen mainScreen] scale];
    CGFloat flattedValue = ceil(floatValue * scale) / scale;
    return flattedValue;
}

/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flat() 函数，而应该用 flatSpecificScale
 */
CG_INLINE CGFloat
fyf_flat(CGFloat floatValue) {
    return fyf_flatSpecificScale(floatValue, 0);
}

/// 将一个 CGSize 像素对齐
CG_INLINE CGSize
fyf_CGSizeFlatted(CGSize size) {
    return CGSizeMake(fyf_flat(size.width), fyf_flat(size.height));
}

/// 对CGRect的x/y、width/height都调用一次flat，以保证像素对齐
CG_INLINE CGRect
fyf_CGRectFlatted(CGRect rect) {
    return CGRectMake(fyf_flat(rect.origin.x), fyf_flat(rect.origin.y), fyf_flat(rect.size.width), fyf_flat(rect.size.height));
}

#endif /* FYFCommonUtil_h */
