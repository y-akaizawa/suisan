//
//  FinancePlotter.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "IPlotter.h"

/**
*  XuniFinancePlotter クラス。
*/
@interface XuniFinancePlotter : XuniBasePlotter

/**
*  チャートを取得または設定します。
*/
@property FlexChart *chart;

/**
*  dataInfo を取得または設定します。
*/
@property XuniDataInfo *dataInfo;

/**
*  hitTester を取得または設定します。
*/
@property XuniHitTester *hitTester;

/**
*  系列のインデックスを取得または設定します。
*/
@property int seriesIndex;

/**
*  系列数を取得または設定します。
*/
@property int seriesCount;

/**
*  チャートの積層タイプを取得または設定します。
*/
@property XuniStacking stacking;

/**
*  プロットの方向を反転するかどうかを取得または設定します。
*/
@property BOOL rotated;

/**
*  ローソク足チャートかどうかを取得または設定します。
*/
@property BOOL isCandle;

/**
*  FinancePlotter のインスタンスを初期化します。
*    @param chart     FlexChart オブジェクト
*    @param dataInfo  dataInfo
*    @param hitTester 指定されたポイントにあるチャート要素
*    @return FinancePlotter のインスタンス
*/
- (id)init:(FlexChart*)chart dataInfo:(XuniDataInfo*)dataInfo hitTester:(XuniHitTester*)hitTester;
@end
