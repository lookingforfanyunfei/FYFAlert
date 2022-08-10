//
//  NSMutableDictionary+FYFSafe.m
//  FYFCategory
//
//  Created by 范云飞 on 2021/8/19.
//

#import "NSMutableDictionary+FYFSafe.h"
#import "NSString+FYFExtension.h"
#import "NSObject+FYFExtension.h"
@implementation NSMutableDictionary (FYFSafe)

//NSObject添加/取值
- (void)fyf_setObject:(NSObject *)value withKey:(NSString *)key {
    if (fyf_empty(key)) {
        key = @"";
    }
    if (!value) {
        [self removeObjectForKey:key];
    } else {
        [self setObject:value forKey:key];
    }
}
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

//数据类型 添加/取值
- (void)fyf_setData:(NSData *)value withKey:(NSString *)key {
    if (fyf_empty(key)) {
        value = [NSData new];
    }
    [self fyf_setObject:value withKey:key];
}
- (NSData *)fyf_getDataWithKey:(NSString *)key {
    if (fyf_empty(key)) {
        return nil;
    }
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSData class]]) {
        return (NSData *)value;
    }
    
    return nil;
}

//字符串类型 添加/取值
- (void)fyf_setString:(NSString *)value withKey:(NSString *)key {
    if (fyf_empty(key)) {
        value = @"";
    }
    [self fyf_setObject:value withKey:key];
}

- (NSString *)fyf_getStringWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return value.description;
    }
    return @"";
}

//数字类型 添加/取值
- (void)fyf_setNumber:(NSNumber *)value withKey:(NSString *)key {
    [self fyf_setObject:value withKey:key];
}
- (NSNumber *)fyf_getNumberWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return [NSNumber numberWithDouble:value.description.doubleValue];
    }
    return nil;
}

//int类型 添加/取值
- (void)fyf_setInt:(int)value withKey:(NSString *)key {
    [self fyf_setObject:[NSNumber numberWithInt:value] withKey:key];
}
- (int)fyf_getIntWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return value.description.intValue;
    }
    return 0;
}

//Float类型 添加/取值
- (void)fyf_setFloat:(float)value withKey:(NSString *)key {
    [self fyf_setObject:[NSNumber numberWithDouble:value] withKey:key];
}
- (float)fyf_GetFloatWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return value.description.floatValue;
    }
    return 0;
}

//Long类型 添加/取值
- (void)fyf_setLong:(long)value withKey:(NSString *)key {
    [self fyf_setObject:[NSNumber numberWithLong:value] withKey:key];
}
- (long)fyf_GetLongWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return value.description.integerValue;
    }
    return 0;
}

//LongLong类型 添加/取值
- (void)fyf_setLongLong:(long long)value withKey:(NSString *)key {
    [self fyf_setObject:[NSNumber numberWithLongLong:value] withKey:key];
}
- (long long)fyf_GetLongLongWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return value.description.longLongValue;
    }
    return 0;
}

//double类型 添加/取值
- (void)fyf_setDouble:(double)value withKey:(NSString *)key {
    [self fyf_setObject:[NSNumber numberWithDouble:value] withKey:key];
}
- (double)fyf_GetDoubleWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return value.description.doubleValue;
    }
    return 0;
    
}

//Integer类型 添加/取值
- (void)fyf_setInteger:(NSInteger)value withKey:(NSString *)key {
    [self fyf_setObject:[NSNumber numberWithInteger:value] withKey:key];
}
- (NSInteger)fyf_GetIntegerWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return value.description.integerValue;
    }
    return 0;
}

//Bool类型 添加/取值
- (void)fyf_setBool:(BOOL)value withKey:(NSString *)key {
    [self fyf_setObject:[NSNumber numberWithBool:value] withKey:key];
}
- (BOOL)fyf_GetBoolWithKey:(NSString *)key {
    NSObject *value = [self fyf_getObjectWithKey:key];
    if (value) {
        return (value.description.intValue == 1);
    }
    return NO;
}


@end
