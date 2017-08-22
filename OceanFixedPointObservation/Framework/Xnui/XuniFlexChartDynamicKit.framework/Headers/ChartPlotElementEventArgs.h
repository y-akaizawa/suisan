//
//  ChartPlotElementEventArgs.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XuniCoreKit_h
#import "XuniCore/Event.h"
#endif

/**
*/
@class XuniChartHitTestInfo;
/**
*/
@class XuniChartDataPoint;
/**
*/
@class BasePlotElementRender;

/**
*  ChartPlotElement イベントのイベント引数
*/
@interface XuniChartPlotElementEventArgs : XuniEventArgs

/**
*  レンダリングエンジンを取得または設定します。
*/
@property (nonatomic) NSObject<IXuniRenderEngine> *renderEngine;

/**
*  ヒットテスト情報（ XuniChartHitTestInfo ）を取得または設定します。
*/
@property (nonatomic) XuniChartHitTestInfo *hitTestInfo;

/**
*  データポイントを取得または設定します。
*/
@property (nonatomic) XuniChartDataPoint *dataPoint;

/**
*  デフォルトのレンダラーを取得または設定します。
*/
@property (nonatomic) BasePlotElementRender *defaultRender;
/**
*  ローソク足チャートのローソクの塗りつぶし色を取得または設定します。始値 ＞ 終値 または 終値 ＞ 始値の場合。
*/
@property (nonatomic) UIColor *candleFillColor;
/**
*  ローソク足チャートのローソクの境界線の色を取得または設定します。
*/
@property (nonatomic) UIColor *candleBorderColor;

/**
*  ChartPlotElementEventArgs のインスタンスを初期化します。
*    @param renderEngine レンダリングエンジン
*    @param hitTestInfo ヒットテスト情報
*    @param dataPoint データポイント
*    @param defaultRender デフォルトのレンダラ
*    @return ChartPlotElementEventArgs のインスタンス
*/
- (id)init:(NSObject<IXuniRenderEngine> *)renderEngine hitTestInfo:(XuniChartHitTestInfo *)hitTestInfo dataPoint:(XuniChartDataPoint *)dataPoint defaultRender:(BasePlotElementRender *)defaultRender;

@end
