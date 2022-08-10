//
//  NSData+FYFExtension.h
//  FYFCategory
//
//  Created by 范云飞 on 2021/8/19.
//

#import <Foundation/Foundation.h>

typedef enum
{
    FYFCharEncodeUTF8,
    FYFCharEncodeGBK
}FYFCharEncode;

NS_ASSUME_NONNULL_BEGIN

@interface NSData (FYFExtension)

/// data转成16进制字符串
- (NSString *)fyf_hexString;

/// 16进制字符串转成data
/// @param hexStr 16进制字符串
+ (NSData *)fyf_dataWithHexString:(NSString *)hexStr;

/// 根据在mainBundle中的文件创建data
/// @param name 文件名
+ (NSData *)fyf_dataWithFileNamed:(NSString *)name;


/// NSString 转 NSData
/// @param string 需要编码的字符串
+ (NSData *)fyf_dataWithString:(NSString *)string;

/// NSString 转 NSData
/// @param string 需要编码的字符串
/// @param charEncoding 编码类型
+ (NSData *)fyf_dataWithString:(NSString *)string charEncoding:(FYFCharEncode)charEncoding;

/// NSData 转 NSString
/// @param data NSData
+ (NSString *)fyf_stringWithData:(NSData *)data;

/// NSData 转 NSString
/// @param data NSData
/// @param charEncoding 编码类型
+ (NSString *)fyf_stringWithData:(NSData *)data charEncoding:(FYFCharEncode)charEncoding;


/// deflate 解压算法
/// @param bytes 待解压的bytes
/// @param length 数据长度
+ (id)fyf_dataDeflateWithCompressedBytes:(const void*)bytes length:(unsigned)length;

/// deflate 压缩算法
/// @param bytes 待压缩的bytes
/// @param length  数据长度
+ (id)fyf_compressedInflateDataWithBytes:(const void*)bytes length:(unsigned)length;

/// NSString* 转 char *
/// @param string NSString*
+ (const char *)fyf_charsWithString:(NSString *)string;

///  NSString* 转 char *
/// @param string NSString*
/// @param charEncoding 编码类型
+ (const char *)fyf_charsWithString:(NSString *)string charEncoding:(FYFCharEncode)charEncoding;

/// char* 转 NSString*
/// @param chars chars char*
+ (NSString *)fyf_stringWithChars:(char *)chars;

/// char* 转 NSString*
/// @param chars char*
/// @param charEncoding 编码方式
+ (NSString *)fyf_stringWithChars:(char *)chars charEncoding:(FYFCharEncode)charEncoding;

/// NSData* 转 char*
- (char *)fyf_dataToChars;

/// char* 转 NSData*
/// @param chars char*
+ (NSData *)fyf_dataWithChars:(char *)chars;

/// char* 转 NSData*
/// @param chars char*
/// @param length 数据长度
+ (NSData *)fyf_dataWithChars:(char *)chars length:(NSUInteger)length;

/// nsdata 分片
/// @param slice 片大小（字节数）
/// @param data 待分片的数据
/// @param completion 回调base64数组
+ (void)fyf_dataFragmentedBySlice:(NSUInteger)slice data:(NSData *)data completion:(void(^)(NSArray <NSString *>*base64Arrays))completion;

@end

NS_ASSUME_NONNULL_END
