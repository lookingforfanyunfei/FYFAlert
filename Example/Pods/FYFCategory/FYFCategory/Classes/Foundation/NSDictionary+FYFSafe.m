//
//  NSDictionary+FYFSafe.m
//  FYFCategory
//
//  Created by 范云飞 on 2021/8/19.
//

#import "NSDictionary+FYFSafe.h"
#import "NSString+FYFExtension.h"
#import "NSObject+FYFExtension.h"
@implementation NSDictionary (FYFSafe)

//获取对象
- (NSObject *)fyf_getObjectWithKey:(NSString *)key {
    if (fyf_empty(key)) {
        return nil;
    }
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSObject class]]) {
        return (NSObject *)value;
    }
    return nil;
}

//获取字符串
- (NSString *)fyf_getStringWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return value.description;
    }
    return @"";
}

//获取Number
- (NSNumber *)fyf_getNumberWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return [NSNumber numberWithDouble:value.description.doubleValue];
    }
    return nil;
}

//获取int
- (int)fyf_getIntWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return value.description.intValue;
    }
    return 0;
}

//获取数字
- (NSInteger)fyf_getIntegerWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return value.description.integerValue;
    }
    return 0;
}

//获取Long
- (long)fyf_getLongWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return value.description.integerValue;
    }
    return 0;
}

//获取Long Long
- (long long)fyf_getLongLongWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return value.description.longLongValue;
    }
    return 0;
}

//获取float
- (float)fyf_getFloatWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return value.description.floatValue;
    }
    return 0;
}

//获取double
- (double)fyf_getDoubleWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return value.description.doubleValue;
    }
    return 0;
}

//获取Bool
- (BOOL)fyf_getBoolWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return value.description.intValue == 1;
    }
    return NO;
}


@end
