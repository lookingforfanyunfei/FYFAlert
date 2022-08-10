//
//  NSDate+FYFExtension.m
//  FYFCategory
//
//  Created by 范云飞 on 2021/8/19.
//

#import "NSDate+FYFExtension.h"

NSString *const kFYFDateFormatShortDateDefault      = @"yyyy-MM-dd";
NSString *const kFYFDateFormatWithHM                = @"yyyy-MM-dd HH:mm";
NSString *const kFYFDateFormatWithTime              = @"yyyy-MM-dd HH:mm:ss";
NSString *const kFYFDateFormatWithTimeZone          = @"yyyy-MM-dd HH:mm:ss zzz";
NSString *const kFYFDateFormatFullDateWithTime      = @"MMM d, yyyy h:mm a";
NSString *const kFYFDateFormatFullDate              = @"MMM d, yyyy";
NSString *const kFYFDateFormatShortDateWithTime     = @"MMM d h:mm a";
NSString *const kFYFDateFormatShortDate             = @"MMM d";
NSString *const kFYFDateFormatWeekday               = @"EEEE";
NSString *const kFYFDateFormatWeekdayWithTime       = @"EEEE h:mm a";
NSString *const kFYFDateFormatTime                  = @"h:mm a";
NSString *const kFYFDateFormatTimeWithPrefix        = @"'at' h:mm a";
NSString *const kFYFDateFormatSQLDate               = @"yyyy-MM-dd";
NSString *const kFYFDateFormatSQLTime               = @"HH:mm:ss";
NSString *const kFYFDateFormatSQLDateWithTime       = @"yyyy-MM-dd HH:mm:ss";
NSString *const kFYFDateFormatMMddHHmm              = @"MM-dd HH:mm";
NSString *const kFYFDateFormatSQLDateToMonth        = @"yyyy-MM";
NSString *const kFYFDateFormatMMRungdd              = @"MM-dd";
NSString *const kFYFDateFormatMMSlashdd             = @"MM/dd";


static const unsigned fyfComponentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

@implementation NSDate (FYFExtension)

+ (NSCalendar *)fyf_currentCalendar {
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}
#pragma mark -
- (NSInteger)fyf_hour {
    NSDateComponents *components = [[NSDate fyf_currentCalendar] components:fyfComponentFlags fromDate:self];
    return components.hour;
}

- (NSInteger)fyf_minute {
    NSDateComponents *components = [[NSDate fyf_currentCalendar] components:fyfComponentFlags fromDate:self];
    return components.minute;
}

- (NSInteger)fyf_seconds {
    NSDateComponents *components = [[NSDate fyf_currentCalendar] components:fyfComponentFlags fromDate:self];
    return components.second;
}

- (NSInteger)fyf_day {
    NSDateComponents *components = [[NSDate fyf_currentCalendar] components:fyfComponentFlags fromDate:self];
    return components.day;
}

- (NSInteger)fyf_month {
    NSDateComponents *components = [[NSDate fyf_currentCalendar] components:fyfComponentFlags fromDate:self];
    return components.month;
}

- (NSInteger)fyf_week {
    NSDateComponents *components = [[NSDate fyf_currentCalendar] components:fyfComponentFlags fromDate:self];
    return components.weekOfMonth;
}

- (NSInteger)fyf_weekday {
    NSDateComponents *components = [[NSDate fyf_currentCalendar] components:fyfComponentFlags fromDate:self];
    return components.weekday;
}

- (NSInteger)fyf_year {
    NSDateComponents *components = [[NSDate fyf_currentCalendar] components:fyfComponentFlags fromDate:self];
    return components.year;
}

/** 按照特定的格式返回日期
 * @param format  输入的日期格式
 * @return 日期
 */
- (NSDate *)fyf_dateWithFormatter:(NSString *)format {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    fmt.dateFormat = format;
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

/** 按照特定的格式返回字符串
 * @param format 日期格式
 * @return 字符串
 */
- (NSString *)fyf_stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

/** 按照特定的日期转换字符串
 * @param datestr  字符串
 * @param format    日期格式
 * @return 日期
 */
+ (NSDate *)fyf_date:(NSString *)datestr WithFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:datestr];
    return [self fyf_localeDate:date];
}

