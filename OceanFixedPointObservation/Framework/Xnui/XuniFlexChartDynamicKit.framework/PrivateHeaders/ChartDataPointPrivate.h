//
//  ChartDataPointPrivate.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef FlexChart_ChartDataPointPrivate_h
#define FlexChart_ChartDataPointPrivate_h

/**
*  XuniChartDataPoint クラス
*/
@interface XuniChartDataPoint ()

/**
*  このデータポイントのバブルサイズを取得または設定します。
*/
@property double bubbleSize;

/**
*  このデータポイントの高値を取得または設定します。
*/
@property double high;

/**
*  このデータポイントの低値を取得または設定します。​
*/
@property double low;

/**
*  このデータポイントの始値を取得または設定します。
*/
@property double open;

/**
*  このデータポイントの終値を取得または設定します。
*/
@property double close;

/**
*  このデータポイントの系列インデックスを取得または設定します。
*/
@property int seriesIndex;

/**
*  このデータポイントの系列名を取得または設定します。
*/
@property NSString *seriesName;

/**
*  このデータポイントの X 値をオブジェクトとして取得または設定します。
*/
@property NSObject *valueX;

/**
*  このデータポイントの X 値を取得または設定します。
*/
@property double dataX;

/**
*  このデータポイントのX 座標を取得または設定します。
*/
@property double x;

/**
*  このデータポイントのY 座標を取得または設定します。
*/
@property double y;

@end

#endif
