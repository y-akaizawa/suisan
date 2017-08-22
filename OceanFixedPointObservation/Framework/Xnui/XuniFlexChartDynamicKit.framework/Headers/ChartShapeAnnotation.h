//
//  ChartShapeAnnotation.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "ChartTextAnnotation.h"

/**
*  図形注釈クラス
*/
@interface XuniChartShapeAnnotation : XuniChartTextAnnotation

/**
*  注釈の塗りつぶし色を取得または設定します。
*/
@property (nonatomic) UIColor *color;

/**
*  注釈の境界線色を取得または設定します。
*/
@property (nonatomic) UIColor *borderColor;

/**
*  ​注釈の境界線幅を取得または設定します。
*/
@property (nonatomic) double borderWidth;

/**
*  XuniChartShapeAnnotation クラスのインスタンスを初期化します。
*    @param chart 初期化に使用する FlexChart
*    @return XuniChartShapeAnnotation クラスのインスタンス
*/
- (instancetype)initWithChart:(FlexChart *)chart;

/**
*  チャートを取得します。
*    @return チャート
*/
- (FlexChart *)getChart;

@end
