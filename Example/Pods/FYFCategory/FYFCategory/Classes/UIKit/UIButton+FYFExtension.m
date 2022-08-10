//
//  UIButton+FYFExtension.m
//  FYFCategory
//
//  Created by 范云飞 on 2021/9/7.
//

#import "UIButton+FYFExtension.h"
#import <objc/runtime.h>

@implementation UIButton (FYFExtension)

/** 图片在标签之上 整体居中 */
- (void)fyf_setImageAboveLabelInCenterWithPadding:(CGFloat)padding {
    [self fyf_subviewsShownInHorizontalImageAtTop:YES topMargin:0.0 bottomMargin:0.0 padding:padding];
}
/** 图片在标签之上 */
- (void)fyf_setImageAboveLabelWithPadding:(CGFloat)padding topMargin:(CGFloat)topMargin {
    [self fyf_subviewsShownInHorizontalImageAtTop:YES topMargin:topMargin bottomMargin:0.0 padding:padding];
}
/** 图片在标签之上 */
- (void)fyf_setImageAboveLabelWithPadding:(CGFloat)padding bottomMargin:(CGFloat)bottomMargin {
    [self fyf_subviewsShownInHorizontalImageAtTop:YES topMargin:0.0 bottomMargin:bottomMargin padding:padding];
}

/** 图片在标签之下 整体居中 */
- (void)fyf_setImageUnderLabelInCenterWithPadding:(CGFloat)padding {
    [self fyf_subviewsShownInHorizontalImageAtTop:NO topMargin:0.0 bottomMargin:0.0 padding:padding];
}
/** 图片在标签之下 */
- (void)fyf_setImageUnderLabelWithPadding:(CGFloat)padding topMargin:(CGFloat)topMargin {
    [self fyf_subviewsShownInHorizontalImageAtTop:NO topMargin:topMargin bottomMargin:0.0 padding:padding];
}
/** 图片在标签之下 */
- (void)fyf_setImageUnderLabelWithPadding:(CGFloat)padding bottomMargin:(CGFloat)bottomMargin {
    [self fyf_subviewsShownInHorizontalImageAtTop:NO topMargin:0.0 bottomMargin:bottomMargin padding:padding];
}

/** 图片在标签之左 整体居中 */
- (void)fyf_setImageOnLeftOfLabelInCenterWithPadding:(CGFloat)padding {
    [self fyf_subviewsShownInVerticalImageOnLeft:YES leftMargin:0.0 rightMargin:0.0 padding:padding];
}
/** 图片在标签之左 */
- (void)fyf_setImageOnLeftOfLabelWithPadding:(CGFloat)padding leftMargin:(CGFloat)leftMargin {
    [self fyf_subviewsShownInVerticalImageOnLeft:YES leftMargin:leftMargin rightMargin:0.0 padding:padding];
}
/** 图片在标签之左 */
- (void)fyf_setImageOnLeftOfLabelWithPadding:(CGFloat)padding rightMargin:(CGFloat)rightMargin {
    [self fyf_subviewsShownInVerticalImageOnLeft:YES leftMargin:0.0 rightMargin:rightMargin padding:padding];
}

/** 图片在标签之右 整体居中 */
- (void)fyf_setImageOnRightOfLabelInCenterWithPadding:(CGFloat)padding {
    [self fyf_subviewsShownInVerticalImageOnLeft:NO leftMargin:0.0 rightMargin:0.0 padding:padding];
}
/** 图片在标签之右 */
- (void)fyf_setImageOnRightOfLabelWithPadding:(CGFloat)padding leftMargin:(CGFloat)leftMargin {
    [self fyf_subviewsShownInVerticalImageOnLeft:NO leftMargin:leftMargin rightMargin:0.0 padding:padding];
}
/** 图片在标签之右 */
- (void)fyf_setImageOnRightOfLabelWithPadding:(CGFloat)padding rightMargin:(CGFloat)rightMargin {
    [self fyf_subviewsShownInVerticalImageOnLeft:NO leftMargin:0.0 rightMargin:rightMargin padding:padding];
}

/** 垂直方向上布局按钮的子视图 各子视图水平方向居中
 * @param atTop 图片是否在顶部
 * @param topMargin 按钮顶部最上面的子视图与按钮顶部的间距 与bottomMargin同时传0.0表示整体居中
 * @param bottomMargin 按钮顶部最下面的子视图与按钮底部的间距 与topMargin同时传0.0表示整体居中
 * @param padding 图片与标签的间距
 **/
