//
//  NSString+FYFExtension.m
//  FYFCategory
//
//  Created by 范云飞 on 2021/8/19.
//

#import "NSString+FYFExtension.h"
#import "NSObject+FYFExtension.h"

@implementation NSString (FYFExtension)

/// json 转dictionary
- (NSDictionary *)fyf_jsonToDictionary {
    NSObject *obj = [self fyf_jsonToObject];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)obj;
    }
    return [NSDictionary dictionary];
}

/// json转object
- (NSObject *)fyf_jsonToObject {
    if (self.length) {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        NSError *parseError = nil;
        NSObject *obj = (NSObject *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseError];
        if (parseError) {
            return nil;
        }
        return obj;
    }
    return nil;
}

/// 产生num位随机数
/// @param num 随机数位数
+ (NSString *)fyf_generateRandomString:(int)num {
    unichar *data = malloc(sizeof(unichar) * num);
    for (NSInteger x = 0; x < num; x ++) {
        NSInteger j = '0' + arc4random_uniform(10);
        data[x] = (unichar)j;
    }
    return [NSString stringWithCharacters:data length:num];
}

- (NSString *)fyf_replaceOldStr:(NSString *)oldStr newStr:(NSString *)newStr isUseRegex:(BOOL)isUseRegex {
    if (fyf_empty(self) && !fyf_empty(oldStr)) {
        if (isUseRegex) {
            NSError * error;
            //创建正则表达式
            NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:oldStr options:NSRegularExpressionCaseInsensitive error:&error];
            if (regExp) {
                //根据正则表达式替换
                return [regExp stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:newStr];
            } else {
                return [self stringByReplacingOccurrencesOfString:oldStr withString:newStr];
            }
        } else {
            return [self stringByReplacingOccurrencesOfString:oldStr withString:newStr];
        }
    } else {
        return @"";
    }
}

- (NSInteger)fyf_indexOfString:(NSString *)target {
    if (!fyf_empty(self) && target) {
        NSRange range = [self rangeOfString:target];
        if (range.length > 0) {
            return range.location;
        }
        return -1;
    }
    return -1;
}

- (NSArray *)fyf_splitWith:(NSString *)splitStr {
    splitStr = splitStr.description;
    if ([splitStr isEqualToString:@"\\|"]) {
        splitStr = @"|";
    }
    if ([splitStr isEqualToString:@"\\?"]) {
        splitStr = @"?";
    }
    if ([splitStr isEqualToString:@"\\."]) {
        splitStr = @".";
    }
    if ([splitStr isEqualToString:@"\\:"]) {
        splitStr = @":";
    }
    return [self fyf_splitWith:splitStr isUseRegex:NO];
}

- (NSArray *)fyf_splitWith:(NSString *)splitStr isUseRegex:(BOOL)isUseRegex {
    if (!fyf_empty(self) && splitStr && splitStr.length > 0) {
        if (isUseRegex) {
            NSError *error;
            //匹配分割符号的正则表达式
            NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:splitStr options:NSRegularExpressionCaseInsensitive error:&error];
            if (regExp) {
                //获取分割符号匹配的数组结果
                NSArray *checkResultArray = [regExp matchesInString:self options:0 range:NSMakeRange(0, self.length)];
                //循环遍历，根据分割符号的位置截取字符串
                if (checkResultArray && checkResultArray.count > 0) {
                    //存储最后返回的数组结果
                    NSMutableArray *resultStrAry = [NSMutableArray array];
                    //索引
                    NSInteger index = 0;
                    for (NSTextCheckingResult *checkResult in checkResultArray) {
                        //分割符号的位置区域
                        NSRange splitStrRange = [checkResult range];
                        //根据分隔符截取的区域
                        NSRange resultStrRange = NSMakeRange(index, splitStrRange.location-index);
                        //获取区域内的字符串
                        NSString *resultStr = [self substringWithRange:resultStrRange];
                        //调整索引值
                        index = splitStrRange.location + splitStrRange.length;
                        //加入最终的数组
                        [resultStrAry addObject:resultStr];
                    }
                    //获取分隔符后面最后一个字符串
                    if (index <= self.length) {
                        NSRange resultStrRange = NSMakeRange(index, self.length - index);
                        NSString *resultStr = [self substringWithRange:resultStrRange];
                        [resultStrAry addObject:resultStr];
                    }
                    return resultStrAry;
                } else {
                    return [self componentsSeparatedByString:splitStr];
                }
            } else {
                return [self componentsSeparatedByString:splitStr];
            }
        } else  {
            return [self componentsSeparatedByString:splitStr];
        }
    } else {
        if (self) {
            return [NSArray arrayWithObjects:self, nil];
        }
        return nil;
    }
}
- (NSString *)fyf_stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSString *)fyf_removeUnescapedCharacter {
    if(!fyf_empty(self)) {
        NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];
        NSRange range = [self rangeOfCharacterFromSet:controlChars];
        if (range.location != NSNotFound)
        {
            NSMutableString *mutable = [NSMutableString stringWithString:self];
            while (range.location != NSNotFound)
            {
                [mutable deleteCharactersInRange:range];
                range = [mutable rangeOfCharacterFromSet:controlChars];
            }
            return mutable;
        }
    }
    return self;
}

