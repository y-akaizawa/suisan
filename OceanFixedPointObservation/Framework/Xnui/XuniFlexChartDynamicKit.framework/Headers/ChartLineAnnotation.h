//
//  ChartLineAnnotation.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "ChartAnnotation.h"

/**
*  線型注釈クラス
*/
@interface XuniChartLineAnnotation : XuniChartAnnotation

/**
*  ​線型注釈の開始点を取得または設定します。
*/
@property (nonatomic) XuniPoint *start;

/**
*  ​線型注釈の終了点を取得または設定します。
*/
@property (nonatomic) XuniPoint *end;

/**
*  ​​線の色を取得または設定します。
*/
@property (nonatomic) UIColor *color;

/**
*  線の幅を取得または設定します。
*/
@property (nonatomic) double lineWidth;

/**
*  XuniChartLineAnnotation クラスのインスタンスを初期化します。
*    @param chart 初期化に使用する FlexChart
*    @return XuniChartLineAnnotation クラスのインスタンス
*/
- (instancetype)initWithChart:(FlexChart *)chart;

@end