- (void)fyf_subviewsShownInHorizontalImageAtTop:(BOOL)atTop
                                       topMargin:(CGFloat)topMargin
                                    bottomMargin:(CGFloat)bottomMargin
                                         padding:(CGFloat)padding {
    self.contentEdgeInsets = UIEdgeInsetsZero;
    self.imageEdgeInsets = UIEdgeInsetsZero;
    self.titleEdgeInsets = UIEdgeInsetsZero;
    
    [self.titleLabel sizeToFit];
    [self.imageView sizeToFit];
    
    CGRect titleRect = [self titleRectForContentRect:self.bounds];
    CGRect imageRect = [self imageRectForContentRect:self.bounds];
    if (CGRectEqualToRect(CGRectZero, titleRect) || CGRectEqualToRect(CGRectZero, imageRect)) {
        padding = 0.0;
    }
    
    CGFloat edgeTop = 0.0;
    CGFloat edgeLeft = 0.0;
    CGFloat edgeBottom = 0.0;
    CGFloat edgeRight = 0.0;
    // 计算图片对应位置的偏移量
    if (atTop) {// 图片在上 文字在下
        if (topMargin > 0.0 || bottomMargin > 0.0) {
            edgeTop = (topMargin > 0.0 ? topMargin : self.frame.size.height - bottomMargin - titleRect.size.height - padding - imageRect.size.height) - imageRect.origin.y;
        } else {
            edgeTop = (self.frame.size.height - imageRect.size.height - padding - titleRect.size.height) / 2 - imageRect.origin.y;
        }
    } else {// 图片在下 文字在上
        if (topMargin > 0.0 || bottomMargin > 0.0) {
            edgeTop = (topMargin > 0.0 ? topMargin + titleRect.size.height + padding : self.frame.size.height - bottomMargin - imageRect.size.height) - imageRect.origin.y;
        } else {
            edgeTop = (self.frame.size.height - imageRect.size.height + titleRect.size.height + padding) / 2 - imageRect.origin.y;
        }
    }
    edgeLeft = (self.frame.size.width - imageRect.size.width) / 2 - imageRect.origin.x;
    edgeBottom = -(edgeTop);
    edgeRight = -(edgeLeft);
    self.imageEdgeInsets = UIEdgeInsetsMake(edgeTop, edgeLeft, edgeBottom, edgeRight);
    // 计算文字对应位置的偏移量
    if (atTop) {
        if (topMargin > 0.0 || bottomMargin > 0.0) {
            edgeTop = (topMargin > 0.0 ? topMargin + imageRect.size.height + padding : self.frame.size.height - bottomMargin - titleRect.size.height) - titleRect.origin.y;
        } else {
            edgeTop = (self.frame.size.height + imageRect.size.height - titleRect.size.height + padding) / 2 - titleRect.origin.y;
        }
    } else {
        if (topMargin > 0.0 || bottomMargin > 0.0) {
            edgeTop = (topMargin > 0.0 ? topMargin : self.frame.size.height - bottomMargin - imageRect.size.height - padding - titleRect.size.height) - titleRect.origin.y;
        } else {
            edgeTop = (self.frame.size.height - titleRect.size.height - padding - imageRect.size.height) / 2 - titleRect.origin.y;
        }
    }
    edgeLeft = (self.frame.size.width - titleRect.size.width) / 2 - titleRect.origin.x;
    edgeBottom = -(edgeTop);
    edgeRight = -(edgeLeft);
    self.titleEdgeInsets = UIEdgeInsetsMake(edgeTop, edgeLeft, edgeBottom, edgeRight);
}

/** 水平方向上布局按钮的子视图 各子视图垂直方向居中
 * @param onLeft 图片是否在左侧
 * @param leftMargin 按钮左侧最近的子视图与按钮左侧的间距 与rightMargin同时传0.0表示整体居中
 * @param rightMargin 按钮右侧最近的子视图与按钮右侧的间距 与leftMargin同时传0.0表示整体居中
 * @param padding 图片与标签的间距
 **/
