//
//  ChartDataPoint.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XUNI_INTERNAL_DYNAMIC_BUILD

#ifndef XuniChartCoreKit_h
#import "XuniChartCore/DataPoint.h"
#endif

#else
#import "XuniCoreDynamicKit/XuniCoreDynamicKit.h"
#import "XuniChartCoreDynamicKit/XuniChartCoreDynamicKit.h"
#endif


/**
*  XuniChartDataPoint クラス
*/
@interface XuniChartDataPoint : XuniDataPoint

/**
*  このデータポイントのバブルサイズを取得します。
*/
@property (readonly) double bubbleSize;

/**
*  このデータポイントの高値を取得します。
*/
@property (readonly) double high;

/**
*  このデータポイントの低値を取得します。​
*/
@property (readonly) double low;

/**
*  このデータポイントの始値を取得します。
*/
@property (readonly) double open;

/**
*  このデータポイントの終値を取得します。
*/
@property (readonly) double close;

/**
*  このデータポイントの系列インデックスを取得します。​
*/
@property (readonly) int seriesIndex;

/**
*  このデータポイントの系列名を取得します。​
*/
@property (readonly) NSString *seriesName;

/**
*  このデータポイントの X 値をオブジェクトとして取得します。​
*/
@property (readonly) NSObject *valueX;

/**
*  このデータポイントのX 座標を取得します。
*/
@property (readonly) double x;

/**
*  このデータポイントのY 座標を取得します。
*/
@property (readonly) double y;

@end
