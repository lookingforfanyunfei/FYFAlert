/*
 #####################################################################
 # File    : UIView+FYFExtension.h
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
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FYFExtension)

// 视图的x
@property (nonatomic, assign) CGFloat fyf_left;
// 视图的y
@property (nonatomic, assign) CGFloat fyf_top;
// 视图的x + w
@property (nonatomic, assign) CGFloat fyf_right;
// 视图的y + h
@property (nonatomic, assign) CGFloat fyf_bottom;
// 视图的w
@property (nonatomic, assign) CGFloat fyf_width;
// 视图的h
@property (nonatomic, assign) CGFloat fyf_height;
// 视图的size
@property (nonatomic, assign) CGSize  fyf_size;
// 视图的origin
@property (nonatomic, assign) CGPoint fyf_origin;
// 视图的centerX
@property (nonatomic, assign) CGFloat fyf_centerX;
// 视图的cengterY
@property (nonatomic, assign) CGFloat fyf_centerY;

@end


@interface UIView (FYFTools)

/// 获取所在控制器
@property (nonatomic, strong, readonly) UIViewController *fyf_viewController;

/// 添加手势
/// @param target 执行对象
/// @param action 方法
- (UITapGestureRecognizer *)fyf_addTapGesture:(id)target action:(SEL)action;


@end

@interface UIView (FYFSnapshot)

/// 视图截图
- (UIImage *)fyf_snapshotImage;

/// 视图截图
/// @param size 指定的size
- (UIImage *)fyf_snapshotImageWithSize:(CGSize)size;
@end


@interface UIView (FYFSubViews)

/// 找到指定类名的父类
/// @param superviewClass 要寻找父类的名字
- (nullable UIView *)fyf_superviewWithClass:(Class)superviewClass;

/// 找到指定类名的子类
/// @param subViewClass 要寻找子类的名字
- (nullable UIView *)fyf_subviewWithClass:(Class)subViewClass;

/// 删除所有子视图
- (void)fyf_removeAllSubviews;

@end


@interface UIView (FYFLayers)

/// 设置阴影
/// @param shadowColor 阴影颜色
/// @param opacity 阴影透明度
/// @param radius 阴影半径
/// @param offset 阴影偏移
/// @param cornerRadius 圆角
- (void)fyf_drawShadowWithShadowColor:(UIColor *)shadowColor
                              opacity:(CGFloat)opacity radius:(CGFloat)radius
                               offset:(CGSize)offset cornerRadius:(CGFloat)cornerRadius;

/// 对view切部分圆角
/// @param corners 切圆角部位
/// @param cornerRadius 圆角大小
- (void)fyf_cornerRect:(UIRectCorner)corners radius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