- (NSString *)fyf_subStringFromIndex:(NSInteger)begin toIndex:(NSInteger)end {
    if (self && self.length > 0 && begin < end && end <= self.length) {
        return [self substringWithRange:NSMakeRange(begin, end-begin)];
    }
    return @"";
}

- (NSString *)fyf_subStringFromIndex:(NSInteger)begin count:(NSInteger)count {
    if (self && self.length > 0 && (begin + count) <= self.length) {
        return [self substringWithRange:NSMakeRange(begin, count)];
    }
    return @"";
}

- (BOOL)fyf_isBeginWith:(NSString *)str {
    if(!fyf_empty(self) && str) {
        return [self hasPrefix:str];
    }
    return NO;
}

- (BOOL)fyf_isEndWith:(NSString *)str {
    if(!fyf_empty(self) && str) {
        return [self hasSuffix:str];
    }
    return NO;
}

- (NSString *)fyf_stringByRemoveWhitespace {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)fyf_stringByMaxWidth:(CGFloat)maxWidth font:(UIFont *)font {
    CGSize maxSize = CGSizeMake(maxWidth, 10);
    CGSize selfSize = [self fyf_sizeWithFont:font maxSize:maxSize];
    if (selfSize.width < maxWidth) {
        return self;
    }
    NSString *realString = @"";
    for (NSInteger idx = 0 ; idx < self.length; idx += 1) {
        NSString *subString = [self substringToIndex:self.length - idx];
        CGSize subSize = [subString fyf_sizeWithFont:font maxSize:maxSize];
        if (subSize.width < maxWidth) {
            realString = [[subString substringToIndex:subString.length - 1] stringByAppendingString:@"..."];
            break;
        }
    }
    return realString;
}

- (NSString *)fyf_stringByLimitChineseLength:(NSInteger)length {
    NSInteger stringLength = [self length];
    if (stringLength < length) {
        return self;
    }
    NSInteger maxLen = length * 2;
    NSInteger subLen = 0;
    for (int i = 0; i < stringLength; i++) {
        NSString *currentStr = [self substringWithRange:NSMakeRange(i , 1)];
        maxLen--;
        if ([currentStr fyf_isChineseChar]) {
            maxLen--;
        }
        if (maxLen < 0) {
            break;
        }else {
            subLen++;
        }
    }
    return [self substringToIndex:subLen];
}

/**
 根据英文字符长度限制，返回最大的子字符串
 */
- (NSString *)fyf_stringByLimitBytesLength:(NSInteger)length {
    
    NSInteger stringLength = 0;
    NSInteger chineseNum = 0;
    NSInteger zifuNum = 0;
    for (int i = 0; i < [self length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        if ([s fyf_isChineseChar]) {
            if (stringLength + 2 > length) {
                return [self substringToIndex:chineseNum + zifuNum];
            }
            stringLength += 2;
            chineseNum += 1;
        } else {
            if (stringLength + 1 > length) {
                return [self substringToIndex:chineseNum + zifuNum];
            }
            stringLength += 1;
            zifuNum += 1;
        }
    }
    return [self substringToIndex:length];
}

- (NSUInteger)fyf_lengthOfAscii {
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex:i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return (asciiLength + 1)/2;
}

- (NSUInteger)fyf_lengthOfChinese {
    NSUInteger stringLength = [self length];
    
    for (NSUInteger i = 0; i < [self length]; i++) {
        NSString *currentStr = [self substringWithRange:NSMakeRange(i , 1)];
        if ([currentStr fyf_isChineseChar]) {
            stringLength++;
        }
    }
    return ceil(stringLength / 2.0f);
}

- (BOOL)fyf_containsEmoji {
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          returnValue = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      returnValue = YES;
                                  }
                              } else {
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      if (0x2780 <= hs && hs <= 0x279f) {
                                          returnValue = NO;
                                      } else {
                                          returnValue = YES;
                                      }
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      returnValue = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      returnValue = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      returnValue = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                      returnValue = YES;
                                  }
                              }
                          }];
    
    return returnValue;
}

- (BOOL)fyf_contains:(NSString *)subStr {
    if (fyf_empty(subStr)) {
        return NO;
    }
    return [self containsString:subStr];
}

- (BOOL)fyf_isEqualToString:(NSString *)aString ignoreCase:(BOOL)ignoreCase {
    if (ignoreCase) {
        return [self caseInsensitiveCompare:aString] == NSOrderedSame;
    } else {
        return [self isEqualToString:aString];
    }
}

