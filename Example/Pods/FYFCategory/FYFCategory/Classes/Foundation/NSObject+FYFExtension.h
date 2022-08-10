//
//  NSObject+FYFExtension.h
//  FYFCategory
//
//  Created by 范云飞 on 2022/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static inline BOOL fyf_empty(id object) {
    if (object == nil || [object isEqual:[NSNull null]] || [object isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)object;
        return (str.length < 1) ? YES : NO;
    } else if ([object isKindOfClass:[NSArray class]]) {
        NSArray *arr = (NSArray *)object;
        return (arr.count == 0) ? YES : NO;
    } else if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)object;
        return (dic.allKeys.count == 0) ? YES : NO;
    } else if ([object isKindOfClass:[NSNumber class]]) {
        NSNumber *num = (NSNumber *)object;
        return ([num isEqualToNumber:@0]) ? YES : NO;
    } else {
        return NO;
    }
}

@interface NSObject (FYFExtension)

@end

NS_ASSUME_NONNULL_END
