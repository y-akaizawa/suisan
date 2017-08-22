//
//  CalendarImageDaySlot.h
//  XuniCalendar
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "CalendarDaySlot.h"

/**
*  XuniCalendarImageDaySlot クラス
*    画像を含む日付スロットを表します。
*/
@interface XuniCalendarImageDaySlot : XuniCalendarDaySlot

/**
*  日付スロットに表示される画像ソースを取得または設定します。
*/
@property (nonatomic) UIImage *imageSource;

/**
*  その中に画像が表示される四角形領域を取得または設定します。
*/
@property (nonatomic) CGRect imageRect;

/**
*  画像のアスペクト比を取得または設定します。
*/
@property (nonatomic) XuniImageAspect imageAspect;

/**
*  新しく割り当てられた XuniCalendarImageDaySlot オブジェクトを、指定されたカレンダーとフレーム四角形で初期化して返します。
*    @param calendar XuniCalendar オブジェクト
*    @param frame    XuniCalendarImageDaySlot のフレーム四角形領域（ポイント単位）
*    @return 初期化された XuniCalendarImageDaySlot オブジェクト。オブジェクトを作成できなかった場合は nil
*/
- (id)initWithCalendar:(XuniCalendar *)calendar frame:(CGRect)frame;

@end
