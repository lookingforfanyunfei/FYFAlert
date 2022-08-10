//
//  UIScreen+FYFExtension.h
//  FYFCategory
//
//  Created by 范云飞 on 2021/9/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (FYFExtension)

@property (nonatomic, class , readonly) CGFloat fyf_screenWidth;
@property (nonatomic, class , readonly) CGFloat fyf_screenHeight;
@property (nonatomic, class , readonly) CGFloat fyf_screenScale;

@end

NS_ASSUME_NONNULL_END
