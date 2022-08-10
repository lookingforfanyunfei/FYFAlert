//
//  UIButton+FYFExtension.h
//  FYFCategory
//
//  Created by 范云飞 on 2021/9/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (FYFExtension)

// 竖直方向上的子视图布局
/** 图片在标签之上 整体居中
 * @param padding 图片与标签的间距
 **/
- (void)fyf_setImageAboveLabelInCenterWithPadding:(CGFloat)padding;
/** 图片在标签之上
 * @param padding 图片与标签的间距
 * @param topMargin 图片与按钮顶部的间距
 **/
- (void)fyf_setImageAboveLabelWithPadding:(CGFloat)padding topMargin:(CGFloat)topMargin;
/** 图片在标签之上
 * @param padding 图片与标签的间距
 * @param bottomMargin 标签与按钮底部的间距
 **/
- (void)fyf_setImageAboveLabelWithPadding:(CGFloat)padding bottomMargin:(CGFloat)bottomMargin;

/** 图片在标签之下 整体居中
 * @param padding 图片与标签的间距
 **/
- (void)fyf_setImageUnderLabelInCenterWithPadding:(CGFloat)padding;
/** 图片在标签之下
 * @param padding 图片与标签的间距
 * @param topMargin 标签与按钮顶部的间距
 **/
- (void)fyf_setImageUnderLabelWithPadding:(CGFloat)padding topMargin:(CGFloat)topMargin;
/** 图片在标签之下
 * @param padding 图片与标签的间距
 * @param bottomMargin 图片与按钮底部的间距
 **/
- (void)fyf_setImageUnderLabelWithPadding:(CGFloat)padding bottomMargin:(CGFloat)bottomMargin;

// 水平方向上的子视图布局
/** 图片在标签之左 整体居中
 * @param padding 图片与标签的间距
 **/
- (void)fyf_setImageOnLeftOfLabelInCenterWithPadding:(CGFloat)padding;
/** 图片在标签之左
 * @param padding 图片与标签的间距
 * @param leftMargin 图片与按钮左侧的间距
 **/
- (void)fyf_setImageOnLeftOfLabelWithPadding:(CGFloat)padding leftMargin:(CGFloat)leftMargin;
/** 图片在标签之左
 * @param padding 图片与标签的间距
 * @param rightMargin 标签与按钮右侧的间距
 **/
- (void)fyf_setImageOnLeftOfLabelWithPadding:(CGFloat)padding rightMargin:(CGFloat)rightMargin;

/** 图片在标签之右 整体居中
 * @param padding 图片与标签的间距
 **/
- (void)fyf_setImageOnRightOfLabelInCenterWithPadding:(CGFloat)padding;
/** 图片在标签之右
 * @param padding 图片与标签的间距
 * @param leftMargin 标签与按钮左侧的间距
 **/
- (void)fyf_setImageOnRightOfLabelWithPadding:(CGFloat)padding leftMargin:(CGFloat)leftMargin;
/** 图片在标签之右
 * @param padding 图片与标签的间距
 * @param rightMargin 图片与按钮右侧的间距
 **/
- (void)fyf_setImageOnRightOfLabelWithPadding:(CGFloat)padding rightMargin:(CGFloat)rightMargin;


// 图上 文字下的情况下 控制图片上边距和相互间距
- (void)fyf_subviewsShownInHorizontalImageAtTopMargin:(CGFloat)topMargin
                                               padding:(CGFloat)padding;

@end


@interface UIButton (FYFForbidMultiClick)

// isClicking 为1时表示button刚刚已经被点击,不响应点击事件，其他情况表示可以响应点击事件
@property (nonatomic, strong, nullable) NSString *isClicking;

@end


@interface UIButton (FYFEnlargeArea)

- (void)fyf_setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;
- (void)fyf_setEnlargeEdge:(CGFloat)size;

@end


@interface UIButton (FYFFactory)

/// 获取UIButton
/// @param buttonType <#buttonType description#>
/// @param title <#title description#>
/// @param font <#font description#>
/// @param target <#target description#>
/// @param action <#action description#>
+ (UIButton *)fyf_createButtonWithType:(UIButtonType)buttonType title:(NSString *)title font:(UIFont *)font target:(nullable id)target action:(SEL)action;