- (BOOL)fyf_isChineseChar {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[\\u0391-\\uFFE5]"];
    if ([predicate evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}
@end

@implementation NSString (FYFRegex)

//判断是否手机号
- (BOOL)fyf_isPhoneNumber {
    NSString *regex = @"^1[3|4|5|7|8][0-9]{9}$";
    
    return [self fyf_evaluatePredicateWithRegex:regex];
}

//判断是否电子邮箱
- (BOOL)fyf_isEmailAddress {
    NSString *regix = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self fyf_evaluatePredicateWithRegex:regix];
}

//判断是否IP地址
- (BOOL)fyf_isIPAddress {
    NSString *regex = @"^(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3}$";
    return [self fyf_evaluatePredicateWithRegex:regex];
}

//判断是否为身份证号码
- (BOOL)fyf_isIDCardNumber {
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [self fyf_evaluatePredicateWithRegex:regex];
}

//判断是否包含中文汉字
- (BOOL)fyf_isContainChinese {
    for(int i=0; i< [self length];i++) {
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

//判断是否匹配正则表达式
- (BOOL)fyf_evaluatePredicateWithRegex:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];

    BOOL result = [predicate evaluateWithObject:self];
    return result;
}

//中文字符串转拼音
- (NSString *)fyf_transformChineseToPinyin {
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [self mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //返回最近结果
    return pinyin;
}
@end



@implementation NSString (FYFSize)

- (CGFloat)fyf_heightWithFont:(UIFont *)font width:(CGFloat)width {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:options context:nil];
    return ceilf(rect.size.height);
}

- (CGFloat)fyf_widthWithFont:(UIFont *)font height:(CGFloat)height {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:options context:nil];
    return ceilf(rect.size.width);
}

- (CGFloat)fyf_heightWithWidth:(CGFloat)width font:(UIFont*)font lineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace numberOfLines:(NSInteger)numberOfLines {
    if (numberOfLines < 0) {
        return 0;
    }
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    if (numberOfLines == 0) {
        CGSize orginalSize = [self boundingRectWithSize:size font:font lineSpace:lineSpace wordSpace:wordSpace];
        return ceil(orginalSize.height);
    }

    CGFloat maxHeight = font.lineHeight * numberOfLines + lineSpace * (numberOfLines - 1);

    CGSize orginalSize = [self boundingRectWithSize:size font:font lineSpace:lineSpace wordSpace:wordSpace];

    if (orginalSize.height >= maxHeight) {
        return ceil(maxHeight);
    } else {
        return ceil(orginalSize.height);
    }
}

- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font lineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace {
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    paragraphStyle.hyphenationFactor = 1.0;
    
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    
    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
    
    NSDictionary * dic = @{NSKernAttributeName:@(wordSpace)};
    [attributeString addAttributes:dic range:NSMakeRange(0, self.length)];;

    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect rect = [attributeString boundingRectWithSize:size options:options context:nil];
    return rect.size;
}

- (CGSize)fyf_sizeWithFont:(UIFont *)font {
    return [self fyf_sizeWithFont:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}
- (CGSize)fyf_sizeWithFontSize:(CGFloat)fontSize {
    return [self fyf_sizeWithFont:[UIFont systemFontOfSize:fontSize] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];;
}

- (CGSize)fyf_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    return [self fyf_boundingRectWithFont:font maxSize:maxSize].size;
}

- (CGRect)fyf_boundingRectWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSMutableDictionary * attrDict = [[NSMutableDictionary alloc] init];
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    [attrDict setObject:font forKey:NSFontAttributeName];
    [attrDict setObject:style forKey:NSParagraphStyleAttributeName];
    return [self boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:attrDict
                              context:nil];
}

@end

#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (FYFConvert)

- (nullable NSURL *)fyf_toURL {
    if (fyf_empty(self)) {
        return nil;
    }
    return [NSURL URLWithString:self];
}



- (NSData *)fyf_utf8Data {
    if (fyf_empty(self)) {
        return [NSData data];
    }
    
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSData *)fyf_md5Data {
    if([self length] == 0){
        return nil;
    }
    
    const char *src = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(src, (unsigned int)strlen(src), result);
    
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)fyf_md5String {
    if(self == nil || [self length] == 0){
        return nil;
    }
    
    const char *src = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(src, (unsigned int)strlen(src), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        //%02意思是不足两位将用0补齐，如果多于两位则不影响,小写x表示输出小写，大写X表示输出大写
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

/**
 SHA256 编码
 
 @return NSString
 */
- (NSString *)fyf_sha256String {
    const char *s = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];

    uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
    CC_SHA256(keyData.bytes, (CC_LONG)keyData.length, digest);
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];

    const unsigned *hashBytes = [out bytes];
    NSString *hash = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
    ntohl(hashBytes[0]), ntohl(hashBytes[1]), ntohl(hashBytes[2]),
    ntohl(hashBytes[3]), ntohl(hashBytes[4]), ntohl(hashBytes[5]),
    ntohl(hashBytes[6]), ntohl(hashBytes[7])];
    return hash;
}

- (NSString *)fyf_stringByURLEncode {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}
- (NSString *)fyf_stringByURLDecode {
    return [self stringByRemovingPercentEncoding];
}

@end

@implementation NSString(FYFRange)
- (NSRange)rangeOfStringNoCase:(NSString*)s {
    return  [self rangeOfString:s options:NSCaseInsensitiveSearch];
}

@end
