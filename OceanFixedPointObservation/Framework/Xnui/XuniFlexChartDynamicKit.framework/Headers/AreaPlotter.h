//
//  AreaPlotter.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "IPlotter.h"

/**
*/
@class FlexChart;
/**
*/
@class XuniDataInfo;
/**
*/
@class XuniHitTester;

/**
*  XuniAreaPlotter クラス
*/
@interface XuniAreaPlotter : XuniBasePlotter

/**
*  チャートを取得または設定します。
*/
@property FlexChart *chart;

/**
*  dataInfo を取得または設定します。
*/
@property XuniDataInfo *dataInfo;

/**
*  指定されたポイントにあるチャート要素を取得または設定します。
*/
@property XuniHitTester *hitTester;

/**
*  チャートの積層タイプを取得または設定します。
*/
@property XuniStacking stacking;

/**
*  プロットの方向を反転するかどうかを取得または設定します。
*/
@property BOOL rotated;

/**
*  スプラインチャートかどうかを取得または設定します。
*/
@property BOOL isSpline;

/**
*  AreaPlotter のインスタンスを初期化します。
*    @param chart     チャート
*    @param dataInfo  dataInfo
*    @param hitTester 指定されたポイントにあるチャート要素
*    @return AreaPlotter のインスタンス
*/
- (id)init:(FlexChart*)chart dataInfo:(XuniDataInfo*)dataInfo hitTester:(XuniHitTester*)hitTester;
@end
