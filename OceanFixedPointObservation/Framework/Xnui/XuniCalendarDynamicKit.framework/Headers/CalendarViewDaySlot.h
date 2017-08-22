//
//  CalendarViewDaySlot.h
//  XuniCalendar
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "CalendarDaySlotBase.h"

/**
*/
@class XuniCalendar;

/**
*  XuniCalendarViewDaySlot クラス
*    カスタムビューを含む日付スロットを表します。
*/
@interface XuniCalendarViewDaySlot : XuniCalendarDaySlotBase

/**
*  カスタムビューを取得または設定します。
*/
@property (nonatomic) UIView *customView;

/**
*  カレンダーを取得または設定します。
*/
@property (nonatomic) XuniCalendar *xuniCalendar;

/**
*  日付スロットの日付を取得または設定します。
*/
@property (nonatomic) NSDate *date;

/**
*  日付スロットの状態を取得または設定します。
*/
@property (nonatomic) XuniDaySlotState state;

/**
*  新しく割り当てられた XuniCalendarViewDaySlot オブジェクトを、指定されたカレンダーとフレーム四角形で初期化して返します。
*    @param calendar XuniCalendar オブジェクト
*    @param frame    XuniCalendarViewDaySlot のフレーム四角形（ポイント単位）
*    @return 初期化された XuniCalendarViewDaySlot オブジェクト。オブジェクトを作成できなかった場合は nil
*/
- (id)initWithCalendar:(XuniCalendar *)calendar frame:(CGRect)frame;

/**
*  日付スロットが選択されているかどうかを返します。
*    @return 日付スロットが選択されている場合は YES、そうでない場合は NO
*/
- (BOOL)isSelected;

/**
*  日付スロットの日付が今日かどうかを返します。
*    @return 日付スロットの日付が今日の場合は YES、そうでない場合は NO
*/
- (BOOL)isToday;

/**
*  日付スロットが隣接しているかどうかを返します。
*    @return 日付スロットが隣接している場合は YES、そうでない場合は NO
*/
- (BOOL)isAdjacent;

@end
