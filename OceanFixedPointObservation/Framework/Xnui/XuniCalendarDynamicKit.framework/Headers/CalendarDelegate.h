//
//  CalendarDelegate.h
//  XuniCalendar
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef CalendarDelegate_h
#define CalendarDelegate_h

#import "XuniCalendarEnums.h"
#import "CalendarRange.h"

/**
*/
@class XuniCalendar;
/**
*/
@class XuniCalendarDaySlotLoadingEventArgs;
/**
*/
@class XuniCalendarDayOfWeekSlotLoadingEventArgs;
/**
*/
@class XuniCalendarSelectionChangedEventArgs;
/**
*/
@class XuniCalendarHeaderLoadingEventArgs;
/**
*/
@class XuniCalendarMonthSlotLoadingEventArgs;
/**
*/
@class XuniCalendarYearSlotLoadingEventArgs;
/**
*/
@class XuniCalendarDaySlotBase;
/**
*/
@class XuniCalendarMonthSlotBase;
/**
*/
@class XuniCalendarYearSlotBase;

/**
*  XuniCalendarDelegate プロトコル
*/
@protocol XuniCalendarDelegate <NSObject>
/**
*/
@optional

/**
*  ユーザーが月ヘッダーをタップしたときなど、カレンダーのビューモードが変更されると発生します。
*    @param sender ビューモードが変更されたカレンダー
*/
- (void)viewModeChanged:(XuniCalendar *)sender;

/**
*  displayDate プロパティが変更されたときに発生します。
*    @param sender displayDate プロパティが変更されたカレンダー
*/
- (void)displayDateChanged:(XuniCalendar *)sender;

/**
*  displayDate プロパティが変更される前に発生します。
*    @param sender displayDate プロパティが変更されたカレンダー
*/
- (void)displayDateChanging:(XuniCalendar *)sender;

/**
*  曜日を表す要素が作成される直前に発生します。
*    @param sender 曜日を追加するカレンダー
*    @param dayOfWeek     曜日
*    @param isWeekend     週末かどうか
*    @param dayOfWeekSlot 曜日スロット
*/
- (void)dayOfWeekSlotLoading:(XuniCalendar *)sender dayOfWeek:(XuniDayOfWeek)dayOfWeek isWeekend:(BOOL)isWeekend dayOfWeekSlot:(UILabel*)dayOfWeekSlot;

/**
*  カレンダーの日付を表す要素が作成される直前に発生します。
*    @param sender        日付の追加対象となるカレンダー
*    @param date          日付
*    @param isAdjacentDay 隣接日かどうか
*    @param daySlot       日付スロット
*    @return カレンダーに追加された日付スロット
*/
- (XuniCalendarDaySlotBase*)daySlotLoading:(XuniCalendar *)sender date:(NSDate*)date isAdjacentDay:(BOOL)isAdjacentDay daySlot:(XuniCalendarDaySlotBase*)daySlot;

/**
*  カレンダーの月を表す要素が作成される直前に発生します。
*    @param sender    月の追加対象となるカレンダー
*    @param month     月
*    @param monthSlot 月スロット
*/
- (void)monthSlotLoading:(XuniCalendar *)sender month:(NSUInteger)month monthSlot:(XuniCalendarMonthSlotBase*)monthSlot;

/**
*  カレンダーの年を表す要素が作成される直前に発生します。
*    @param sender         年の追加対象となるカレンダー
*    @param year           年
*    @param isAdjacentYear 隣接年かどうか
*    @param yearSlot       年スロット
*/
- (void)yearSlotLoading:(XuniCalendar *)sender year:(NSUInteger)year isAdjacentYear:(BOOL)isAdjacentYear yearSlot:(XuniCalendarYearSlotBase*)yearSlot;

/**
*  選択された日付（selectedDate または selectedDates プロパティ）が変更されると発生します。
*    @param sender selectedDate または selectedDates プロパティが変更されたカレンダー
*    @param selectedDates 選択された日付
*/
- (void)selectionChanged:(XuniCalendar *)sender selectedDates:(XuniCalendarRange*)selectedDates;

/**
*  選択が完了する前に発生します。
*    @param sender selectedDate または selectedDates プロパティが変更されたカレンダー
*    @param args   イベント引数
*/
- (void)selectionChanging:(XuniCalendar *)sender selectedDates:(XuniCalendarRange*)selectedDates;

/**
*  ヘッダーの読み込みを処理するイベント
*    @param sender   イベントが発生したカレンダー
*    @param header   ヘッダーテキスト
*    @param viewMode ビューモード
*    @param date     日付
*    @return ヘッダーテキスト
*/
- (NSString *)handleHeaderLoading:(XuniCalendar *)sender header:(NSString *)header viewMode:(XuniCalendarViewMode)viewMode date:(NSDate *)date;

/**
*  コントロールの描画が終了した時に呼び出されます。
*    @param sender 描画されたコントロール
*/
- (void)rendered:(XuniCalendar *)sender;

@end

#endif /* CalendarDelegate_h */
