//
//  ChartOptions.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef FlexChartKit_h
#import "FlexChart.h"
#endif

#import <Foundation/Foundation.h>

/**
*  FlexChartOptions
*/
@interface FlexChartOptions : NSObject

/**
*  バブルの最小サイズを取得または設定します。
*/
@property(nonatomic)  float bubbleMinSize;
/**
*  バブルの最大サイズを取得または設定します。
*/
@property(nonatomic)  float bubbleMaxSize;
/**
*  グループ幅を取得または設定します。
*/
@property(nonatomic)  float groupWidth;
/**
*  ローソク足の幅を取得または設定します。
*/
@property(nonatomic) float candleWidth;

/**
*  FlexChartOptions オブジェクトを初期化します。
*    @param chart FlexChart オブジェクト
*    @return FlexChartOptions オブジェクト
*/
-(id)init:(FlexChart*)chart;

@end
