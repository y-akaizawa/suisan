//
//  BarPlotter.h
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
*  XuniBarPlotter クラス
*/
@interface XuniBarPlotter : XuniBasePlotter

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
*  BarPlotter のインスタンスを初期化します。
*    @param chart     FlexChart オブジェクト
*    @param dataInfo  dataInfo
*    @param hitTester 指定されたポイントにあるチャート要素
*    @return BarPlotter のインスタンス
*/
- (id)init:(FlexChart*)chart dataInfo:(XuniDataInfo*)dataInfo hitTester:(XuniHitTester*)hitTester;
@end
