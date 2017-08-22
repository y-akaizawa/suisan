//
//  DefaultChartDataLabelRenderer.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef FlexChartKit_h
#import "FlexChartDataLabelRenderer.h"
#endif

/**
*  DefaultChartDataLabelRenderer クラス
*/
@interface DefaultChartDataLabelRenderer : FlexChartDataLabelRenderer

/**
*  パラメータを指定して DefaultChartDataLabelRenderer オブジェクトを初期化します。
*    @param chart FlexChart オブジェクト
*    @param label ラベル
*    @return DefaultChartDataLabelRenderer オブジェクト
*/
-(id)init:(FlexChart *)chart label:(FlexChartDataLabel *)label;


@end
