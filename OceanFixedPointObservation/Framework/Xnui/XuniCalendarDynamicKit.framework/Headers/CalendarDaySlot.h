//
//  CalendarDaySlot.h
//  XuniCalendar
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XUNI_INTERNAL_DYNAMIC_BUILD

#ifndef XuniCoreKit_h
#import "XuniCore/Drawing.h"
#endif

#else
#import "XuniCoreDynamicKit/XuniCoreDynamicKit.h"
#endif

#import "CalendarDaySlotBase.h"

/**
*/
@class XuniCalendar;

/**
*  XuniCalendarDaySlot クラス
*    デフォルトの日付スロットビューを表します。
*/
@interface XuniCalendarDaySlot : XuniCalendarDaySlotBase

/**
*  日スロットに表示される日テキストを取得または設定します。
*/
@property (nonatomic) NSString *dayText;

/**
*  日付テキストが表示される四角形領域を取得または設定します。
*/
@property (nonatomic) CGRect dayTextRect;

/**
*  日テキストの色を取得または設定します。
*/
@property (nonatomic) UIColor *dayTextColor;

/**
*  日テキストのフォントを取得または設定します。
*/
@property (nonatomic) UIFont *dayFont;

/**
*  日付スロット内のコンテンツの隙間（Padding）を取得または設定します。
*/
@property (nonatomic) double padding;

/**
*  日付の水平位置を取得または設定します。
*/
@property (nonatomic) XuniHorizontalAlignment dayHorizontalAlignment;

/**
*  日付のの垂直位置を取得または設定します。
*/
@property (nonatomic) XuniVerticalAlignment dayVerticalAlignment;

/**
*  新しく割り当てられた XuniCalendarDaySlot オブジェクトを、指定されたカレンダーとフレーム四角形領域で初期化して返します。
*    @param calendar XuniCalendar オブジェクト
*    @param frame    XuniCalendarDaySlot のフレーム四角形領域（ポイント単位）
*    @return 初期化された XuniCalendarDaySlot オブジェクト。オブジェクトを作成できなかった場合は nil
*/
- (id)initWithCalendar:(XuniCalendar *)calendar frame:(CGRect)frame;

@end
