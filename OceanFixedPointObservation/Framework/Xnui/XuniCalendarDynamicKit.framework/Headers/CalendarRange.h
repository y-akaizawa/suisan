//
//  CalendarRange.h
//  XuniCalendar
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

/**
*/
@class XuniCalendar;

/**
*  XuniCalendarRange クラス
*/
@interface XuniCalendarRange : NSObject

/**
*  範囲の開始日を取得または設定します。
*/
@property (nonatomic) NSDate *startDate;

/**
*  範囲の終了日を取得または設定します。
*/
@property (nonatomic) NSDate *endDate;

/**
*  新しく割り当てられた XuniCalendarRange オブジェクトを初期化して返します。
*    @param start 開始日
*    @param end   終了日
*    @param calendar 範囲を取得する対象の XuniCalendar
*    @return 初期化された XuniCalendarRange オブジェクト。オブジェクトを作成できなかった場合は nil
*/
- (instancetype)initWithStartDate:(NSDate *)start endDay:(NSDate *)end calendar:(XuniCalendar *)calendar;

/**
*  日が範囲内にあるかどうかを返します。
*    @param day 計算の実行対象になる日
*    @return 指定された日が範囲内の場合は YES、そうでない場合は NO
*/
- (BOOL)containsDay:(NSDateComponents *)day;

/**
*  日付が範囲内にあるかどうかを返します。
*    @param date 計算の実行対象になる日付
*    @return 指定された日付が範囲内の場合は YES、そうでない場合は NO
*/
- (BOOL)containsDate:(NSDate *)date;

/**
*  日付の年と月が範囲内にあるかどうかを返します。
*    @param date 対象となる日付
*    @return 対象となる日付が範囲内にある場合はtrue、範囲外の場合はfalse
*/
- (BOOL)containsDateYM:(NSDate *)date;

/**
*  日付の年が範囲内にあるかどうかを返します。
*    @param date 対象となる
*    @return 対象となる日付が範囲内にある場合はtrue、範囲外の場合はfalse
*/
- (BOOL)containsDateY:(NSDate *)date;

/**
*  除外された日付配列に日付を追加します。
*    @param date 追加される日付
*/
- (void)addExcludedDates:(NSDate *)date;

/**
*  除外された日付配列をリセットします。
*/
- (void)resetExcludedDates;

@end
