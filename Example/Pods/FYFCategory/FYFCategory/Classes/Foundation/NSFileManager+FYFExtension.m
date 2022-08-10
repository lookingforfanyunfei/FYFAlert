//
//  NSFileManager+FYFExtension.m
//  FYFCategory
//
//  Created by 范云飞 on 2021/9/7.
//

#import "NSFileManager+FYFExtension.h"
#import "NSString+FYFExtension.h"
#import "NSObject+FYFExtension.h"
typedef NS_ENUM(NSUInteger,FYFRootDirType) {
    FYFRootDirTypeHome,
    FYFRootDirTypeDocument,
    FYFRootDirTypeLibrary,
    FYFRootDirTypeCaches,
    FYFRootDirTypePreference,
    FYFRootDirTypeTmp
};
@implementation NSFileManager (FYFExtension)


/// app路径
+ (NSString *)fyf_appDirectoryPath {
    return [[NSBundle mainBundle] bundlePath];
}

/// 程序包内资源路径
+ (NSString *)fyf_mainBundleResource:(NSString *)resource {
    NSString *string = [NSString stringWithFormat:@"%@",resource];
    NSArray *array = [NSArray arrayWithArray:[string componentsSeparatedByString:@"."]];
    if (array.count != 2) {
        return nil;
    }
    return [[NSBundle mainBundle] pathForResource:[array objectAtIndex:0] ofType:[array objectAtIndex:1]];
}

/// home
+ (NSString *)fyf_homeDirectory {
    return NSHomeDirectory();
}

/// Documents
+ (NSString *)fyf_documentDirectory {
    NSArray *pArySearch = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if ([pArySearch count] < 1) {
        return NULL;
    }
    return [pArySearch objectAtIndex:0];
}

/// library路径 /Library
+ (NSString *)fyf_libraryDirectory {
    NSArray *libraryArray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    if ([libraryArray count] < 1) {
        return nil;
    }
    
    return [libraryArray objectAtIndex:0];
}


/// 缓存文件的路径 /Library/Caches
+ (NSString *)fyf_cachesDirectory {
    NSArray *pArySearch = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    if ([pArySearch count] < 1) {
        return NULL;
    }
    return [pArySearch objectAtIndex:0];
}

/// 公共偏好设置的路径 /Library/PreferencePanes
+ (NSString *)fyf_preferencePanesDirectory {
    NSArray *pArySearch = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES);
    
    if ([pArySearch count] < 1) {
        return NULL;
    }
    return [pArySearch objectAtIndex:0];
}

/// 临时文件的路径 /tmp
+ (NSString *)fyf_tmpDirectory {
    return NSTemporaryDirectory();
}

#pragma mark - 创建文件夹

+ (BOOL)fyf_createDirectoryInHome:(NSString *)dirName {
    return [self fyf_createDirectory:dirName rootDirType:FYFRootDirTypeHome];
}

+ (BOOL)fyf_createDirectoryInDocument:(NSString *)dirName {
    return [self fyf_createDirectory:dirName rootDirType:FYFRootDirTypeDocument];
}

+ (BOOL)fyf_createDirectoryInLibrary:(NSString *)dirName {
    return [self fyf_createDirectory:dirName rootDirType:FYFRootDirTypeLibrary];
}

+ (BOOL)fyf_createDirectoryInPreferences:(NSString *)dirName {
    return [self fyf_createDirectory:dirName rootDirType:FYFRootDirTypePreference];
}

+ (BOOL)fyf_createDirectoryInCaches:(NSString *)dirName {
    return [self fyf_createDirectory:dirName rootDirType:FYFRootDirTypeCaches];
}

+ (BOOL)fyf_createDirectoryInTmp:(NSString *)dirName {
    return [self fyf_createDirectory:dirName rootDirType:FYFRootDirTypeTmp];
}

+ (BOOL)fyf_createDirectory:(NSString *)dirName rootDirType:(FYFRootDirType)rootDirType {
    if (fyf_empty(dirName)) {
        return YES;
    }
    NSString *rootDirPath = [self fyf_rootPathWithType:rootDirType];
    NSString *filePath = [rootDirPath stringByAppendingPathComponent:dirName];
    return [self fyf_createDirectoryAtPath:filePath];
    
}

