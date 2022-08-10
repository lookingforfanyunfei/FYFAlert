//
//  NSFileManager+FYFExtension.h
//  FYFCategory
//
//  Created by 范云飞 on 2021/9/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (FYFExtension)


@property (nonatomic, copy, readonly, class) NSString *fyf_homeDirectory;
@property (nonatomic, copy, readonly, class) NSString *fyf_documentDirectory;
@property (nonatomic, copy, readonly, class) NSString *fyf_libraryDirectory;
@property (nonatomic, copy, readonly, class) NSString *fyf_cachesDirectory;
@property (nonatomic, copy, readonly, class) NSString *fyf_preferencePanesDirectory;
@property (nonatomic, copy, readonly, class) NSString *fyf_tmpDirectory;

/// app路径
+ (NSString *)fyf_appDirectoryPath;

/// 程序包内资源路径
+ (NSString *)fyf_mainBundleResource:(NSString *)resource;

/// 创建文件夹
+ (BOOL)fyf_createDirectoryAtPath:(NSString *)path;

+ (BOOL)fyf_createDirectoryInHome:(NSString *)dirName;
+ (BOOL)fyf_createDirectoryInDocument:(NSString *)dirName;
+ (BOOL)fyf_createDirectoryInLibrary:(NSString *)dirName;
+ (BOOL)fyf_createDirectoryInPreferences:(NSString *)dirName;
+ (BOOL)fyf_createDirectoryInCaches:(NSString *)dirName;
+ (BOOL)fyf_createDirectoryInTmp:(NSString *)dirName;

/// 创建文件
+ (BOOL)fyf_createFileAtPath:(NSString *)path;

+ (BOOL)fyf_createHomeFile:(NSString *)fileName inDirectory:(NSString *)dir;
+ (BOOL)fyf_createDocumentFile:(NSString *)fileName inDirectory:(NSString *)dir;
+ (BOOL)fyf_createLibraryFile:(NSString *)fileName inDirectory:(NSString *)dir;
+ (BOOL)fyf_createPreferencesFile:(NSString *)fileName inDirectory:(NSString *)dir;
+ (BOOL)fyf_createCacheFile:(NSString *)fileName inDirectory:(NSString *)dir;
+ (BOOL)fyf_createTmpFile:(NSString *)fileName inDirectory:(NSString *)dir;

/// 删除文件
+ (BOOL)fyf_removeItemAtPath:(NSString *)path;

/// 将object对象写入指定path的plist文件中
/// @param path plist文件所在路径
/// @param object 写入内容
/// @param key key值
+ (BOOL)fyf_writeToPlistFile:(NSString*)path object:(id)object forKey:(NSString *)key;


/// plist中对应key的值
/// @param path plist文件所在路径
/// @param key 对应key值
+ (id)fyf_objectInPlistFile:(NSString *)path ofKey:(NSString *)key;

/// 文件夹（文件）大小
+ (CGFloat)fyf_sizeOfDirectory:(NSString *)path;
+ (CGFloat)fyf_sizeOfFile:(NSString*)path;


@end

NS_ASSUME_NONNULL_END
