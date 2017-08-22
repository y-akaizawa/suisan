//
//  ChartTooltip.h
//  XuniChartCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//


/**
*/
@class XuniBaseChartTooltipView;
/**
*/
@class FlexChartBase;

/**
*  XuniChartTooltip クラス
*/
@interface XuniChartTooltip : NSObject
{
/**
*/
    FlexChartBase* _chart;
}

/**
*  ツールチップの背景色を取得または設定します。
*/
@property (nonatomic) UIColor* backgroundColor;

/**
*  ツールチップのテキスト色を取得または設定します。
*/
@property (nonatomic) UIColor* textColor;

/**
*  ツールチップに表示する内容を取得または設定します。
*/
@property (nonatomic) XuniBaseChartTooltipView* content;

/**
*  ツールチップのギャップを取得または設定します。
*/
@property (nonatomic) double gap;

/**
*  ツールチップが表示されているかどうかを取得または設定します。
*/
@property (nonatomic) bool isVisible;

/**
*  ツールチップを表示する場合の遅延時間を取得または設定します。
*/
@property (nonatomic) long showDelay;

/**
*  ツールチップを非表示にする場合の遅延時間を取得または設定します。
*/
@property (nonatomic) long hideDelay;

/**
*  ツールチップを表示します。
*/
- (void)show;

/**
*  ツールチップを非表示にします。
*/
- (void)hide;

/**
*  XuniChartTooltip オブジェクトを初期化します。
*    @param chart   FlexChart オブジェクト
*    @param content コンテンツ
*    @return XuniChartTooltip オブジェクト
*/
-(id)init:(FlexChartBase*)chart content:(XuniBaseChartTooltipView*)content;

@end
