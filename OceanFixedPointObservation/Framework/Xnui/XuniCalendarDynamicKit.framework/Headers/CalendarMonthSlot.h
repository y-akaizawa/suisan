//
//  CalendarMonthSlot.h
//  XuniCalendar
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XuniCoreKit_h
#import "XuniCore/Drawing.h"
#endif

/**
*/
@class XuniCalendar;

/**
*  XuniCalendar の月スロットの基底クラスです。
*/
@interface XuniCalendarMonthSlotBase : UIView

@end

/**
*  XuniCalendarMonthSlot クラス
*    デフォルトの月スロットビューを表します。
*/
@interface XuniCalendarMonthSlot : XuniCalendarMonthSlotBase

/**
*  月スロットに表示する月のテキストを取得または設定します。
*/
@property (nonatomic) NSString *monthText;

/**
*  月表示の垂直位置を取得または設定します。
*/
@property (nonatomic) UIColor *monthTextColor;

/**
*  月を表示するフォントを取得または設定します。
*/
@property (nonatomic) UIFont *monthFont;

/**
*  月スロット内のコンテンツの隙間（Padding）を取得または設定します。
*/
@property (nonatomic) UIEdgeInsets padding;

/**
*  月表示の水平位置を取得または設定します。
*/
@property (nonatomic) XuniHorizontalAlignment monthHorizontalAlignment;

/**
*  月表示の垂直位置を取得または設定します。
*/
@property (nonatomic) XuniVerticalAlignment monthVerticalAlignment;

/**
*  月スロットのフレームを設定します。
*    @param frame フレーム
*/
- (void)setMonthSlotFrame:(CGRect)frame;

@end