+ (BOOL)fyf_createDirectoryAtPath:(NSString *)path {
    if (path == NULL || path.length == 0) {
        return NO;
    }
    
    NSError *error = nil;
    if ([[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error] == NO) {
        if (error) {
            NSLog(@"文件夹创建失败：%@", [error localizedDescription]);
        }
        return NO;
    }
    
    return YES;
}

#pragma mark - 创建文件

+ (BOOL)fyf_createHomeFile:(NSString *)fileName inDirectory:(NSString *)dir {
    return [self fyf_createFile:fileName inDirectory:dir rootDirType:FYFRootDirTypeHome];
}

+ (BOOL)fyf_createDocumentFile:(NSString *)fileName inDirectory:(NSString *)dir {
    return [self fyf_createFile:fileName inDirectory:dir rootDirType:FYFRootDirTypeDocument];
}

+ (BOOL)fyf_createLibraryFile:(NSString *)fileName inDirectory:(NSString *)dir {
    return [self fyf_createFile:fileName inDirectory:dir rootDirType:FYFRootDirTypeLibrary];
}

+ (BOOL)fyf_createPreferencesFile:(NSString *)fileName inDirectory:(NSString *)dir {
    return [self fyf_createFile:fileName inDirectory:dir rootDirType:FYFRootDirTypePreference];
}

+ (BOOL)fyf_createCacheFile:(NSString *)fileName inDirectory:(NSString *)dir {
    return [self fyf_createFile:fileName inDirectory:dir rootDirType:FYFRootDirTypeCaches];
}

+ (BOOL)fyf_createTmpFile:(NSString *)fileName inDirectory:(NSString *)dir {
    return [self fyf_createFile:fileName inDirectory:dir rootDirType:FYFRootDirTypeTmp];
}

+ (BOOL)fyf_createFile:(NSString *)fileName inDirectory:(NSString *)dir rootDirType:(FYFRootDirType)rootDirType {
    if (fyf_empty(fileName))
        return NO;
    
    NSString *rootDirPath = [self fyf_rootPathWithType:rootDirType];
    if (fyf_empty(rootDirPath)) {
        return NO;
    }
    
    if (fyf_empty(dir)) {
        return [self fyf_createFileAtPath:[rootDirPath stringByAppendingPathComponent:fileName]];
    }
    
    NSString *dirPath = [rootDirPath stringByAppendingPathComponent:dir];
    if (![self fyf_createDirectoryAtPath:dirPath]) {
        return NO;
    }
    
    NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
    return [self fyf_createFileAtPath:filePath];
}

/// 创建文件
+ (BOOL)fyf_createFileAtPath:(NSString *)path {
    if (path == NULL || path.length == 0) {
        return NO;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return YES;
    }
    
    if ([[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil] == NO) {
        NSLog(@"文件创建失败：%@", path);
        return NO;
    }
    return YES;
}

+ (NSString *)fyf_rootPathWithType:(FYFRootDirType)rootDirType {
    NSString *rootDirPath = @"";
    switch (rootDirType) {
        case FYFRootDirTypeTmp:
            rootDirPath = NSFileManager.fyf_tmpDirectory;
            break;
        case FYFRootDirTypeHome:
            rootDirPath = NSFileManager.fyf_homeDirectory;
            break;
        case FYFRootDirTypeLibrary:
            rootDirPath = NSFileManager.fyf_libraryDirectory;
            break;
        case FYFRootDirTypeDocument:
            rootDirPath = NSFileManager.fyf_documentDirectory;
            break;
        case FYFRootDirTypeCaches:
            rootDirPath = NSFileManager.fyf_cachesDirectory;
            break;
        case FYFRootDirTypePreference:
            rootDirPath = NSFileManager.fyf_preferencePanesDirectory;
            break;
        default:
            break;
    }
    return rootDirPath;
}

#pragma mark - plist 读写

+ (BOOL)fyf_writeToPlistFile:(NSString*)path object:(id)object forKey:(NSString *)key {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        if ([self fyf_createFileAtPath:path] == NO) {
            // 创建失败
            return NO;
        }
    }
    
    if (key == NULL || key.length == 0) {
        return NO;
    }
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    if (dic == NULL) {
        dic = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    
    if (object) {
        [dic setObject:object forKey:key];
    } else {
        [dic removeObjectForKey:key];
    }
    
    return [dic writeToFile:path atomically:YES];
}

+ (id)fyf_objectInPlistFile:(NSString *)path ofKey:(NSString *)key {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        if ([self fyf_createFileAtPath:path] == NO) {
            //创建失败
            return NULL;
        }
    }
    
    if (key == NULL || key.length == 0) {
        return NULL;
    }
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (dic == NULL) {
        return NULL;
    }
    return [dic objectForKey:key];
}

#pragma mark - 文件大小

+ (CGFloat)fyf_sizeOfDirectory:(NSString *)path {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        return 0;
    }
    NSEnumerator *childFilesEnumerator = [[[NSFileManager defaultManager] subpathsAtPath:path] objectEnumerator];
    NSString *fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString* fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
        if ([manager fileExistsAtPath:fileAbsolutePath]){
            folderSize += [[manager attributesOfItemAtPath:fileAbsolutePath error:nil] fileSize];
        }
    }
    
    return folderSize / (1024.0 * 1024.0);
}

+ (CGFloat)fyf_sizeOfFile:(NSString*)path {
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        return [[manager attributesOfItemAtPath:path error:nil] fileSize] / (1024.0 * 1024.0);
    }
    
    return 0;
}

#pragma mark - 删除文件

+ (BOOL)fyf_removeItemAtPath:(NSString *)path {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return NO;
    }
    return [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
}

@end
