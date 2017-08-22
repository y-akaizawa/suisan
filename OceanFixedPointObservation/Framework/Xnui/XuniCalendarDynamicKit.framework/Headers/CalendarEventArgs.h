//
//  CalendarEventArgs.h
//  XuniCalendar
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XUNI_INTERNAL_DYNAMIC_BUILD

#ifndef XuniCoreKit_h
#import "XuniCore/Event.h"
#endif


#else
#import "XuniCoreDynamicKit/XuniCoreDynamicKit.h"
#endif

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
*/
@class XuniCalendarRange;

/**
*  XuniCalendarDayOfWeekSlotLoadingEventArgs クラス。
*    dayOfWeekSlotLoading イベントの引数です。
*/
@interface XuniCalendarDayOfWeekSlotLoadingEventArgs : XuniEventArgs

/**
*  対応する曜日スロットの日付情報を取得します。
*/
@property (readonly) XuniDayOfWeek dayOfWeek;

/**
*  日が週末かどうかを取得します。
*/
@property (readonly) BOOL isWeekend;

/**
*  曜日スロットに表示される要素を取得または設定します。
*/
@property (nonatomic) UILabel *dayOfWeekSlot;

/**
*  新しく割り当てられた XuniCalendarDayOfWeekSlotLoadingEventArgs オブジェクトを初期化して返します。
*    @param dayOfWeek        対応する曜日スロットの曜日
*    @param isWeekend        週末の日かどうかを指定します。
*    @param dayOfWeekSlot    曜日スロットに表示される要素
*    @return 初期化された XuniCalendarDayOfWeekSlotLoadingEventArgs オブジェクト。オブジェクトを作成できなかった場合は nil
*/
- (instancetype)initWithDayOfWeek:(XuniDayOfWeek)dayOfWeek isWeekend:(BOOL)isWeekend dayOfWeekSlot:(UILabel *)dayOfWeekSlot;

@end


/**
*  XuniCalendarDaySlotLoadingEventArgs クラス
*    daySlotLoading イベントの引数
*/
@interface XuniCalendarDaySlotLoadingEventArgs : XuniEventArgs

/**
*  現在の日付スロットの日付情報を取得します。
*/
@property (readonly) NSDate *date;

/**
*  カレンダー内の隣接日かどうかを取得します。
*/
@property (readonly) BOOL isAdjacentDay;

/**
*  日付スロットに表示される要素を取得または設定します。
*/
@property (nonatomic) XuniCalendarDaySlotBase *daySlot;

/**
*  新しく割り当てられた XuniCalendarDaySlotLoadingEventArgs オブジェクトを初期化して返します。
*    @param date             現在の日付スロットの日付
*    @param isAdjacentDay    カレンダー内の隣接日かどうかを指定します。
*    @param daySlot          日付スロットに表示される要素
*    @return 初期化された XuniCalendarDaySlotLoadingEventArgs オブジェクト。オブジェクトを作成できなかった場合は nil
*/
- (instancetype)initWithDate:(NSDate *)date isAdjacentDay:(BOOL)isAdjacentDay daySlot:(XuniCalendarDaySlotBase *)daySlot;

@end

/**
*  XuniCalendarSelectionChangedEventArgs クラス
*    selectionChanged イベントの引数
*/
@interface XuniCalendarSelectionChangedEventArgs : XuniEventArgs

/**
*  選択されている日付を取得します。
*/
@property (readonly) XuniCalendarRange *selectedDates;

/**
*  新しく割り当てられた XuniCalendarSelectionChangedEventArgs オブジェクトを初期化して返します。
*    @param selectedDates    選択された日付
*    @return 初期化された XuniCalendarSelectionChangedEventArgs オブジェクト。オブジェクトを作成できなかった場合は nil
*/
- (instancetype)initWithSelectedDates:(XuniCalendarRange *)selectedDates;

@end

/**
*  XuniCalendarMonthSlotLoadingEventArgs クラス。
*    monthSlotLoading イベントの引数です。
*/
@interface XuniCalendarMonthSlotLoadingEventArgs : XuniEventArgs

/**
*  カレンダーの月を取得します。
*/
@property (readonly) NSUInteger month;

/**
*  月スロットに表示される要素を取得または設定します。
*/
@property (nonatomic) XuniCalendarMonthSlotBase *monthSlot;

/**
*  新しく割り当てられた XuniCalendarMonthSlotLoadingEventArgs オブジェクトを初期化して返します。
*    @param month            現在表示されている月の月スロット
*    @param monthSlot        月スロットに表示される要素
*    @return 初期化された XuniCalendarMonthSlotLoadingEventArgs オブジェクト。オブジェクトを作成できなかった場合は nil
*/
- (instancetype)initWithMonth:(NSUInteger)month monthSlot:(XuniCalendarMonthSlotBase *)monthSlot;

@end

/**
*  XuniCalendarYearSlotLoadingEventArgs クラス。
*    yearSlotLoading イベントの引数
*/
@interface XuniCalendarYearSlotLoadingEventArgs : XuniEventArgs

/**
*  カレンダーの年を取得します。
*/
@property (readonly) NSUInteger year;

/**
*  年がカレンダー内の隣接する年かどうかを取得します。
*/
@property (readonly) BOOL isAdjacentYear;

/**
*  年スロットに表示される要素を取得または設定します。
*/
@property (nonatomic) XuniCalendarYearSlotBase *yearSlot;

/**
*  新しく割り当てられた XuniCalendarYearSlotLoadingEventArgs オブジェクトを初期化して返します。
*    @param year                 現在の年スロットの年
*    @param isAdjacentYear       カレンダー内の隣接する年かどうか
*    @param yearSlot             年スロットに表示される要素
*    @return 初期化された XuniCalendarYearSlotLoadingEventArgs オブジェクト。オブジェクトを作成できなかった場合は nil
*/
- (instancetype)initWithYear:(NSUInteger)year isAdjacentYear:(BOOL)isAdjacentYear yearSlot:(XuniCalendarYearSlotBase *)yearSlot;

@end

/**
*  HeaderLoading イベントの引数
*/
@interface XuniCalendarHeaderLoadingEventArgs : XuniEventArgs

/**
*  ヘッダーに表示するテキストを取得または設定します。
*/
@property (nonatomic) NSString *header;

/**
*  カレンダーのビューモードを取得または設定します。ビューモードは、月ビュー、年ビュー、10年ビューのいずかを指定できます。
*/
@property (nonatomic) XuniCalendarViewMode viewMode;

/**
*  ヘッダーの日付を取得または設定します。
*/
@property (nonatomic) NSDate *date;

/**
*  XuniCalendarHeaderLoadingEventArgs のインスタンスを初期化します。
*    @param headerDate ヘッダーの日付
*    @param viewMode   カレンダーのビューモード
*    @param headerText ヘッダーのテキスト
*    @return 初期化されたXuniCalendarHeaderLoadingEventArgs オブジェクト
*/
- (id)initWithDate:(NSDate *)headerDate viewMode:(XuniCalendarViewMode)viewMode  text:(NSString *)headerText;

@end


