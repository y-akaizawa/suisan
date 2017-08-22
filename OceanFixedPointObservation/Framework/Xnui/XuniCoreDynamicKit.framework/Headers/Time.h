//
//  Time.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
*  XuniSecondsPer の列挙型
*/
typedef NS_ENUM (NSInteger, XuniSecondsPer){
/**
*  1 秒/秒を設定
*/
    XuniSecondsPerSecond = 1,
/**
*  60 秒/分を設定
*/
    XuniSecondsPerMinute = 60,
/**
*  3600 秒/時間を設定
*/
    XuniSecondsPerHour = 3600,
/**
*  86400 秒/日を設定
*/
    XuniSecondsPerDay = 86400,
/**
*  604800 秒/週を設定
*/
    XuniSecondsPerWeek = 604800,
/**
*  2678400 秒/月を設定
*/
    XuniSecondsPerMonth = 2678400,
/**
*  31536000 秒/年を設定
*/
    XuniSecondsPerYear = 31536000
};

/**
*  XuniTimeSpan
*/
@interface XuniTimeSpan : NSObject

/**
*  合計秒数を取得します。
*/
@property (readonly) double totalSeconds;

/**
*  合計日数を取得します。
*/
@property (readonly) double totalDays;

/**
*  XuniTimeSpan オブジェクトを初期化します。
*    @param seconds 秒数
*    @return XuniTimeSpan オブジェクト
*/
- (id)initSeconds:(double)seconds;

/**
*  秒数から XuniTimeSpan オブジェクトを取得します。
*    @param seconds 秒数
*    @return XuniTimeSpan オブジェクト
*/
+ (XuniTimeSpan *)fromSeconds:(double)seconds;

/**
*  日数から XuniTimeSpan オブジェクトを取得します。
*    @param days 日数
*    @return XuniTimeSpan オブジェクト
*/
+ (XuniTimeSpan *)fromDays:(double)days;
@end

/**
*  XuniTimeHelper オブジェクト
*/
@interface XuniTimeHelper : NSObject

/**
*  XuniTimeHelper オブジェクトを初期化します。
*    @param date 日付
*    @return XuniTimeHelper オブジェクト
*/
- (id)initDate:(NSDate *)date;

/**
*  XuniTimeHelper オブジェクトを初期化します。
*    @param seconds 秒数
*    @return XuniTimeHelper オブジェクト
*/
- (id)initTimeIntervalSince1970:(NSTimeInterval)seconds;

/**
*  日時形式の時刻を取得します。
*    @return 日付
*/
- (NSDate *)getTimeAsDateTime;

/**
*  double 型の時間を取得します。
*    @return 値
*/
- (double)getTimeAsDouble;

/**
*  NSInteger 型値を取得します。
*    @param tval    時間値
*    @param tunit   単位
*    @param roundup 丸めるかどうか
*    @return NSInteger 型値
*/
+ (NSInteger)tround:(NSInteger)tval tunit:(NSInteger)tunit roundup:(BOOL)roundup;

/**
*  double 型値を取得します。
*    @param timevalue 時間値
*    @param unit      単位
*    @param roundup   丸めるかどうか
*    @return double 値
*/
+ (double)roundTime:(double)timevalue unit:(NSInteger)unit roundup:(BOOL)roundup;

/**
*  XuniTimeSpan オブジェクトを取得します。
*    @param ti ti 値
*    @return XuniTimeSpan オブジェクト
*/
+ (XuniTimeSpan *)timeSpanFromTmInc:(NSInteger)ti;
/**
*  @exclude
*     NSInteger 型値を取得します。
*    @param manualformat 文字列
*    @return NSInteger 型値
*/
+ (NSInteger)manualTimeInc:(NSString *)manualformat;

/**
*  double 型値を取得します。
*    @param tik  配列
*    @param ts   値
*    @param mult 値
*    @return 値
*/
+ (double)getNiceInc:(NSArray *)tik ts:(double)ts mult:(double)mult;

/**
*  XuniTimeSpan オブジェクトを取得します。
*    @param ts           XuniTimeSpan オブジェクト
*    @param manualformat  manualformat 文字列
*    @return XuniTimeSpan オブジェクト
*/
+ (XuniTimeSpan *)niceTimeSpan:(XuniTimeSpan *)ts manualformat:(NSString *)manualformat;
@end
