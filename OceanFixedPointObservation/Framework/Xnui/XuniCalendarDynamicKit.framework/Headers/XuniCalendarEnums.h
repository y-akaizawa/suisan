//
//  XuniCalendarEnums.h
//  XuniCalendar
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XuniCalendarEnums_h
#define XuniCalendarEnums_h

/**
*  曜日の表示書式を指定します。
*/
typedef NS_ENUM(NSInteger, XuniDayOfWeekFormat) {
/**
*  曜日の書式（D）
*/
    XuniDayOfWeekFormatD,
/**
*  曜日の書式（DDD）
*/
    XuniDayOfWeekFormatDDD,
/**
*  曜日の書式（DDDD）
*/
    XuniDayOfWeekFormatDDDD
};

/**
*  カレンダーの表示モードを指定する列挙型
*/
typedef NS_ENUM(NSInteger, XuniCalendarViewMode) {
/**
*  表示モードが月ビュー
*/
    XuniCalendarViewModeMonth,
/**
*  表示モードが年ビュー
*/
    XuniCalendarViewModeYear,
/**
*  表示モードが10年ビュー
*/
    XuniCalendarViewModeDecade
};

/**
*  曜日を指定する列挙型
*/
typedef NS_ENUM(NSInteger, XuniDayOfWeek) {
/**
*  曜日なし
*/
    XuniDayOfWeekNone,
/**
*  日曜日
*/
    XuniDayOfWeekSunday,
/**
*  月曜日
*/
    XuniDayOfWeekMonday,
/**
*  火曜日
*/
    XuniDayOfWeekTuesday,
/**
*  水曜日
*/
    XuniDayOfWeekWednesday,
/**
*  木曜日
*/
    XuniDayOfWeekThursday,
/**
*  金曜日
*/
    XuniDayOfWeekFriday,
/**
*  土曜日
*/
    XuniDayOfWeekSaturday
};

/**
*  カレンダーのめくり操作方向を指定する列挙型
*/
typedef NS_ENUM(NSInteger, XuniCalendarOrientation) {
/**
*  カレンダー表示は水平方向
*/
    XuniCalendarOrientationHorizontal,
/**
*  カレンダー表示は垂直方向
*/
    XuniCalendarOrientationVertical
};

/**
*  カレンダービューモードの変更時のアニメーションモードを指定します。
*/
typedef NS_ENUM(NSInteger, XuniCalendarViewAnimationMode) {
/**
*  このアニメーションは、設定対象のビューに応じて、ビューを前後に移動します。
*/
    XuniCalendarViewAnimationModeZoom,
/**
*  このアニメーションは、現在のビューを縮小し、新しいビューを拡大します。
*/
    XuniCalendarViewAnimationModeZoomOutIn
};

/**
*  日付スロットの表示モードを指定する列挙型
*/
typedef NS_ENUM(NSInteger, XuniDaySlotState) {
/**
*  日付スロットが通常の状態
*/
    XuniDaySlotStateNormal,
/**
*  今日の日付スロット
*/
    XuniDaySlotStateToday,
/**
*  日付スロットの隣接日の状態
*/
    XuniDaySlotStateAdjacent,
/**
*  日付スロットが選択された状態
*/
    XuniDaySlotStateSelected,
/**
*  日付スロットが無効
*/
    XuniDaySlotStateDisabled
};

/**
*  画像アスペクト比を指定します。
*/
typedef NS_ENUM(NSInteger, XuniImageAspect) {
/**
*  画像全体をアスペクト比を維持して描画
*/
    XuniImageAspectFit,
/**
*  画像をアスペクト比を維持して全体に描画
*/
    XuniImageAspectFill,
/**
*  画像を全体に描画
*/
    XuniImageFill
};

#endif /* XuniCalendarEnums_h */
