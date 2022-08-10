//
//  NSMutableDictionary+FYFSafe.h
//  FYFCategory
//
//  Created by 范云飞 on 2021/8/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (FYFSafe)

//NSObject添加/取值
- (void)fyf_setObject:(NSObject *)value withKey:(NSString *)key;
- (NSObject *)fyf_getObjectWithKey:(NSString *)key;

//数据类型 添加/取值
- (void)fyf_setData:(NSData *)value withKey:(NSString *)key;
- (NSData *)fyf_getDataWithKey:(NSString *)key;

//字符串类型 添加/取值
- (void)fyf_setString:(NSString *)value withKey:(NSString *)key;
- (NSString *)fyf_getStringWithKey:(NSString *)key;

//数字类型 添加/取值
- (void)fyf_setNumber:(NSNumber *)value withKey:(NSString *)key;
- (NSNumber *)fyf_getNumberWithKey:(NSString *)key;

//int类型 添加/取值
- (void)fyf_setInt:(int)value withKey:(NSString *)key;
- (int)fyf_getIntWithKey:(NSString *)key;

//Float类型 添加/取值
- (void)fyf_setFloat:(float)value withKey:(NSString *)key;
- (float)fyf_getFloatWithKey:(NSString *)key;

//Long类型 添加/取值
- (void)fyf_setLong:(long)value withKey:(NSString *)key;
- (long)fyf_getLongWithKey:(NSString *)key;

//LongLong类型 添加/取值
- (void)fyf_setLongLong:(long long)value withKey:(NSString *)key;
- (long long)fyf_getLongLongWithKey:(NSString *)key;

//double类型 添加/取值
- (void)fyf_setDouble:(double)value withKey:(NSString *)key;
- (double)fyf_getDoubleWithKey:(NSString *)key;

//Integer类型 添加/取值
- (void)fyf_setInteger:(NSInteger)value withKey:(NSString *)key;
- (NSInteger)fyf_getIntegerWithKey:(NSString *)key;

//Bool类型 添加/取值
- (void)fyf_setBool:(BOOL)value withKey:(NSString *)key;
- (BOOL)fyf_getBoolWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