/**
 如果将某一字符串直接转换成NSDate，会发现实际结果与原时间相差八小时。这是因为NSDate存储的是世界标准时（UTC），输出时需要根据时区转换为本地时间
 */
/// @param date <#date description#>
+ (NSDate *)fyf_localeDate:(NSDate *)date {
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    return localeDate;
}

@end

@implementation  NSDate (FYFTools)

static NSCalendar *_calendar = nil;
static NSDateFormatter *_displayFormatter = nil;
static NSArray *_weekDayArr = nil;

+ (void)fyfInitializeStatics {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            if (_calendar == nil) {
                _calendar = [NSCalendar currentCalendar];
            }
            if (_displayFormatter == nil) {
                _displayFormatter = [[NSDateFormatter alloc] init];
            }
        if (_weekDayArr == nil) {
            _weekDayArr = [NSArray arrayWithObjects:
                           @"星期日",
                           @"星期一",
                           @"星期二",
                           @"星期三",
                           @"星期四",
                           @"星期五",
                           @"星期六", nil];
        }
    });
}

#pragma mark 初始化方法
+ (NSCalendar *)fyfSharedCalendar {
    [self fyfInitializeStatics];
    return _calendar;
}

+ (NSDateFormatter *)fyfSharedDateFormatter {
    [self fyfInitializeStatics];
    return _displayFormatter;
}

+ (NSArray *)sharedWeekDayArray{
    [self fyfInitializeStatics];
    return _weekDayArr;
}

#pragma mark - 转换方法

+ (NSDate *)fyfDateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *formatter = [self fyfSharedDateFormatter];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

