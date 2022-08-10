//
//  UIBarButtonItem+FYFExtension.h
//  FYFCategory
//
//  Created by 范云飞 on 2022/6/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (FYFExtension)
/** 常用带标题的导航条按钮 (左) */
+ (instancetype)fyf_leftTitleItem:(NSString *)title target:(NSObject *)target action:(SEL)action;
/** 常用带标题颜色的导航条按钮 (左) */
+ (instancetype)fyf_leftTitleItem:(NSString *)title titleColor:(UIColor *)titleColor target:(NSObject *)target action:(SEL)action;
/** 常用带图片的导航条按钮 (左) 默认大小40*40*/
+ (instancetype)fyf_leftImageItem:(UIImage *)image target:(NSObject *)target action:(SEL)action;
/** 常用带图片的导航条按钮 (左) 设置特殊大小*/
+ (instancetype)fyf_leftImageItem:(UIImage *)image size:(CGSize)size target:(NSObject *)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
