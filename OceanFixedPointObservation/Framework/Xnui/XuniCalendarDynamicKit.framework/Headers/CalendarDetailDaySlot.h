//
//  CalendarDetailDaySlot.h
//  XuniCalendar
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "CalendarDaySlot.h"

/**
*  XuniCalendarDetailDaySlot クラス
*    第 2 テキストを含む日付スロットを表します。
*/
@interface XuniCalendarDetailDaySlot : XuniCalendarDaySlot

/**
*  日付スロットに表示される詳細テキストを取得または設定します。
*/
@property (nonatomic) NSString *detailText;

/**
*  その中に詳細テキストが表示される四角形領域を取得または設定します。
*/
@property (nonatomic) CGRect detailTextRect;

/**
*  日付スロットに表示される詳細テキストの色を取得または設定します。
*/
@property (nonatomic) UIColor *detailTextColor;

/**
*  詳細のフォントを取得または設定します。
*/
@property (nonatomic) UIFont *detailFont;

/**
*  新しく割り当てられた XuniCalendarDetailDaySlot オブジェクトを、指定されたカレンダーとフレーム四角形領域で初期化して返します。
*    @param calendar XuniCalendar オブジェクト
*    @param frame    XuniCalendarDetailDaySlot のフレーム四角形領域（ポイント単位）
*    @return 初期化された XuniCalendarDetailDaySlot オブジェクト。オブジェクトを作成できなかった場合は nil
*/
- (id)initWithCalendar:(XuniCalendar *)calendar frame:(CGRect)frame;

@end
