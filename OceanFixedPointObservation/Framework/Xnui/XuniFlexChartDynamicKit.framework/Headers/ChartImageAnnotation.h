//
//  ChartImageAnnotation.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "ChartAnnotation.h"
#import "FlexChart.h"
#import <ImageIO/ImageIO.h>

/**
*  画像型注釈クラス
*/
@interface XuniChartImageAnnotation : XuniChartAnnotation<NSURLConnectionDataDelegate,NSURLConnectionDelegate>

/**
*  画像ソースを取得または設定します。
*/
@property (nonatomic) UIImage *source;

/**
*  XuniChartImageAnnotation クラスのインスタンスを初期化します。
*    @param chart 初期化に使用する FlexChart
*    @return XuniChartImageAnnotation クラスのインスタンス
*/
- (instancetype)initWithChart:(FlexChart *)chart;

/**
*  URL を使用して画像を設定します。
*    @param urlString URL 文字列
*/
- (void)setImageWithURL:(NSString *)urlString;

@end
