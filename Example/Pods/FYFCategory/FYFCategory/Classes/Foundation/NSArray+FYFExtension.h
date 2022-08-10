//
//  NSArray+FYFExtension.h
//  FYFCategory
//
//  Created by 范云飞 on 2022/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (FYFExtension)

@end


@interface NSArray (FYFValue)

/// 获取模型数组中指定属性的集合, 去重
/// @param key 模型属性
- (NSArray *)fyf_distinctUnionValueForKey:(NSString *)key;

/// 获取模型数组中指定属性的集合, 不去重
/// @param key 模型属性
- (NSArray *)fyf_unionValueForKey:(NSString *)key;

/// 获取模型数组中指定属性的最大值
/// @param key 模型属性
- (CGFloat)fyf_maxValueForKey:(NSString *)key;

/// 获取模型数组中指定属性的最小值
/// @param key 模型属性
- (CGFloat)fyf_minValueForKey:(NSString *)key;

/// 获取数组最小值,保证数组里存储NSNumber对象
- (CGFloat)fyf_minValue;

/// 获取数组最大值,保证数组里存储NSNumber对象
- (CGFloat)fyf_maxValue;

@end

NS_ASSUME_NONNULL_END

