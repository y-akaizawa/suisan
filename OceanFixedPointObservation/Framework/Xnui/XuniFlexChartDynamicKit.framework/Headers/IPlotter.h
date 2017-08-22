//
//  IPlotter.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XUNI_INTERNAL_DYNAMIC_BUILD

#ifndef XuniChartCoreKit_h
#import "XuniChartCore/FlexChartBase.h"
#endif

#else
#import "XuniChartCoreDynamicKit/XuniChartCoreDynamicKit.h"
#endif


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
*/
@class XuniObservableArray;
/**
*/
@protocol IXuniRenderEngine;
/**
*/
@protocol IXuniAxis;
/**
*/
@protocol IXuniSeries;
/**
*/
@protocol IXuniPalette;



/**
*  IXuniPlotter プロトコル
*/
@protocol IXuniPlotter
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
*  時刻を取得または設定します。
*/
@property double time;

/**
*  dataInfoCount を取得または設定します。
*/
@property int dataInfoCount;

/**
*  シンボルのサイズを取得または設定します。
*/
@property double symbolSize;

/**
*  プロットされた系列の原点を取得または設定します。
*/
@property double origin;

/**
*  リセットします。
*/
- (void)clear;

/**
*  チャートの四角形の計算に使用します。
*    @param dataInfo チャートのデータと情報を含むインスタンス
*    @param logBase  logBase 値
*    @return チャートの四角形領域
*/
- (XuniRect*)adjustLimits:(XuniDataInfo*)dataInfo logBase:(NSNumber*)logBase;

/**
*  チャートタイプを変更したときにチャートの描画に使用されるメソッド。
*    @param engine IXuniRenderEngine オブジェクト
*/
- (void)redoSelection:(NSObject<IXuniRenderEngine>*)engine;

/**
*  実際の長さを取得します。
*    @param seriesCollection 系列のコレクション
*    @return 実際の長さ
*/
- (int)getRealLen:(XuniObservableArray*)seriesCollection;

/**
*  系列のプロットに使用する特定のメソッド。
*    @param series 系列
*    @param engine エンジン
*    @param ax X 軸
*    @param ay Y 軸
*    @param iser seriesCollection 内の系列のインデックス
*    @param irealser 表示されている系列だけをカウントする場合の系列のインデックス
*    @param nser seriesCollection のサイズ
*    @param sel seriesCollection 内の選択された系列のインデックス
*    @param chartType プロットするチャートのタイプ
*    @param stackPos 正の値の内部スタック
*    @param stackNeg 負の値の内部スタック
*/
- (void)plotSeries:(NSObject<IXuniSeries>*)series engine:(NSObject<IXuniRenderEngine>*)engine axisX:(NSObject<IXuniAxis>*)ax axisY:(NSObject<IXuniAxis>*)ay index:(int)iser realIndex:(int)irealser count:(int)nser selectedIndex:(int)sel chartType:(XuniChartType)chartType stackPos:(NSMutableDictionary *)stackPos stackNeg:(NSMutableDictionary *)stackNeg;

/**
*  系列のプロットに使用する特定のメソッド
*    @param seriesCollection プロットする seriesCollection
*    @param engine レンダリングエンジン
*    @param ax X 軸
*    @param ay Y 軸
*    @param selection 選択された系列
*    @param isel seriesCollection 内の選択された系列のインデックス
*    @param stackPos 正の値の内部スタック
*    @param stackNeg 負の値の内部スタック
*/
- (void)plotSeriesCollection:(XuniObservableArray*)seriesCollection engine:(NSObject<IXuniRenderEngine>*)engine axisX:(NSObject<IXuniAxis>*)ax axisY:(NSObject<IXuniAxis>*)ay selectedSeries:(NSObject<IXuniSeries>*)selection elementIndex:(int)isel stackPos:(NSMutableDictionary *)stackPos stackNeg:(NSMutableDictionary *)stackNeg;

@end

/**
*  XuniBasePlotter クラス
*/
@interface XuniBasePlotter : NSObject<IXuniPlotter>

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
*  時刻を取得または設定します。
*/
@property double time;

/**
*  dataInfoCount を取得または設定します。
*/
@property int dataInfoCount;

/**
*  シンボルのサイズを取得または設定します。
*/
@property double symbolSize;

/**
*  プロットされた系列の原点を取得または設定します。
*/
@property double origin;

/**
*  LinePlotter のインスタンスを初期化します。
*    @param chart チャート
*    @return LinePlotter のインスタンス
*/
- (id)init:(FlexChart*)chart;

/**
*  実際の長さを取得します。
*    @param seriesCollection 系列のコレクション
*    @return 実際の長さ
*/
- (int)getRealLen:(XuniObservableArray*)seriesCollection;

/**
*  系列のプロットに使用する特定のメソッド。
*    @param series 系列
*    @param engine エンジン
*    @param ax X 軸
*    @param ay Y 軸
*    @param iser seriesCollection 内の系列のインデックス
*    @param irealser 表示されている系列だけをカウントする場合の系列のインデックス
*    @param nser seriesCollection のサイズ
*    @param sel seriesCollection 内の選択された系列のインデックス
*    @param chartType プロットするチャートのタイプ
*    @param stackPos 正の値の内部スタック
*    @param stackNeg 負の値の内部スタック
*/
- (void)plotSeries:(NSObject<IXuniSeries>*)series engine:(NSObject<IXuniRenderEngine>*)engine axisX:(NSObject<IXuniAxis>*)ax axisY:(NSObject<IXuniAxis>*)ay index:(int)iser realIndex:(int)irealser count:(int)nser selectedIndex:(int)sel chartType:(XuniChartType)chartType stackPos:(NSMutableDictionary *)stackPos stackNeg:(NSMutableDictionary *)stackNeg;

/**
*  系列のプロットに使用する特定のメソッド
*    @param seriesCollection プロットする seriesCollection
*    @param engine レンダリングエンジン
*    @param ax X 軸
*    @param ay Y 軸
*    @param selection 選択された系列
*    @param isel seriesCollection 内の選択された系列のインデックス
*    @param stackPos 正の値の内部スタック
*    @param stackNeg 負の値の内部スタック
*/
- (void)plotSeriesCollection:(XuniObservableArray*)seriesCollection engine:(NSObject<IXuniRenderEngine>*)engine axisX:(NSObject<IXuniAxis>*)ax axisY:(NSObject<IXuniAxis>*)ay selectedSeries:(NSObject<IXuniSeries>*)selection elementIndex:(int)isel stackPos:(NSMutableDictionary *)stackPos stackNeg:(NSMutableDictionary *)stackNeg;
@end
