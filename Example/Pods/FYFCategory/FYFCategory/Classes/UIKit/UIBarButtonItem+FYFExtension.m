//
//  UIBarButtonItem+FYFExtension.m
//  FYFCategory
//
//  Created by 范云飞 on 2022/6/7.
//

#import "UIBarButtonItem+FYFExtension.h"
#import "UIView+FYFExtension.h"
#import "NSString+FYFExtension.h"

@implementation UIBarButtonItem (FYFExtension)

+ (UIBarButtonItem *)fyf_spacer:(CGFloat)width {
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = width;
    return space;
}

/** 常用带标题的导航条按钮 */
+ (UIButton *)fyf_titleButton:(NSString *)title target:(NSObject *)target action:(SEL)action {
    return [UIBarButtonItem fyf_titleButton:title font:nil target:target action:action];
}

+ (UIButton *)fyf_titleButton:(NSString *)title font:(UIFont *)titleFont target:(NSObject *)target action:(SEL)action{
    UIFont *font = [UIFont systemFontOfSize:16];
    if (titleFont) {
        font = titleFont;
    }
    CGFloat width = [title fyf_sizeWithFont:font].width + 10;
    UIButton *titleBtn = [[UIButton alloc] init];
    titleBtn.frame = CGRectMake(0, 0, width, 20);
    titleBtn.titleLabel.font = font;
    titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    titleBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [titleBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [titleBtn setTitle:title forState:UIControlStateNormal];
    return titleBtn;

}


/** 常用带标题的导航条 图片按钮 */
+ (UIButton *)fyf_imageButton:(UIImage *)image size:(CGSize)size target:(NSObject *)target action:(SEL)action {
    UIButton *imageBtn = [[UIButton alloc] init];
    imageBtn.frame = CGRectMake(0, 0, 40, 40);
    if (size.height > 0) {
        imageBtn.fyf_size = size;
    }
    [imageBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -15)];
    [imageBtn setImage:image forState:UIControlStateNormal];
    [imageBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return imageBtn;
}
/** 常用带标题的导航条 图片按钮  不带偏移*/
+ (UIButton *)fyf_imageNewButton:(UIImage *)image size:(CGSize)size target:(NSObject *)target action:(SEL)action {
    UIButton *imageBtn = [[UIButton alloc] init];
    imageBtn.frame = CGRectMake(0, 0, 40, 40);
    if (size.height > 0) {
        imageBtn.fyf_size = size;
    }
    [imageBtn setImage:image forState:UIControlStateNormal];
    [imageBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return imageBtn;
}
/** 常用带标题的导航条按钮 (左) */
+ (instancetype)fyf_leftTitleItem:(NSString *)title target:(NSObject *)target action:(SEL)action {
    UIButton *titleBtn = [UIBarButtonItem fyf_titleButton:title target:target action:action];
    titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    return [[UIBarButtonItem alloc] initWithCustomView:titleBtn];
}
/** 常用带标题颜色的导航条按钮 (左) */
+ (instancetype)fyf_leftTitleItem:(NSString *)title titleColor:(UIColor *)titleColor target:(NSObject *)target action:(SEL)action {
    UIButton *titleBtn = [UIBarButtonItem fyf_titleButton:title target:target action:action];
    [titleBtn setTitleColor:titleColor forState:UIControlStateNormal];
    titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    return [[UIBarButtonItem alloc] initWithCustomView:titleBtn];
}
/** 常用带图片的导航条按钮 (左) */
+ (instancetype)fyf_leftImageItem:(UIImage *)image target:(NSObject *)target action:(SEL)action{
    UIButton *imageBtn = [UIBarButtonItem fyf_imageButton:image size:CGSizeMake(40, 40) target:target action:action];
    [imageBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    return [[UIBarButtonItem alloc] initWithCustomView:imageBtn];
}
/** 常用带图片的导航条按钮 (左) */
+ (instancetype)fyf_leftImageItem:(UIImage *)image size:(CGSize)size target:(NSObject *)target action:(SEL)action{
    UIButton *imageBtn = [UIBarButtonItem fyf_imageButton:image size:size target:target action:action];
    return [[UIBarButtonItem alloc] initWithCustomView:imageBtn];
}


@end