- (void)fyf_subviewsShownInVerticalImageOnLeft:(BOOL)onLeft
                                     leftMargin:(CGFloat)leftMargin
                                    rightMargin:(CGFloat)rightMargin
                                        padding:(CGFloat)padding {
    self.contentEdgeInsets = UIEdgeInsetsZero;
    self.imageEdgeInsets = UIEdgeInsetsZero;
    self.titleEdgeInsets = UIEdgeInsetsZero;
    
    [self.titleLabel sizeToFit];
    [self.imageView sizeToFit];
    
    CGRect titleRect = [self titleRectForContentRect:self.bounds];
    CGRect imageRect = [self imageRectForContentRect:self.bounds];
    if (CGRectEqualToRect(CGRectZero, titleRect) || CGRectEqualToRect(CGRectZero, imageRect)) {
        padding = 0.0;
    }
    
    CGFloat edgeTop = 0.0;
    CGFloat edgeLeft = 0.0;
    CGFloat edgeBottom = 0.0;
    CGFloat edgeRight = 0.0;
    // 计算图片对应位置的偏移量
    if (onLeft) {// 图片在左 文字在右
        if (leftMargin > 0.0 || rightMargin > 0.0) {
            edgeLeft = (leftMargin > 0.0 ? leftMargin : self.frame.size.width - rightMargin - titleRect.size.width - padding - imageRect.size.width) - imageRect.origin.x;
        } else {
            edgeLeft = (self.frame.size.width - imageRect.size.width - padding - titleRect.size.width) / 2 - imageRect.origin.x;
        }
    } else {// 图片在右 文字在左
        if (leftMargin > 0.0 || rightMargin > 0.0) {
            edgeLeft = (leftMargin > 0.0 ? leftMargin + titleRect.size.width + padding : self.frame.size.width - rightMargin - imageRect.size.width) - imageRect.origin.x;
        } else {
            edgeLeft = (self.frame.size.width - imageRect.size.width + titleRect.size.width + padding) / 2 - imageRect.origin.x;
        }
    }
    edgeTop = (self.frame.size.height - imageRect.size.height) / 2 - imageRect.origin.y;
    edgeBottom = -(edgeTop);
    edgeRight = -(edgeLeft);
    self.imageEdgeInsets = UIEdgeInsetsMake(edgeTop, edgeLeft, edgeBottom, edgeRight);
    // 计算文字对应位置的偏移量
    if (onLeft) {
        if (leftMargin > 0.0 || rightMargin > 0.0) {
            edgeLeft = (leftMargin > 0.0 ? leftMargin + imageRect.size.width + padding : self.frame.size.width - rightMargin - titleRect.size.width) - titleRect.origin.x;
        } else {
            edgeLeft = (self.frame.size.width - titleRect.size.width + padding + imageRect.size.width) / 2 - titleRect.origin.x;
        }
    } else {
        if (leftMargin > 0.0 || rightMargin > 0.0) {
            edgeLeft = (leftMargin > 0.0 ? leftMargin : self.frame.size.width - rightMargin - imageRect.size.width - padding - titleRect.size.width) - titleRect.origin.x;
        } else {
            edgeLeft = (self.frame.size.width - titleRect.size.width - padding - imageRect.size.width) / 2 - titleRect.origin.x;
        }
    }
    edgeTop = (self.frame.size.height - titleRect.size.height) / 2 - titleRect.origin.y;
    edgeBottom = -(edgeTop);
    edgeRight = -(edgeLeft);
    self.titleEdgeInsets = UIEdgeInsetsMake(edgeTop, edgeLeft, edgeBottom, edgeRight);
}


- (void)fyf_subviewsShownInHorizontalImageAtTopMargin:(CGFloat)topMargin
                                               padding:(CGFloat)padding {
    self.contentEdgeInsets = UIEdgeInsetsZero;
    self.imageEdgeInsets = UIEdgeInsetsZero;
    self.titleEdgeInsets = UIEdgeInsetsZero;
    
    CGRect titleRect = [self titleRectForContentRect:self.bounds];
    CGRect imageRect = [self imageRectForContentRect:self.bounds];
    
    if (CGRectEqualToRect(CGRectZero, titleRect) || CGRectEqualToRect(CGRectZero, imageRect)) {
        padding = 0.0;
    }
    
    CGFloat edgeTop = 0.0;
    CGFloat edgeLeft = 0.0;
    CGFloat edgeBottom = 0.0;
    CGFloat edgeRight = 0.0;
    // 计算图片对应位置的偏移量
    
    edgeTop = topMargin - imageRect.origin.y;
    edgeLeft = (self.frame.size.width - imageRect.size.width) / 2 - imageRect.origin.x;
    edgeRight = -(edgeLeft);
    edgeBottom = -(edgeTop);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(edgeTop, edgeLeft, edgeBottom, edgeRight);
    
    edgeTop = topMargin + imageRect.size.height + padding - titleRect.origin.y;
    
    edgeLeft = (self.frame.size.width - titleRect.size.width) / 2 - titleRect.origin.x;
    edgeBottom = -(edgeTop);
    edgeRight = -(edgeLeft);
    self.titleEdgeInsets = UIEdgeInsetsMake(edgeTop, edgeLeft, edgeBottom, edgeRight);
}

