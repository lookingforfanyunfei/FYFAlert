//
//  UITabBarItem+FYFExtension.h
//  FYFCategory
//
//  Created by 范云飞 on 2022/5/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBarItem (FYFExtension)

- (void)setTitle:(NSString *)title normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;

@end

NS_ASSUME_NONNULL_END
