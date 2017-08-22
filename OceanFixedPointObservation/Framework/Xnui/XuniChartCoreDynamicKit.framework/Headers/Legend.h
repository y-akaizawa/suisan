//
//  Legend.h
//  XuniChartCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "FlexChartBaseEnums.h"

/**
*/
@class FlexChartBase;
/**
*/
@class XuniRenderEngine;

/**
*  グラフの凡例を表します。
*/
@interface XuniLegend : NSObject

/**
*  凡例の位置を取得または設定します。
*/
@property (nonatomic,getter=getPosition) XuniChartLegendPosition position;

/**
*  凡例の背景色を取得または設定します。
*/
@property (nonatomic) UIColor *backgroundColor;

/**
*  凡例の境界線の色を取得または設定します。
*/
@property (nonatomic) UIColor *borderColor;

/**
*  凡例の境界線の幅を取得または設定します。
*/
@property (nonatomic) double borderWidth;

/**
*  凡例ラベルのフォントを取得または設定します。
*/
@property (nonatomic) UIFont *labelFont;

/**
*  凡例ラベルのテキスト色を取得または設定します。
*/
@property (nonatomic) UIColor *labelTextColor;

// Internal properties
// removed :

/**
*  凡例が縦に配置されているかどうかを取得します。
*/
@property (readonly) BOOL isVertical;

/**
*  凡例の方向を取得または設定します。
*/
@property (nonatomic, getter=getOrientation) XuniChartLegendOrientation orientation;

// Internal methods

/**
*  XuniLegend オブジェクトを初期化します。
*    @param chart FlexChart オブジェクト
*    @return XuniLegend オブジェクト
*/
- (id)initForChart:(FlexChartBase*)chart;

/**
*  表示するために適切なサイズを取得します。
*    @param engine レンダリングエンジン
*    @return 適切なサイズ
*/
- (XuniSize*)getDesiredSize:(XuniRenderEngine*)engine;

/**
*  ポイントに凡例をレンダリングします。
*    @param engine レンダリングエンジン
*    @param point  ポイント
*/
- (void)render:(XuniRenderEngine*)engine atPoint:(XuniPoint*)point;

/**
*  ポイントがどの領域にあるかを判定します。
*    @param point ポイント
*    @return 領域のインデックス
*/
- (int)hitTest:(XuniPoint*)point;

@end