/// 获取UIButton
/// @param buttonType <#buttonType description#>
/// @param title <#title description#>
/// @param selectedTitle <#selectedTitle description#>
/// @param font <#font description#>
/// @param target <#target description#>
/// @param action <#action description#>
+ (UIButton *)fyf_createButtonWithType:(UIButtonType)buttonType title:(NSString *)title selectedTitle:(NSString *)selectedTitle font:(UIFont *)font target:(nullable id)target action:(SEL)action;

/// 获取UIButton
/// @param buttonType <#buttonType description#>
/// @param title <#title description#>
/// @param selectedTitle <#selectedTitle description#>
/// @param font <#font description#>
/// @param titleNormalColor <#titleNormalColor description#>
/// @param titleSelectedColor <#titleSelectedColor description#>
/// @param target <#target description#>
/// @param action <#action description#>
+ (UIButton *)fyf_createButtonWithType:(UIButtonType)buttonType title:(NSString *)title selectedTitle:(NSString *)selectedTitle font:(UIFont *)font titleNormalColor:(UIColor *)titleNormalColor titleSelectedColor:(UIColor *)titleSelectedColor target:(nullable id)target action:(SEL)action;

/// 获取UIButton
/// @param buttonType <#buttonType description#>
/// @param title <#title description#>
/// @param selectedTitle <#selectedTitle description#>
/// @param font <#font description#>
/// @param titleNormalColor <#titleNormalColor description#>
/// @param titleSelectedColor <#titleSelectedColor description#>
/// @param backgroundColor <#backgroundColor description#>
/// @param target <#target description#>
/// @param action <#action description#>
+ (UIButton *)fyf_createButtonWithType:(UIButtonType)buttonType title:(NSString *)title selectedTitle:(NSString *)selectedTitle font:(UIFont *)font titleNormalColor:(UIColor *)titleNormalColor titleSelectedColor:(UIColor *)titleSelectedColor backgroundColor:(UIColor *)backgroundColor target:(nullable id)target action:(SEL)action;

/// 获取UIButton
/// @param buttonType <#buttonType description#>
/// @param title <#title description#>
/// @param selectedTitle <#selectedTitle description#>
/// @param font <#font description#>
/// @param titleNormalColor <#titleNormalColor description#>
/// @param titleSelectedColor <#titleSelectedColor description#>
/// @param backgroundColor <#backgroundColor description#>
/// @param normalImage <#normalImage description#>
/// @param selectedImage <#selectedImage description#>
/// @param target <#target description#>
/// @param action <#action description#>
+ (UIButton *)fyf_createButtonWithType:(UIButtonType)buttonType title:(NSString *)title selectedTitle:(NSString *)selectedTitle font:(UIFont *)font titleNormalColor:(UIColor *)titleNormalColor titleSelectedColor:(UIColor *)titleSelectedColor backgroundColor:(UIColor *)backgroundColor normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage target:(nullable id)target action:(SEL)action;

/// 获取UIButton的基础方法
/// @param buttonType <#buttonType description#>
/// @param title <#title description#>
/// @param selectedTitle <#selectedTitle description#>
/// @param font 默认[UIFont systemFontOfSize:14]
/// @param titleNormalColor <#titleNormalColor description#>
/// @param titleSelectedColor <#titleSelectedColor description#>
/// @param backgroundColor 默认白色
/// @param normalImage <#normalImage description#>
/// @param selectedImage <#selectedImage description#>
/// @param backgroundNormalImage <#backgroundNormalImage description#>
/// @param backgroundSelctedImage <#backgroundSelctedImage description#>
/// @param target <#target description#>
/// @param action <#action description#>
+ (UIButton *)fyf_createButtonWithType:(UIButtonType)buttonType title:(NSString *)title selectedTitle:(NSString *)selectedTitle font:(UIFont *)font titleNormalColor:(UIColor *)titleNormalColor titleSelectedColor:(UIColor *)titleSelectedColor backgroundColor:(UIColor *)backgroundColor normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage backgroundNormalImage:(UIImage *)backgroundNormalImage backgroundSelctedImage:(UIImage *)backgroundSelctedImage target:(nullable id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
