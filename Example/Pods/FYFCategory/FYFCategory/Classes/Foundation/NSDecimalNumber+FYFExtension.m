//
//  NSDecimalNumber+FYFExtension.m
//  FYFCategory
//
//  Created by 范云飞 on 2021/8/23.
//

#import "NSDecimalNumber+FYFExtension.h"

@implementation NSDecimalNumber (FYFExtension)

+ (NSDecimalNumber *)fyf_decimalNumberWithFloat:(float)value {
    return [self fyf_decimalNumberWithFloat:value scale:2];
}

+ (NSDecimalNumber *)fyf_decimalNumberWithFloat:(float)value scale:(short)scale {
    return [self fyf_decimalNumberWithFloat:value roundingMode:NSRoundBankers scale:scale];
}

+ (NSDecimalNumber *)fyf_decimalNumberWithFloat:(float)value roundingMode:(NSRoundingMode)roundingMode scale:(short)scale {
    return [[[NSDecimalNumber alloc] initWithFloat:value] fyf_decimalNumberHandlerWithRoundingMode:roundingMode scale:scale];
}

+ (NSDecimalNumber *)fyf_decimalNumberWithDouble:(double)value {
    return [self fyf_decimalNumberWithDouble:value scale:2];
}

+ (NSDecimalNumber *)fyf_decimalNumberWithDouble:(double)value scale:(short)scale {
    return [self fyf_decimalNumberWithDouble:value roundingMode:NSRoundBankers scale:scale];
}

+ (NSDecimalNumber *)fyf_decimalNumberWithDouble:(double)value roundingMode:(NSRoundingMode)roundingMode scale:(short)scale {
    return [[[NSDecimalNumber alloc] initWithFloat:value] fyf_decimalNumberHandlerWithRoundingMode:roundingMode scale:scale];
}

- (NSDecimalNumber *)fyf_decimalNumberHandlerWithRoundingMode:(NSRoundingMode)roundingMode scale:(short)scale{
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode
                                                                                             scale:scale
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:YES
                                                                                  raiseOnUnderflow:YES
                                                                               raiseOnDivideByZero:YES];
    return [self decimalNumberByRoundingAccordingToBehavior:handler];
}

#pragma mark - NSNumber特定的小数点转换

+ (NSString *)fyf_formatterNumber:(NSNumber *)number {
    
    return [self fyf_formatterNumber:number fractionDigits:2];
}

+ (NSString *)fyf_formatterNumber:(NSNumber *)number fractionDigits:(NSUInteger)fractionDigits {
    if (number) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.minimumIntegerDigits = 1;
        [numberFormatter setMaximumFractionDigits:fractionDigits];
        [numberFormatter setMinimumFractionDigits:fractionDigits];
        
        return [numberFormatter stringFromNumber:number];
    }
    return @"0";
}


+ (double)fyf_doubleNumber:(NSNumber *)number {
    return [self fyf_doubleNumber:number fractionDigits:2];
}

+ (double)fyf_doubleNumber:(NSNumber *)number fractionDigits:(NSUInteger)fractionDigits {
    NSString *numberStr = [self fyf_formatterNumber:number fractionDigits:fractionDigits];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return  [[formatter numberFromString:numberStr] doubleValue];
}

+ (float)fyf_floatNumber:(NSNumber *)number {
    return [self fyf_floatNumber:number fractionDigits:2];
}

+ (float)fyf_floatNumber:(NSNumber *)number fractionDigits:(NSUInteger)fractionDigits {
    NSString *numberStr = [self fyf_formatterNumber:number fractionDigits:fractionDigits];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return  [[formatter numberFromString:numberStr] floatValue];
}

@end
