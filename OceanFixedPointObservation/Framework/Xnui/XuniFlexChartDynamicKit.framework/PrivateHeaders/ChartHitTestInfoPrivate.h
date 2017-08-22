//
//  ChartHitTestInfoPrivate.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef FlexChart_ChartHitTestInfoPrivate_h
#define FlexChart_ChartHitTestInfoPrivate_h

/**
*/
@class FlexChart;
/**
*/
@class XuniChartDataPoint;
/**
*/
@protocol IXuniHitArea;

/**
*  XuniChartHitTestInfo クラス
*/
@interface XuniChartHitTestInfo ()

/**
*  内部でヒットテストが発生した FlexChart オブジェクトを取得または設定します。
*/
@property FlexChart *chart;

/**
*  XuniChartHitTestInfo オブジェクトのデータポイントを取得または設定します。
*/
@property XuniChartDataPoint *dataPoint;

/**
*  チャートの選択された要素タイプを取得または設定します。
*/
@property XuniChartElement chartElement;

/**
*  最も近いデータポイントとの距離を取得または設定します。
*/
@property double distance;

/**
*  ヒットエリアを取得または設定します。
*/
@property NSObject<IXuniHitArea> *area;

/**
*  XuniChartHitTestInfo オブジェクトの系列を取得または設定します。
*/
@property (nonatomic) XuniSeries *series;

@end

#endif
