//
//  NSArray+FYFExtension.m
//  FYFCategory
//
//  Created by 范云飞 on 2022/6/24.
//

#import "NSArray+FYFExtension.h"

@implementation NSArray (FYFExtension)

@end

@implementation NSArray (FYFValue)

/// 获取模型数组中指定属性的集合, 去重
/// @param key 模型属性
- (NSArray *)fyf_distinctUnionValueForKey:(NSString *)key {
    NSString *keyPath = [NSString stringWithFormat:@"@distinctUnionOfObjects.%@",key];
    return [self valueForKeyPath:keyPath];
}

/// 获取模型数组中指定属性的集合
/// @param key 模型属性
- (NSArray *)fyf_unionValueForKey:(NSString *)key {
    NSString *keyPath = [NSString stringWithFormat:@"@unionOfObjects.%@",key];
    return [self valueForKeyPath:keyPath];
}

/// 获取模型数组中指定属性的最大值
/// @param key 模型属性
- (CGFloat)fyf_maxValueForKey:(NSString *)key {
    NSString *keyPath = [NSString stringWithFormat:@"@max.self.%@",key];
    CGFloat max = [[self valueForKeyPath:keyPath] floatValue];
    return max;
}

/// 获取模型数组中指定属性的最小值
/// @param key 模型属性
- (CGFloat)fyf_minValueForKey:(NSString *)key {
    NSString *keyPath = [NSString stringWithFormat:@"@min.self.%@",key];
    CGFloat min = [[self valueForKeyPath:keyPath] floatValue];
    return min;
}

/// 获取数组最小值,保证数组里存储NSNumber对象
- (CGFloat)fyf_minValue {
    if (self) {
        NSMutableArray *tempArray = [self mutableCopy];
        [tempArray removeObject:@(-CGFLOAT_MAX)];
        [tempArray removeObject:@(NAN)];
        if (tempArray.count == 0) {
            return -CGFLOAT_MAX;
        }
        CGFloat min = [[tempArray valueForKeyPath:@"@min.floatValue"] floatValue];
        return min;
    }
    return 0;
}

/// 获取数组最大值,保证数组里存储NSNumber对象
- (CGFloat)fyf_maxValue {
    if (self) {
        NSMutableArray *tempArray = [self mutableCopy];
        [tempArray removeObject:@(CGFLOAT_MAX)];
        [tempArray removeObject:@(NAN)];
        if (tempArray.count == 0) {
            return CGFLOAT_MAX;
        }
        CGFloat max = [[self valueForKeyPath:@"@max.floatValue"] floatValue];
        return max;
    }
    return 0;
}


@end
