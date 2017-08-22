//
//  ChartHitTestInfo.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XUNI_INTERNAL_DYNAMIC_BUILD

#ifndef XuniChartCoreKit_h
#import "XuniChartCore/HitTestInfo.h"
#endif

#else
#import "XuniCoreDynamicKit/XuniCoreDynamicKit.h"
#import "XuniChartCoreDynamicKit/XuniChartCoreDynamicKit.h"
#endif

/**
*/
@class FlexChart;
/**
*/
@class XuniChartDataPoint;
/**
*/
@class XuniChartAnnotation;

/**
*  XuniChartHitTestInfo クラス
*/
@interface XuniChartHitTestInfo : XuniHitTestInfo

/**
*  内部でヒットテストが発生した FlexChart オブジェクトを取得します。
*/
@property (readonly) FlexChart *chart;

/**
*  XuniChartHitTestInfo オブジェクトのデータポイントを取得します。
*/
@property (readonly) XuniChartDataPoint *dataPoint;

/**
*  チャートの選択された要素タイプを取得します。
*/
@property (readonly) XuniChartElement chartElement;

/**
*  最も近いデータポイントとの距離を取得します。
*/
@property (readonly) double distance;

/**
*  選択された注釈（アノテーション）を取得または設定します。
*/
@property (nonatomic) XuniChartAnnotation *annotation;

/**
*  XuniChartHitTestInfo オブジェクトを初期化します。.
*    @param chart FlexChart オブジェクト
*    @param x     X 座標
*    @param y     Y 座標
*    @return XuniChartHitTestInfo オブジェクト
*/
- (id)initWithChart:(FlexChart *)chart x:(double)x y:(double)y;

@end
