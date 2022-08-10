//
//  NSString+FYFExtension.h
//  FYFCategory
//
//  Created by 范云飞 on 2021/8/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// URLString转码，add by 范云飞
static inline NSString *fyf_encodeString(NSString *uncodeString) {
    NSMutableCharacterSet *charset = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [charset addCharactersInString:@"!$&'()*+,-./:;=?@_~%#[]"];
    NSString *encodedString = [uncodeString stringByAddingPercentEncodingWithAllowedCharacters:charset];
    return encodedString;
}

typedef NSString* (^ReplaceBlock)(NSString*,NSInteger);

@interface NSString (FYFExtension)

/// json 转换成字典
- (NSDictionary *)fyf_jsonToDictionary;

/// json 转成NSObject
- (NSObject *)fyf_jsonToObject;

/// 产生num位随机数
/// @param num 随机数位数
+ (NSString *)fyf_generateRandomString:(int)num;

/// 替换字符串
/// @param oldStr 需要替换的字符串
/// @param newStr 用来替换的字符串
/// @param isUseRegex 是否支持正则表达式
- (NSString *)fyf_replaceOldStr:(NSString *)oldStr newStr:(NSString *)newStr isUseRegex:(BOOL)isUseRegex;

/// 查找字符串
/// @param str 要查找的字符串, 返回字符串的位置，没有返回-1
- (NSInteger)fyf_indexOfString:(NSString *)target;

/// 分割字符串,分隔符支持正则表达式
/// @param splitStr 分割符,支持正则表达式
- (NSArray *)fyf_splitWith:(NSString *)splitStr;

/// 分割字符串,分隔符支持正则表达式
/// @param splitStr 分割符,支持正则表达式
/// @param isUseRegex 是否支持正则表达式
- (NSArray *)fyf_splitWith:(NSString *)splitStr isUseRegex:(BOOL)isUseRegex;

/// 过滤特殊字符
- (NSString *)fyf_removeUnescapedCharacter;

/// 截取字符串
/// @param begin 开始索引
/// @param end 结束索引
- (NSString *)fyf_subStringFromIndex:(NSInteger)begin toIndex:(NSInteger)end;

/// 截取字符串
/// @param begin 开始索引
/// @param count 截取数目
- (NSString *)fyf_subStringFromIndex:(NSInteger)begin count:(NSInteger)count;

/// 去掉字符串两端的空白字符
- (nullable NSString *)fyf_stringByTrim;

/// 判断字符串是否以指定的字符串开头
/// @param str 要判断的字符串的值
- (BOOL)fyf_isBeginWith:(NSString *)str;

/// 判断字符串是否以指定的字符串结尾
/// @param str 要判断的字符串的值
- (BOOL)fyf_isEndWith:(NSString *)str;

/// 去掉字符串中所有空白字符
- (nullable NSString *)fyf_stringByRemoveWhitespace;

/// 根据中文字符长度限制，返回最大的子字符串
- (nullable NSString *)fyf_stringByLimitChineseLength:(NSUInteger)length;

/// 根据英文字符长度限制，返回最大的子字符串
- (NSString *)fyf_stringByLimitBytesLength:(NSInteger)length;

/// 根据指定长度&字号确定一个字串，省去的部分用...
/// 如：”中华人民的骄傲“  截取一定长度后变为 ”中华人民...“
- (NSString *)fyf_stringByMaxWidth:(CGFloat)maxWidth font:(UIFont *)font;

/// 是否包含指定字符串
/// @param subStr 指定字符串
- (BOOL)fyf_contains:(NSString *)subStr;

/// 是否包含表情
- (BOOL)fyf_containsEmoji;

/// 比较两字符串相等
/// @param aString
/// @param ignoreCase 是否忽略大小写
- (BOOL)fyf_isEqualToString:(NSString *)aString ignoreCase:(BOOL)ignoreCase;

/// 计算字符串GBK编码长度：中文时1,英文是0.5。
/// @return 字符串长度
/// @Notes:ascii的算0.5 非ascii的算1 这个跟GBK的算长度结果是一样的
- (NSUInteger)fyf_lengthOfAscii;

/// 计算字符串长度：中文时1,英文是0.5。如果计算得3.5，则返回 4
- (NSUInteger)fyf_lengthOfChinese;
@end



@interface NSString (FYFRegex)

// 判断是否手机号
- (BOOL)fyf_isPhoneNumber;

// 判断是否电子邮箱
- (BOOL)fyf_isEmailAddress;

// 判断是否IP地址
- (BOOL)fyf_isIPAddress;

// 判断是否为身份证号码
- (BOOL)fyf_isIDCardNumber;

// 判断是否包含中文汉字
- (BOOL)fyf_isContainChinese;

/// 判断是否匹配正则表达式 YES: 匹配
/// @param regex 正则表达式
- (BOOL)fyf_evaluatePredicateWithRegex:(NSString *)regex;

// 中文字符串转拼音
- (NSString *)fyf_transformChineseToPinyin;

@end

@interface NSString (FYFSize)

/// 根据指定宽度计算字符串高度
/// @param font 字体
/// @param width 宽度
- (CGFloat)fyf_heightWithFont:(UIFont *)font width:(CGFloat)width;

/// 根据指定高度计算字符串宽度
/// @param font 字体
/// @param height 高度
- (CGFloat)fyf_widthWithFont:(UIFont *)font height:(CGFloat)height;

/// 根据指定宽度计算字符串高度
/// @param width 宽度
/// @param font 字体
/// @param lineSpace 行间距
/// @param wordSpace 字间距
/// @param numberOfLines 行数（0行表示不限行数）
- (CGFloat)fyf_heightWithWidth:(CGFloat)width font:(UIFont*)font lineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace numberOfLines:(NSInteger)numberOfLines;

/// 计算字符串的宽高
- (CGSize)fyf_sizeWithFont:(UIFont *)font;
- (CGSize)fyf_sizeWithFontSize:(CGFloat)fontSize;
- (CGSize)fyf_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
- (CGRect)fyf_boundingRectWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end

@interface NSString (FYFConvert)

/// url
- (nullable NSURL *)fyf_toURL;

/// utf-8/md5 data
- (NSData *)fyf_utf8Data;
- (NSData *)fyf_md5Data;

/// md5/sha256 string
- (NSString *)fyf_md5String;
- (NSString *)fyf_sha256String;

/// utf-8 encode/decode
- (NSString *)fyf_stringByURLEncode;
- (NSString *)fyf_stringByURLDecode;

@end

@interface NSString (FYFRange)

- (NSRange)rangeOfStringNoCase:(NSString*)s;

@end

NS_ASSUME_NONNULL_END
