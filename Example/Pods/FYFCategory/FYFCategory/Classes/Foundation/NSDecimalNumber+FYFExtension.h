//
//  NSDecimalNumber+FYFExtension.h
//  FYFCategory
//
//  Created by 范云飞 on 2021/8/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDecimalNumber (FYFExtension)

#pragma mark - init
// 2位精度float
+ (NSDecimalNumber *)fyf_decimalNumberWithFloat:(float)value;
// N位精度float
+ (NSDecimalNumber *)fyf_decimalNumberWithFloat:(float)value scale:(short)scale;
// N位精度float 进位原则
+ (NSDecimalNumber *)fyf_decimalNumberWithFloat:(float)value roundingMode:(NSRoundingMode)roundingMode scale:(short)scale;
//2位精度double
+ (NSDecimalNumber *)fyf_decimalNumberWithDouble:(double)value;
// N位精度double
+ (NSDecimalNumber *)fyf_decimalNumberWithDouble:(double)value scale:(short)scale;
//N位精度double 进位原则
+ (NSDecimalNumber *)fyf_decimalNumberWithDouble:(double)value roundingMode:(NSRoundingMode)roundingMode scale:(short)scale;

#pragma mark - nsstring
// 保留两位小数点的数字转字符串
+ (NSString *)fyf_formatterNumber:(NSNumber *)number;
// 任意精度的数字转字符串
+ (NSString *)fyf_formatterNumber:(NSNumber *)number fractionDigits:(NSUInteger)fractionDigits;
// 2位小数精度的数字转double
+ (double)fyf_doubleNumber:(NSNumber *)number;
// N位小数精度的数字转double
+ (double)fyf_doubleNumber:(NSNumber *)number fractionDigits:(NSUInteger)fractionDigits;
// 2位小数精度的数字转float
+ (float)fyf_floatNumber:(NSNumber *)number;
// N位小数精度的数字转float
+ (float)fyf_floatNumber:(NSNumber *)number fractionDigits:(NSUInteger)fractionDigits;


@end

NS_ASSUME_NONNULL_END
