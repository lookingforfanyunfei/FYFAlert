//
//  NSDate+FYFExtension.h
//  FYFCategory
//
//  Created by 范云飞 on 2021/8/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
     时间格式:
     G:      公元时代，例如AD公元
     yy:     年的后2位
     yyyy:   完整年
     MM:     月，显示为1-12,带前置0
     MMM:    月，显示为英文月份简写,如 Jan
     MMMM:   月，显示为英文月份全称，如 Janualy
     dd:     日，2位数表示，如02
     d:      日，1-2位显示，如2，无前置0
     EEE:    简写星期几，如Sun
     EEEE:   全写星期几，如Sunday
     aa:     上下午，AM/PM
     H:      时，24小时制，0-23
     HH:     时，24小时制，带前置0
     h:      时，12小时制，无前置0
     hh:     时，12小时制，带前置0
     m:      分，1-2位
     mm:     分，2位，带前置0
     s:      秒，1-2位
     ss:     秒，2位，带前置0
     S:      毫秒
     Z：      GMT（时区）
 */

/** yyyy-MM-dd HH:mm */
extern NSString * _Nonnull const kFYFDateFormatWithHM;
/** yyyy-MM-dd */
extern NSString * _Nonnull const kFYFDateFormatSQLDate;
/** yyyy-MM-dd HH:mm:ss*/
extern NSString * _Nonnull const kFYFDateFormatSQLDateWithTime;
/**yyyy-MM-dd HH:mm:ss zzz*/
extern NSString * _Nonnull const kFYFDateFormatWithTimeZone;
/** yyyy-MM */
extern NSString * _Nonnull const kFYFDateFormatSQLDateToMonth;
/** MMM d, yyyy h:mm a*/
extern NSString * _Nonnull const kFYFDateFormatFullDateWithTime;
/** yyyy-MM-dd HH:mm:ss */
extern NSString * _Nonnull const kFYFDateFormatWithTime;
/** yyyy-MM-dd*/
extern NSString * _Nonnull const kFYFDateFormatShortDateDefault;
/** MMM d, yyyy */
extern NSString * _Nonnull const kFYFDateFormatFullDate;
/** MMM d h:mm a */
extern NSString * _Nonnull const kFYFDateFormatShortDateWithTime;
/** MMM d*/
extern NSString * _Nonnull const kFYFDateFormatShortDate;
/** EEEE */
extern NSString * _Nonnull const kFYFDateFormatWeekday;
/** EEEE h:mm a */
extern NSString * _Nonnull const kFYFDateFormatWeekdayWithTime;
/** h:mm a */
extern NSString * _Nonnull const kFYFDateFormatTime;
/** 'at' h:mm a */
extern NSString * _Nonnull const kFYFDateFormatTimeWithPrefix;
/** HH:mm:ss*/
extern NSString * _Nonnull const kFYFDateFormatSQLTime;
/** MM-dd HH:mm */
extern NSString * _Nonnull const kFYFDateFormatMMddHHmm;
/** MM-dd */
extern NSString * _Nonnull const kFYFDateFormatMMRungdd;
/** MM/dd */
extern NSString * _Nonnull const kFYFDateFormatMMSlashdd;

@interface NSDate (FYFExtension)
///时
@property (readonly) NSInteger fyf_hour;
///分
@property (readonly) NSInteger fyf_minute;
///秒
@property (readonly) NSInteger fyf_seconds;
///日
@property (readonly) NSInteger fyf_day;
///月
@property (readonly) NSInteger fyf_month;
///周
@property (readonly) NSInteger fyf_week;
///星期几
@property (readonly) NSInteger fyf_weekday;
///年
@property (readonly) NSInteger fyf_year;

/** 按照特定的格式返回日期
 * @param format  日期格式
 * @return 日期
 */
- (NSDate *)fyf_dateWithFormatter:(NSString *)format;

/** 按照特定的格式返回字符串==>NSDate转NSString
 * @param format 日期格式
 * @return 字符串
 */
- (NSString *)fyf_stringWithFormat:(NSString *)format;

/** 按照特定的日期转换字符串
 * @param datestr  字符串
 * @param format    日期格式
 * @return 日期
 */
+ (NSDate *)fyf_date:(NSString *)datestr WithFormat:(NSString *)format;

@end


typedef NS_ENUM(NSInteger, fyfDateStringStyle)
{
    fyfTodayTomorrowStyle = 0,
    fyfYesterdayTodayStyle
};

@interface NSDate (FYFTools)


/** 自定义日期字符串（"今天","昨天" 或 “今天”,"明天"）
 @param dateStr 日期字符串
 @param fromDateFormat 初始字符串的日期格式
 @param toDateFormat 转化后的日期格式，若格式不变，传nil即可
 @param dateStyle 日期样式（目前两种样式）

 @return 转换后日期字符串
 */
+ (NSString *)fyf_customDateStr:(NSString *)dateStr
             fromDateFormat:(NSString *)fromDateFormat
               toDateFormat:(NSString *)toDateFormat
              withDateStyle:(fyfDateStringStyle)dateStyle;

/**
 获取本周最后一天
 @return 本周最后一天
 */
+ (NSDate *)fyf_getLastDayOfWeek;


/**
 获取日期对应的周几字符串（周一 ～ 周日）
 @param format 日期
 @return 对应字符串
 */
+ (NSString *)fyf_getWeekDayStringWithDate:(NSString *)format;

/** 将日期字符串转换为指定格式的日期字符串
 * @param str 待转换日期字符串
 * @param source 日期字符串的源格式
 * @param target 目标格式
 * @return 转换后的字符串 转换失败会返回原字符串 若方法无法满足要求请另开一个新方法
 * @by:aremny.hu date:2018/07.18
 **/
+ (NSString *)fyf_dateStringFromString:(NSString *)str sourceFormat:(NSString *)source targetFormat:(NSString *)target;
/**
 检测时间
 
 @param firstDate 第一个比较时间
 @param secondDate 第二个比较时间
 @param format 时间格式
 @return YES:first<second
 */
+ (BOOL)fyf_compareDate:(nonnull NSString *)firstDate withDate:(nonnull NSString *)secondDate format:(NSString *_Nullable)format;

/** 获取距离当前时间多久的一个新日期
 * @param years +1表示1年后的日期 -1表示1年前的日期
 * @param months +1表示1月后的日期 -1表示1月前的日期
 * @param days +1表示1天后的日期 -1表示1天前的日期
 * @return 新日期
 **/
+ (NSDate *)fyf_dateSinceDinstaceNowWithYear:(NSInteger)years month:(NSInteger)months day:(NSInteger)days;

/** 时间规范化 几分钟前 几小时前 ...
 * @param source 时间字符串
 * @param format 格式
 * @return 处理后的字符串
 */
+ (NSString *)fyf_timeIntervalStrSinceNowWithSourceTime:(NSString *)source format:(NSString *)format;

/** 列表时间规范化 几分钟前 几小时前 ...
 * @param source 时间字符串
 * @param format 格式
 * @return 处理后的字符串
 */
+ (NSString *)fyf_listTimeIntervalStrSinceNowWithSourceTime:(NSString *)source format:(NSString *)format;

/// 获取某年某月的天数
/// @param year 年
/// @param month 月
+ (NSUInteger)fyf_getDaysInYear:(NSInteger)year month:(NSInteger)month;

@end


NS_ASSUME_NONNULL_END