@end

@implementation UIButton (FYFForbidMultiClick)


@dynamic isClicking;

static void * isClickKey = (void *)@"isClickKey";

- (NSString *)isClicking {
    return objc_getAssociatedObject(self, isClickKey);
}

- (void)setIsClicking:(NSString *)isClicking {
    objc_setAssociatedObject(self, isClickKey, isClicking, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    // reason: 添加对当前button的window是不是应用window的判断，在越狱手机上如果使用搜狗输入法时,
    //         快速点击‘退格’按钮会造成函数返回NO，造成输入框内的内容自动的全部删除,所以添加此判断
    //         规避该问题,暂时未想到更好的办法来同时解决输入法与按钮多次点击的更好方法。
    if(self.window != [self getWindow]){
        return YES;
    }
    if(![self.isClicking isEqualToString:@"1"]){
        [self performSelector:@selector(activeButton) withObject:nil afterDelay:1.0];
        self.isClicking = @"1";
        return YES;
        
    }else {
        return NO;
    }
}

- (UIWindow *)getWindow {
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        if (![window isKindOfClass:[UIWindow class]]) {
            continue;
        }
        
        if (window.windowLevel == UIWindowLevelNormal) {
            return window;
        }
    }
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window != nil) {
        return window;
    }
    
    id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    if ([delegate respondsToSelector:@selector(window)] || [delegate respondsToSelector:@selector(getWindow)]) {
        window = delegate.window;
        if (nil != window) {
            return window;
        }
    }
    
    return [[UIApplication sharedApplication] keyWindow];
}



/// 1s后将isclicking设置为非‘1’，以便按钮可以响应事件
- (void)activeButton {
    self.isClicking = nil;
}


@end


@implementation UIButton (FYFEnlargeArea)

static char fyfTopNameKey;
static char fyfRightNameKey;
static char fyfBottomNameKey;
static char fyfLeftNameKey;

