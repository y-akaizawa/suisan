//
//  XuniCalendar.h
//  XuniCalendar
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "XuniCalendarEnums.h"
#import <CoreText/CoreText.h>

#ifndef XUNI_INTERNAL_DYNAMIC_BUILD

#ifndef XuniCoreKit_h
#import "XuniCore/XuniView.h"
#endif

#else
#import "XuniCoreDynamicKit/XuniCoreDynamicKit.h"

#endif

/**
*/
@class XuniEvent;
/**
*/
@protocol IXuniValueFormatter;
/**
*/
@protocol XuniCalendarDelegate;
/**
*/
@protocol IDaySlotTemplate;
/**
*/
@protocol IDayOfWeekSlotTemplate;
/**
*/
@protocol IAdjacentDaySlotTemplate;
/**
*/
@class XuniCalendarDaySlot;
/**
*/
@class XuniCalendarRange;
/**
*/
@class XuniAnimation;
/**
*/
@class XuniCalendarViewModeAnimation;


/**
*  XuniCalendar クラス
*/
IB_DESIGNABLE
/**
*/
@interface XuniCalendar : XuniView

// Properties about calendar.
//*******************************

/**
*  通知を処理するためのデリゲートを取得または設定します。
*/
@property (nonatomic, weak) id<XuniCalendarDelegate> delegate;

/**
*  Xamarin Form 上のカレンダーのサイズを取得または設定します。
*/
@property (nonatomic) CGSize xfCalendarSize;

/**
*  カレンダー内のテキストの色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *textColor;

/**
*  カレンダーの背景色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *backgroundColor;

/**
*  カレンダーの境界線の色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *borderColor;

@property (nonatomic) IBInspectable double borderWidth;

/**
*  カレンダーに月、年、または 10 年ビューのどれを表示するかを示す値を取得または設定します。
*/
@property (nonatomic) XuniCalendarViewMode viewMode;

/**
*  現在表示されている年の日付を指定する値を取得または設定します。
*/
@property (nonatomic) NSDate *displayDate;

/**
*  カレンダーで選択できる最終日を取得または設定します。
*/
@property (nonatomic) NSDate *maxDate;

/**
*  ユーザーがカレンダーで選択できる最初の日を取得または設定します。
*/
@property (nonatomic) NSDate *minDate;

/**
*  週の最初の曜日（カレンダーの最初の列に表示される曜日）を取得または設定します。
*/
@property (nonatomic) XuniDayOfWeek firstDayOfWeek;

/**
*  カレンダーのフォントを取得または設定します。
*/
@property (nonatomic) UIFont *calendarFont;

/**
*  ナビゲーション中にコントロールがアニメーション表示されるかどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL isAnimated;

/**
*  コントロールが有効にされているかどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL isEnabled;

/**
*  選択できる最大の日数を取得または設定します。
*/
@property (nonatomic) IBInspectable int maxSelectionCount;

/**
*  カレンダーを前方向または後方向に、めくる操作するときに適用されるアニメーション設定を含むオブジェクトを取得または設定します。
*/
@property (nonatomic) XuniAnimation *navigateAnimation;

/**
*  viewMode の変更時に適用されるアニメーション設定を含むオブジェクトを取得または設定します。
*/
@property (nonatomic) XuniCalendarViewModeAnimation *viewModeAnimation;

/**
*  カレンダーをナビゲートする方向を示す値を取得または設定します。
*/
@property (nonatomic) XuniCalendarOrientation orientation;

/**
*  コントロールがデフォルトのナビゲーションボタンを表示するかどうかを示す値を取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL showNavigationButtons;

/**
*  コントロールに現在の月およびナビゲーションボタンを含むヘッダー領域を表示するかどうかを示す値を取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL showHeader;

/**
*  カレンダー内の使用不可テキストの色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *disabledTextColor;


// Properties about adjacent day.
//*******************************

/**
*  カレンダー内の 1 つの隣接日の UI 表現を定義するデータテンプレートを取得または設定します。
*/
@property (nonatomic) id<IAdjacentDaySlotTemplate> adjacentDaySlotTemplate;

/**
*  隣接日テキストの色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *adjacentDayTextColor;


// Properties about day.
//*******************************

/**
*  日付スロット間の境界線に使用する色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *dayBorderColor;

/**
*  日付スロット間の境界線の幅を取得または設定します。
*/
@property (nonatomic) IBInspectable double dayBorderWidth;

/**
*  月の 1 つの日の UI 表現を定義するデータテンプレートを取得または設定します。
*/
@property (nonatomic) id<IDaySlotTemplate> daySlotTemplate;


// Properties about today.
//*******************************

/**
*  本日スロットの背景の強調表示に使用される色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *todayBackgroundColor;

/**
*  本日スロットのテキストの色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *todayTextColor;

/**
*  今日のフォントを取得または設定します。
*/
@property (nonatomic) UIFont *todayFont;


// Properties about week.
//*******************************

/**
*  曜日スロットの背景色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *dayOfWeekBackgroundColor;

/**
*  曜日のフォントを取得または設定します。
*/
@property (nonatomic) UIFont *dayOfWeekFont;

/**
*  曜日名を表すために使用する書式を取得または設定します。
*/
@property (nonatomic) XuniDayOfWeekFormat dayOfWeekFormat;

/**
*  曜日の UI 表現を定義するデータテンプレートを取得または設定します。
*/
@property (nonatomic) id<IDayOfWeekSlotTemplate> dayOfWeekSlotTemplate;

/**
*  曜日スロットに表示されるテキストの色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *dayOfWeekTextColor;


// Properties about header.
//*******************************

/**
*  ヘッダーの背景色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *headerBackgroundColor;

/**
*  ヘッダーのフォントを取得または設定します。
*/
@property (nonatomic) UIFont *headerFont;

/**
*  ヘッダーテキストの色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *headerTextColor;

/**
*  ヘッダーに表示するテキストの書式を取得または設定します。
*/
@property (nonatomic) IBInspectable NSString * headerMonthFormat;

/**
*  値の書式を取得または設定します。
*/
@property (nonatomic) NSObject<IXuniValueFormatter> *valueFormatter;

/**
*  headerLoading イベントを取得または設定します。
*/
@property (nonatomic) XuniEvent *headerLoading;

// Properties about selection.
//*******************************

/**
*  現在選択されている日付を取得または設定します。
*/
@property (nonatomic) NSDate *selectedDate;

/**
*  選択中の日付のリストを取得または設定します。
*/
@property (nonatomic) XuniCalendarRange *selectedDates;

/**
*  選択された日付を強調表示するために使用される色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *selectionBackgroundColor;

/**
*  選択された日付テキストの色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *selectionTextColor;

/**
*  フォントのディスクリプタを取得します。
*    @param attributes フォント属性
*    @return フォントディスクリプタ
*/
- (UIFontDescriptor *)getDecriptor:(NSMutableDictionary *)attributes;

/**
*  画像フォームの URL を文字列で取得します。
*    @param urlString URL 文字列
*    @return UIImage
*/
- (UIImage *)getImage:(NSString *)urlString;

/**
*  カレンダーコントロールをリフレッシュします。
*/
- (void)refresh;

/**
*  非同期にビューモードを変更してアニメーションを実行します。
*    @param mode ビューモード
*    @param date 表示日付
*/
- (void)changeViewModeAsync:(XuniCalendarViewMode)mode date:(NSDate *)date;

/**
*  カレンダーコントロールを前方向に操作してめくります。
*/
- (void)goForwardAsync;

/**
*  カレンダーコントロールを後にナビゲートします。
*/
- (void)goBackwardAsync;

@end