+ (NSString *)fyfStringFromDate:(NSDate *)date withFormat:(NSString *)format
{
    NSDateFormatter *formatter = [self fyfSharedDateFormatter];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

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
              withDateStyle:(fyfDateStringStyle)dateStyle{
    NSDate *date = [self fyfDateFromString:dateStr withFormat:fromDateFormat];
    if (date == nil){
        return dateStr;
    }
    //获取自定义日期
    NSString *customDateStr = [self fyf_getCustomDateStrWithDate:date dateString:dateStr dateFormat: toDateFormat dateStype:dateStyle];
    
    return customDateStr;
}

/** 私有方法,获取自定义日期 */
+ (NSString *)fyf_getCustomDateStrWithDate:(NSDate *)shortDate
                            dateString:(NSString *)dateString
                            dateFormat:(NSString *)dateFormat
                             dateStype:(fyfDateStringStyle)dateStyle{
    NSCalendar *calendar = [[self class] fyfSharedCalendar];
    if ([calendar isDateInToday:shortDate]){
        return @"今天";
    }
    
    switch (dateStyle) {
        case fyfTodayTomorrowStyle:
            if ([calendar isDateInTomorrow:shortDate]) {
                return @"明天";
            }
            break;
        case fyfYesterdayTodayStyle:
            if ([calendar isDateInYesterday:shortDate]) {
                return @"昨天";
            }
            break;
        default:
            break;
    }
  
        if (dateFormat == nil || dateFormat.length == 0){
            return dateString;
        }
        return [self fyfStringFromDate:shortDate withFormat:dateFormat];
    
   
}


/**
 获取日期对应的周几字符串（周一 ～ 周日）
 
 @param date 日期
 @return 对应字符串
 */
+ (NSString *)fyf_getWeekDayStringWithDate:(NSString *)format{
    NSString *weekDayStr = nil;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    if(format.length>=10) {
       NSString *nowString = [format substringToIndex:10];
       NSArray *array = [nowString componentsSeparatedByString:@"-"];
       if(array.count==0) {
           array = [nowString componentsSeparatedByString:@"/"];
       }
       
       if(array.count>=3) {
           NSInteger year = [[array objectAtIndex:0] integerValue];
           NSInteger month = [[array objectAtIndex:1] integerValue];
           NSInteger day = [[array objectAtIndex:2] integerValue];
           [comps setYear:year];
           [comps setMonth:month];
           [comps setDay:day];
       }
    }
    //日历
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //获取传入date
    NSDate *_date = [gregorian dateFromComponents:comps];

    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    NSInteger week = [weekdayComponents weekday];
    switch(week) {
       case 1:
           weekDayStr =@"周日";
           break;
       case 2:
           weekDayStr =@"周一";
           break;
       case 3:
           weekDayStr =@"周二";
           break;
       case 4:
           weekDayStr =@"周三";
           break;
       case 5:
           weekDayStr =@"周四";
           break;
       case 6:
           weekDayStr =@"周五";
           break;
       case 7:
           weekDayStr =@"周六";
           break;
       default:
           weekDayStr =@"";
           break;
    }
    return weekDayStr;
    
}


/** 获取本周最后一天
 @return 本周最后一天
 */
+ (NSDate *)fyf_getLastDayOfWeek{
    NSDate *date = [NSDate date];
    NSDateComponents *comp = [[self fyfSharedCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:date];
    
    // 获取今天是周几（周日:1 ,周一:2 ,周二:3 ,周三:4 ,周四:5 ,周五:6 ,周六:7）
    NSInteger weekDay = [comp weekday];
    // 获取今天是几号
    NSInteger day = [comp day];
    // 计算当前日期和本周星期天相差天数
    long lastDiff;
    // weekDay = 1;
    if (weekDay == 1)
    {
        lastDiff = 0;
    }
    else
    {
        lastDiff = 8 - weekDay;
    }
    
    NSDateComponents *lastDayComp = [[self fyfSharedCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [lastDayComp setDay:day + lastDiff];
    
    //本周最后一天
    return [[self fyfSharedCalendar] dateFromComponents:lastDayComp];
}

/** 将日期字符串转换为指定格式的日期字符串
 * @param str 待转换日期字符串
 * @param source 日期字符串的源格式
 * @param target 目标格式
 * @return 转换后的字符串 转换失败会返回原字符串 若方法无法满足要求请另开一个新方法
 * @by:aremny.hu date:2018/07.18
 **/
+ (NSString *)fyf_dateStringFromString:(NSString *)str sourceFormat:(NSString *)source targetFormat:(NSString *)target {
    NSDate *tempDate = [self fyfDateFromString:str withFormat:source];
    NSString *targetStr = [self fyfStringFromDate:tempDate withFormat:target];
    // 转换不成功 返回原字符串
    if (nil == targetStr || [targetStr length] < 1) {
        return str;
    }
    return targetStr;
}

/**
 检测时间
 
 @param firstDate 第一个比较时间
 @param secondDate 第二个比较时间
 @param format 时间格式
 @return 比较结果
 */
+ (BOOL)fyf_compareDate:(nonnull NSString *)firstDate withDate:(nonnull NSString *)secondDate format:(NSString *_Nullable)format{
    NSString *fm = (nil == format || [format length] < 1) ? @"yyyy/MM":format;
    NSDate * firstDt = [self fyfDateFromString:firstDate withFormat:fm];
    NSDate * secondDt = [self fyfDateFromString:secondDate withFormat:fm];
    NSComparisonResult result = [firstDt compare:secondDt];
    if (result == NSOrderedAscending) {
        return YES;
    }else {
        return NO;
    }
}


/** 获取距离当前时间多久的一个新日期
 * @param years +1表示1年后的日期 -1表示1年前的日期
 * @param months +1表示1月后的日期 -1表示1月前的日期
 * @param days +1表示1天后的日期 -1表示1天前的日期
 * @return 新日期
 **/
+ (NSDate *)fyf_dateSinceDinstaceNowWithYear:(NSInteger)years month:(NSInteger)months day:(NSInteger)days {
    NSCalendar *sharedCalendar = [self fyfSharedCalendar];
    
    NSDateComponents *comps = nil;
    comps = [sharedCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:years];
    [adcomps setMonth:months];
    [adcomps setDay:days];
    
    NSDate *newDate = [sharedCalendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    
    return newDate;
}

+ (NSString *)fyf_timeIntervalStrSinceNowWithSourceTime:(NSString *)source format:(NSString *)format {
    NSDate *sourceDate = [self fyfDateFromString:source withFormat:format];
    if (!sourceDate) {
        return @"";
    }
    NSTimeInterval interval = fabs(sourceDate.timeIntervalSinceNow);
    // 分钟 小时 天 (月) 年
    NSInteger minutes = interval / 60;
    NSInteger hours = interval / 60 / 60;
    NSInteger days = interval / 60 / 60 / 24;
    // NSInteger years = interval / 60 / 60 / 24 / 365;
    // 1小时以内展示“XX分钟前” 1小时（含）以上至1天内展示“XX小时前” \
    // 1天（含）以上且在一个自然年内展示“月-日 时:分” 一个自然年以外展示“年-月-日 时:分
    if (hours < 1) {
        return [NSString stringWithFormat:@"%@分钟前", @(minutes)];
    } else if (days < 1) {
        return [NSString stringWithFormat:@"%@小时前", @(hours)];
    }
    NSDate *dateNow = [NSDate date];
    NSCalendar *calendar = [self fyfSharedCalendar];
    NSComparisonResult result = [calendar compareDate:sourceDate toDate:dateNow toUnitGranularity:NSCalendarUnitYear];
    if (result == NSOrderedAscending) {
        return [self fyfStringFromDate:sourceDate withFormat:@"yyyy-MM-dd HH:mm"];
    } else {
        return [self fyfStringFromDate:sourceDate withFormat:@"MM-dd HH:mm"];
    }
}

/** 列表时间规范化 几分钟前 几小时前 ...
 * @param source 时间字符串
 * @param format 格式
 * @return 处理后的字符串
 */
+ (NSString *)fyf_listTimeIntervalStrSinceNowWithSourceTime:(NSString *)source format:(NSString *)format {
    NSDate *sourceDate = [self fyfDateFromString:source withFormat:format];
    if (!sourceDate) {
        return @"";
    }
    NSTimeInterval interval = fabs(sourceDate.timeIntervalSinceNow);
    // 分钟 小时 天 (月) 年
    NSInteger minutes = interval / 60;
    NSInteger hours = interval / 60 / 60;
    NSInteger days = interval / 60 / 60 / 24;
    // NSInteger years = interval / 60 / 60 / 24 / 365;
    // 1小时以内展示“XX分钟前” 1小时（含）以上至1天内展示“XX小时前” \
    //  如果是1天以上的  显示月日，一个自然年以外显示 年月日
    if (hours < 1) {
        return [NSString stringWithFormat:@"%@分钟前", @(minutes)];
    } else if (days < 1) {
        return [NSString stringWithFormat:@"%@小时前", @(hours)];
    }
    NSDate *dateNow = [NSDate date];
    NSCalendar *calendar = [self fyfSharedCalendar];
    NSComparisonResult result = [calendar compareDate:sourceDate toDate:dateNow toUnitGranularity:NSCalendarUnitYear];
    if (result == NSOrderedAscending) {
        return [self fyfStringFromDate:sourceDate withFormat:@"yyyy-MM-dd"];
    } else {
        return [self fyfStringFromDate:sourceDate withFormat:@"MM-dd"];
    }
}

/// 获取某年某月的天数
/// @param year 年
/// @param month 月
+ (NSUInteger)fyf_getDaysInYear:(NSInteger)year month:(NSInteger)month {
    BOOL isLeapYear = year % 4 == 0 ? (year % 100 == 0 ? (year % 400 == 0 ? YES : NO) : YES) : NO;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
        {
            return 31;
        }
        case 4:
        case 6:
        case 9:
        case 11:
        {
            return 30;
        }
        case 2:
        {
            if (isLeapYear) {
                return 29;
            } else {
                return 28;
            }
        }
        default:
            break;
    }
    
    return 0;
}


@end
