//
//  ChartTextAnnotation.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "ChartAnnotation.h"
/**
*/
@class FlexChart;
/**
*  テキスト型注釈クラス
*/
@interface XuniChartTextAnnotation : XuniChartAnnotation

/**
*  注釈のテキストを取得または設定します。
*/
@property (nonatomic) NSString *text;

/**
*  注釈のテキスト色を取得または設定します。
*/
@property (nonatomic) UIColor *textColor;

/**
*  注釈のフォントを取得または設定します。
*/
@property (nonatomic) UIFont *font;

/**
*  XuniChartTextAnnotation クラスのインスタンスを初期化します。
*    @param chart 初期化に使用する FlexChart
*    @return XuniChartTextAnnotation クラスのインスタンス
*/
- (instancetype)initWithChart:(FlexChart *)chart;

@end
