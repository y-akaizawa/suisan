//
//  CalendarYearSlot.h
//  XuniCalendar
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

/**
*  XuniCalendarの年スロットの基底クラス
*/
@interface XuniCalendarYearSlotBase : UIView

@end

/**
*  XuniCalendarYearSlot クラス
*    デフォルトの年スロットビューを表します。
*/
@interface XuniCalendarYearSlot : XuniCalendarYearSlotBase

/**
*  年スロットに表示されるテキストを取得または設定します。
*/
@property (nonatomic) NSString *yearText;

/**
*  年のテキスト色を取得または設定します。
*/
@property (nonatomic) UIColor *yearTextColor;

/**
*  年のフォントを取得または設定します。
*/
@property (nonatomic) UIFont *yearFont;

/**
*  年スロットの隙間（Padding）を取得または設定します。
*/
@property (nonatomic) UIEdgeInsets padding;

/**
*  年の水平位置を取得または設定します。
*/
@property (nonatomic) XuniHorizontalAlignment yearHorizontalAlignment;

/**
*  年の垂直位置を取得または設定します。
*/
@property (nonatomic) XuniVerticalAlignment yearVerticalAlignment;

/**
*  年スロットのフレームを設定します。
*    @param frame フレーム
*/
- (void)setYearSlotFrame:(CGRect)frame;

@end
