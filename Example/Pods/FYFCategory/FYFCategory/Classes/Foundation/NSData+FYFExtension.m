//
//  NSData+FYFExtension.m
//  FYFCategory
//
//  Created by 范云飞 on 2021/8/19.
//

#import "NSData+FYFExtension.h"
#import <FYFCategory/NSString+FYFExtension.h>
#import "zlib.h"
#import "NSObject+FYFExtension.h"
@implementation NSData (FYFExtension)

/// data转成16进制字符串
- (NSString *)fyf_hexString {
    NSUInteger length = self.length;
    NSMutableString *result = [NSMutableString stringWithCapacity:length * 2];
    const unsigned char *byte = self.bytes;
    for (int i = 0; i < length; i++, byte++) {
        [result appendFormat:@"%02X", *byte];
    }
    return result;
}

/// 16进制字符串转成data
/// @param hexStr 16进制字符串
+ (NSData *)fyf_dataWithHexString:(NSString *)hexStr {
    NSUInteger str_len = [hexStr length];
    if (str_len < 1 || str_len % 2 != 0) {
        return nil;
    }
    
    NSMutableData *data = [NSMutableData dataWithCapacity:0];
    NSRange range;
    unsigned int hex_val;
    unsigned char hex_char;
    
    range.length = 2;
    
    for (NSUInteger i=0; i<str_len; i += 2) {
        range.location = i;
        if(![[NSScanner scannerWithString:[hexStr substringWithRange:range]] scanHexInt:&hex_val]) {
            return nil;
        }
        hex_char = (unsigned char)hex_val;
        [data appendBytes:&hex_char length:sizeof(hex_char)];
    }
    
    return data;
}

/// 根据在mainBundle中的文件创建data
/// @param name 文件名
+ (NSData *)fyf_dataWithFileNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    if (!path) return nil;
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

/// NSString 转 NSData
/// @param string 需要编码的字符串
+ (NSData *)fyf_dataWithString:(NSString *)string {
    return [self fyf_dataWithString:string charEncoding:FYFCharEncodeUTF8];
}

/// NSString 转 NSData
/// @param string 需要编码的字符串
/// @param charEncoding 编码类型
+ (NSData *)fyf_dataWithString:(NSString *)string charEncoding:(FYFCharEncode)charEncoding {
    NSStringEncoding encoding;
    switch (charEncoding) {
        case FYFCharEncodeGBK:
        {
            encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            break;
        }
        case FYFCharEncodeUTF8:
        {
            encoding = NSUTF8StringEncoding;
            break;
        }
        default:
            break;
    }
    return [string dataUsingEncoding:encoding];
}

/**
 *  NSData 转 NSString
 *
 *  @param data NSData
 *
 *  @return NSString*
 */
+ (NSString *)fyf_stringWithData:(NSData *)data {
    return [self fyf_stringWithData:data charEncoding:FYFCharEncodeUTF8];
}

/**
 *  NSData* 转 NSString*
 *
 *  @param data NSData*
 *  @param charEncoding 编码
 *
 *  @return NSString*
 */
+ (NSString *)fyf_stringWithData:(NSData *)data charEncoding:(FYFCharEncode)charEncoding {
    NSStringEncoding encoding;
    switch (charEncoding) {
        case FYFCharEncodeGBK:
        {
            encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            break;
        }
        case FYFCharEncodeUTF8:
        {
            encoding = NSUTF8StringEncoding;
            break;
        }
        default:
            break;
    }
    if (data && data.length > 0) {
        return [[NSString alloc]initWithData:data encoding:encoding];
    }
    return @"";
}

/// deflate 解压算法
/// @param bytes 待解压的bytes
/// @param length 数据长度
+ (id)fyf_dataDeflateWithCompressedBytes:(const void*)bytes length:(unsigned)length {
    z_stream strm;
    int ret;
    unsigned char out[128 * 1024];
    unsigned char* uncompressedData = NULL;
    unsigned int uncompressedLength = 0;
    
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.avail_in = 0;
    strm.next_in = Z_NULL;
    
    ret = inflateInit(&strm);
    
    if (ret == Z_OK) {
        strm.avail_in = length;
        strm.next_in = (void*) bytes;
        
        do {
            strm.avail_out = sizeof(out);
            strm.next_out = out;
            
            ret = inflate(&strm, Z_NO_FLUSH);
            if (ret != Z_OK && ret != Z_STREAM_END) {
                NSLog(@"inflate: ret != Z_OK %d", ret);
                free(uncompressedData);
                inflateEnd(&strm);
                return nil;
            }
            
            unsigned int have = sizeof(out) - strm.avail_out;
            
            if (uncompressedData == NULL) {
                uncompressedData = malloc(have);
                memcpy(uncompressedData, out, have);
                uncompressedLength = have;
            } else {
                unsigned char* resizedUncompressedData = realloc(uncompressedData, uncompressedLength + have);
                if (resizedUncompressedData == NULL) {
                    free(uncompressedData);
                    inflateEnd(&strm);
                    return nil;
                } else {
                    uncompressedData = resizedUncompressedData;
                    memcpy(uncompressedData + uncompressedLength, out, have);
                    uncompressedLength += have;
                }
            }
        } while (strm.avail_out == 0);
    } else {
        NSLog(@"ret != Z_OK");
    }
    
    if (uncompressedData != NULL) {
        return [NSData dataWithBytesNoCopy: uncompressedData length: uncompressedLength freeWhenDone: YES];
    } else {
        return nil;
    }
}

