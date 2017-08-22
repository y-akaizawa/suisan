//
//  FlexChartDataLabelRenderer.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef FlexChartKit_h
#import "FlexChart.h"
#import "ChartDataLabel.h"
#endif

/**
*/
@class FlexChartDataLabel;

/**
*  FlexChartDataLabelRenderer クラス
*/
@interface FlexChartDataLabelRenderer : NSObject
{
/**
*/
    FlexChart *_chart;
/**
*/
    FlexChartDataLabel *_label;
}

/**
*  パラメータを指定して FlexChartDataLabelRenderer オブジェクトを初期化します。
*    @param chart FlexChart オブジェクト
*    @param label ラベル
*    @return FlexChartDataLabelRenderer オブジェクト
*/
-(id)init:(FlexChart *)chart label:(FlexChartDataLabel *)label;

/**
*  データラベルをレンダリングします。
*    @param seriesName  系列名
*    @param rect        四角形領域
*    @param seriesIndex 系列のインデックス
*    @param pointIndex  ポイントのインデックス
*    @param x           X の値
*    @param y           Y の値
*    @param valueX      Xのデータ値
*/
-(void)render:(NSString *)seriesName rect:(XuniRect *)rect seriesIndex:(NSInteger)seriesIndex pointIndex:(NSInteger)pointIndex x:(double)x y:(double)y valueX:(NSObject *)valueX;

/**
*  データラベルをレンダリングします。
*    @param seriesName 系列名
*    @param rect       四角形領域
*    @param seriesIndex 系列のインデックス
*    @param pointIndex  ポイントのインデックス
*    @param x          X の値
*    @param y          Y の値
*    @param valueX X のデータ値
*    @param bubbleSize バブルサイズ
*/
-(void)render:(NSString *)seriesName rect:(XuniRect *)rect seriesIndex:(NSInteger)seriesIndex pointIndex:(NSInteger)pointIndex x:(double)x y:(double)y valueX:(NSObject *)valueX bubbleSize:(double)bubbleSize;
@end


/**
*  クラス FleChartDataLabelData
*/
@interface FleChartDataLabelData : NSObject

/**
*  系列名を取得します。
*/
@property (readonly) NSString *seriesName;

/**
*  四角形領域を取得します
*/
@property (readonly) XuniRect *rect;

/**
*  系列のインデックスを取得します。
*/
@property (readonly) NSInteger seriesIndex;

/**
*  ポイントインデックスを取得します。
*/
@property (readonly) NSInteger pointIndex;

/**
*  X の値を取得します。
*/
@property (readonly) double dataX;

/**
*  Y の値を取得します。
*/
@property (readonly) double dataY;

/**
*  X のデータ値を取得します。
*/
@property (readonly) NSObject *valueX;

/**
*  パラメータを指定して FleChartDataLabelData オブジェクトを初期化します。
*    @param seriesName このデータラベルを所有する系列の名前
*    @param rect データラベルの四角形領域
*    @param seriesIndex このデータラベルを所有する系列のインデックス
*    @param pointIndex このデータラベルを所有する ItemsSource 内のオブジェクトのインデックス
*    @param dataX X の値
*    @param dataY Y の値
*    @param valueX X のデータ値
*    @return FleChartDataLabelData オブジェクト
*/
- (id)init:(NSString *)seriesName rect:(XuniRect *)rect seriesIndex:(NSInteger)seriesIndex pointIndex:(NSInteger)pointIndex dataX:(double)dataX dataY:(double)dataY valueX:(NSObject *)valueX;

@end
