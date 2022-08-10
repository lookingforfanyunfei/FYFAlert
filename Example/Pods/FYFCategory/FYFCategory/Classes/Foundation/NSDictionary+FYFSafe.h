//
//  NSDictionary+FYFSafe.h
//  FYFCategory
//
//  Created by 范云飞 on 2021/8/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (FYFSafe)

//获取对象
- (NSObject *)fyf_getObjectWithKey:(NSString *)key;

//获取字符串
- (NSString *)fyf_getStringWithKey:(NSString *)key;

//获取Number
- (NSNumber *)fyf_getNumberWithKey:(NSString *)key;

//获取int
- (int)fyf_getIntWithKey:(NSString *)key;

//获取数字
- (NSInteger)fyf_getIntegerWithKey:(NSString *)key;

//获取Long
- (long)fyf_getLongWithKey:(NSString *)key;

//获取Long Long
- (long long)fyf_getLongLongWithKey:(NSString *)key;

//获取float
- (float)fyf_getFloatWithKey:(NSString *)key;

//获取double
- (double)fyf_getDoubleWithKey:(NSString *)key;

//获取Bool
- (BOOL)fyf_getBoolWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
