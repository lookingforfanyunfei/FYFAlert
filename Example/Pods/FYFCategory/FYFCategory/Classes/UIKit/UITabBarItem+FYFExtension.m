//
//  UITabBarItem+FYFExtension.m
//  FYFCategory
//
//  Created by 范云飞 on 2022/5/31.
//

#import "UITabBarItem+FYFExtension.h"

@implementation UITabBarItem (FYFExtension)

- (void)setTitle:(NSString *)title normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage {
    self.title = title;
    
    UIImage *normalImg = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.image = normalImg;
    UIImage *selectedImg = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.selectedImage = selectedImg;
}

@end