/// deflate 压缩算法
/// @param bytes 待压缩的bytes
/// @param length  数据长度
+ (id)fyf_compressedInflateDataWithBytes:(const void*)bytes length:(unsigned)length {
    unsigned long compressedLength = compressBound(length);
    unsigned char* compressedBytes = (unsigned char*) malloc(compressedLength);
    
    if (compressedBytes != NULL && compress(compressedBytes, &compressedLength, bytes, length) == Z_OK) {
        char* resizedCompressedBytes = realloc(compressedBytes, compressedLength);
        if (resizedCompressedBytes != NULL) {
            return [NSData dataWithBytesNoCopy: resizedCompressedBytes length: compressedLength freeWhenDone: YES];
        } else {
            return [NSData dataWithBytesNoCopy: compressedBytes length: compressedLength freeWhenDone: YES];
        }
    } else {
        free(compressedBytes);
        return nil;
    }
}

/// NSString* 转 char *
/// @param string NSString*
+ (const char *)fyf_charsWithString:(NSString *)string {
    if (fyf_empty(string)) {
        string = @"";
    }
    return [string UTF8String];
}

///  NSString* 转 char *
/// @param string NSString*
/// @param charEncoding 编码类型
+ (const char *)fyf_charsWithString:(NSString *)string charEncoding:(FYFCharEncode)charEncoding {
    if (fyf_empty(string)) {
        string = @"";
    }
    NSData *data = [NSData fyf_dataWithString:string charEncoding:charEncoding];
    return [data fyf_dataToChars];
}

/// char* 转 NSString*
/// @param chars chars char*
+ (NSString *)fyf_stringWithChars:(char *)chars {
    if (chars && strlen(chars) > 0) {
        return [NSString stringWithUTF8String:chars];
    }
    return @"";
}

/// char* 转 NSString*
/// @param chars char*
/// @param charEncoding 编码方式
+ (NSString *)fyf_stringWithChars:(char *)chars charEncoding:(FYFCharEncode)charEncoding {
    NSStringEncoding encoding;
    switch (charEncoding) {
        case FYFCharEncodeGBK:
        {
            encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            break;
        }
        case FYFCharEncodeUTF8:
        {
            encoding = NSUTF8StringEncoding;
            break;
        }
        default:
            break;
    }
    return [NSString stringWithCString:chars encoding:encoding];
}

/// NSData* 转 char*
- (char *)fyf_dataToChars {
    if (self && self.length > 0) {
        return (char *)[self bytes];
    }
    return (char *)[[NSData data] bytes];
}

/// char* 转 NSData*
/// @param chars char*
+ (NSData *)fyf_dataWithChars:(char *)chars {
    if (chars && strlen(chars) > 0) {
        return [NSData dataWithBytes:chars length:strlen(chars)];
    }
    return [NSData data];
}

/// char* 转 NSData*
/// @param chars char*
/// @param length 数据长度
+ (NSData *)fyf_dataWithChars:(char *)chars length:(NSUInteger)length {
    if (chars && strlen(chars) > 0 && length > 0) {
        return [NSData dataWithBytes:chars length:length];
    }
    return [NSData data];
}

/// nsdata 分片
/// @param slice 片大小（字节数）
/// @param data 待分片的数据
/// @param completion completion description
+ (void)fyf_dataFragmentedBySlice:(NSUInteger)slice data:(NSData *)data completion:(void(^)(NSArray <NSDictionary *>*base64Arrays))completion {
    NSUInteger dataLength = data.length;//数据长度
    NSInteger index = 0; //起始位置
    NSMutableArray <NSString *>*base64Arrays =[NSMutableArray new];
    do {
        @autoreleasepool {
            if (dataLength > slice) {
                NSRange range = NSMakeRange(index*slice, slice);
                index++;
                NSData *sliceData = [data subdataWithRange:range];
                NSString *slibeBase64 = [NSString stringWithFormat:@"%@",[sliceData base64EncodedStringWithOptions: 0]];
                [base64Arrays addObject:slibeBase64];
                dataLength = dataLength - slice;
            } else {
                NSRange range = NSMakeRange(index*slice, dataLength);
                NSData *sliceData = [data subdataWithRange:range];
                NSString *slibeBase64 = [NSString stringWithFormat:@"%@",[sliceData base64EncodedStringWithOptions: 0]];
                [base64Arrays addObject:slibeBase64];
                dataLength = 0;
            }
        }
    } while (dataLength > 0);
    
    if (completion) {
        completion(base64Arrays);
    }
    
}

@end