- (void)fyf_setEnlargeEdge:(CGFloat)size {
    objc_setAssociatedObject(self, &fyfTopNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &fyfRightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &fyfBottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &fyfLeftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
 
- (void)fyf_setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {
    objc_setAssociatedObject(self, &fyfTopNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &fyfRightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &fyfBottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &fyfLeftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
 
- (CGRect)enlargedRect {
    NSNumber* topEdge = objc_getAssociatedObject(self, &fyfTopNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &fyfRightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &fyfBottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &fyfLeftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    } else {
        return self.bounds;
    }
}
 
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event {
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}
@end


@implementation UIButton (FYFFactory)
/// 获取UIButton
/// @param buttonType <#buttonType description#>
/// @param title <#title description#>
/// @param font <#font description#>
/// @param target <#target description#>
/// @param action <#action description#>
+ (UIButton *)fyf_createButtonWithType:(UIButtonType)buttonType title:(NSString *)title font:(UIFont *)font target:(nullable id)target action:(SEL)action {
    return [self fyf_createButtonWithType:buttonType title:title selectedTitle:nil font:font titleNormalColor:nil titleSelectedColor:nil backgroundColor:nil normalImage:nil selectedImage:nil backgroundNormalImage:nil backgroundSelctedImage:nil target:target action:action];
}

/// 获取UIButton
/// @param buttonType <#buttonType description#>
/// @param title <#title description#>
/// @param selectedTitle <#selectedTitle description#>
/// @param font <#font description#>
/// @param target <#target description#>
/// @param action <#action description#>
+ (UIButton *)fyf_createButtonWithType:(UIButtonType)buttonType title:(NSString *)title selectedTitle:(NSString *)selectedTitle font:(UIFont *)font target:(nullable id)target action:(SEL)action {
    return [self fyf_createButtonWithType:buttonType title:title selectedTitle:selectedTitle font:font titleNormalColor:nil titleSelectedColor:nil backgroundColor:nil normalImage:nil selectedImage:nil backgroundNormalImage:nil backgroundSelctedImage:nil target:target action:action];
}

/// 获取UIButton
/// @param buttonType <#buttonType description#>
/// @param title <#title description#>
/// @param selectedTitle <#selectedTitle description#>
/// @param font <#font description#>
/// @param titleNormalColor <#titleNormalColor description#>
/// @param titleSelectedColor <#titleSelectedColor description#>
/// @param target <#target description#>
/// @param action <#action description#>
+ (UIButton *)fyf_createButtonWithType:(UIButtonType)buttonType title:(NSString *)title selectedTitle:(NSString *)selectedTitle font:(UIFont *)font titleNormalColor:(UIColor *)titleNormalColor titleSelectedColor:(UIColor *)titleSelectedColor target:(nullable id)target action:(SEL)action {
    return [self fyf_createButtonWithType:buttonType title:title selectedTitle:selectedTitle font:font titleNormalColor:titleNormalColor titleSelectedColor:titleSelectedColor backgroundColor:nil normalImage:nil selectedImage:nil backgroundNormalImage:nil backgroundSelctedImage:nil target:target action:action];
}

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
+ (UIButton *)fyf_createButtonWithType:(UIButtonType)buttonType title:(NSString *)title selectedTitle:(NSString *)selectedTitle font:(UIFont *)font titleNormalColor:(UIColor *)titleNormalColor titleSelectedColor:(UIColor *)titleSelectedColor backgroundColor:(UIColor *)backgroundColor target:(nullable id)target action:(SEL)action {
    return [self fyf_createButtonWithType:buttonType title:title selectedTitle:selectedTitle font:font titleNormalColor:titleNormalColor titleSelectedColor:titleSelectedColor backgroundColor:backgroundColor normalImage:nil selectedImage:nil backgroundNormalImage:nil backgroundSelctedImage:nil target:target action:action];
}

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
+ (UIButton *)fyf_createButtonWithType:(UIButtonType)buttonType title:(NSString *)title selectedTitle:(NSString *)selectedTitle font:(UIFont *)font titleNormalColor:(UIColor *)titleNormalColor titleSelectedColor:(UIColor *)titleSelectedColor backgroundColor:(UIColor *)backgroundColor normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage target:(nullable id)target action:(SEL)action {
    return [self fyf_createButtonWithType:buttonType title:title selectedTitle:selectedTitle font:font titleNormalColor:titleNormalColor titleSelectedColor:titleSelectedColor backgroundColor:backgroundColor normalImage:normalImage selectedImage:selectedImage backgroundNormalImage:nil backgroundSelctedImage:nil target:target action:action];
}

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
+ (UIButton *)fyf_createButtonWithType:(UIButtonType)buttonType title:(NSString *)title selectedTitle:(NSString *)selectedTitle font:(UIFont *)font titleNormalColor:(UIColor *)titleNormalColor titleSelectedColor:(UIColor *)titleSelectedColor backgroundColor:(UIColor *)backgroundColor normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage backgroundNormalImage:(UIImage *)backgroundNormalImage backgroundSelctedImage:(UIImage *)backgroundSelctedImage target:(nullable id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:buttonType];
    if (title.length) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (selectedTitle.length) {
        [button setTitle:selectedTitle forState:UIControlStateSelected];
    }
    if (font) {
        button.titleLabel.font = font;
    } else {
        button.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    if (titleNormalColor) {
        [button setTitleColor:titleNormalColor forState:UIControlStateNormal];
    }
    if (titleSelectedColor) {
        [button setTitleColor:titleSelectedColor forState:UIControlStateSelected];
    }
    if (backgroundColor) {
        [button setBackgroundColor:backgroundColor];
    } else {
        [button setBackgroundColor:[UIColor whiteColor]];
    }
    if (normalImage) {
        [button setImage:normalImage forState:UIControlStateNormal];
    }
    if (selectedImage) {
        [button setImage:selectedImage forState:UIControlStateSelected];
    }
    if (backgroundNormalImage) {
        [button setBackgroundImage:backgroundNormalImage forState:UIControlStateNormal];
    }
    if (backgroundSelctedImage) {
        [button setBackgroundImage:backgroundSelctedImage forState:UIControlStateSelected];
    } 
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
