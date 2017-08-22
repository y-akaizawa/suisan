//
//  LinePlotter.h
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
*/
@class XuniSeries;
/**
*/
@class XuniNotifyCollectionChangedEventArgs;
/**
*/
@class XuniChartDataPoint;

/**
*  XuniLinePlotter クラス
*/
@interface XuniLinePlotter : XuniBasePlotter

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
*  チャートを回転するかどうかを取得または設定します。
*/
@property BOOL hasSymbols;

/**
*  チャートにラインが含まれるかどうかを取得または設定します。
*/
@property BOOL hasLines;

/**
*  スプライングラフかどうかを取得または設定します。
*/
@property BOOL isSpline;


/**
*  LinePlotter のインスタンスを初期化します。
*    @param chart     FlexChart オブジェクト
*    @param dataInfo  dataInfo
*    @param hitTester 指定されたポイントにあるチャート要素
*    @return LinePlotter のインスタンス
*/
- (id)init:(FlexChart*)chart dataInfo:(XuniDataInfo*)dataInfo hitTester:(XuniHitTester*)hitTester;

/**
*  パラメータを指定してシンボルを描画します。
*    @param engine       レンダリングエンジン
*    @param x            X 値
*    @param y            Y 値
*    @param borderWidth  境界線の幅
*    @param symbolSize   シンボルのサイズ
*    @param fillColor    塗りつぶしに使用される色
*    @param borderColor  境界線の色
*    @param symbolMarker シンボルのマーカー
*    @param series       系列
*    @param index        インデックス
*    @param dataPoint    描画するシンボルを構成するメタデータ
*    @param type         シンボルのタイプ
*/
- (void)drawSymbol:(NSObject<IXuniRenderEngine>*)engine x:(double)x y:(double)y borderWidth:(double)borderWidth symbolSize:(double)symbolSize fillColor:(UIColor*)fillColor borderColor:(UIColor*)borderColor symbolMarker:(XuniMarkerType)symbolMarker series:(NSObject<IXuniSeries>*)series pointIndex:(int)index dataPoint:(XuniChartDataPoint*)dataPoint type:(XuniPlotElementLoadingType)type;

/**
*  パラメータを指定してアニメーション情報を取得します。
*    @param series   系列
*    @param time     時間
*    @param duration 長さ
*    @param count    数
*/
- (void)getAnimationInfo:(NSObject<IXuniSeries>*)series time:(double*)time duration:(double*)duration count:(int*)count;

/**
*  ポイントモードのポイントを取得します。
*    @param xs       X 値の配列
*    @param ys       Y 値の配列
*    @param time     時刻
*    @param duration 長さ
*    @param type     イージングタイプ
*    @param rotated  回転するかどうか
*    @return NSDictionary オブジェクト
*/
- (NSDictionary*)getPointsForPointMode:(NSArray*)xs Y:(NSArray*)ys time:(double)time duration:(double)duration type:(id<IXuniEaseAction>)type rotated:(BOOL)rotated;

/**
*  更新されたポイントを Dictionary で取得します。
*    @param updateEventArgs   更新イベント引数
*    @param ax                X 軸
*    @param ay                Y 軸
*    @param iser              インデックス
*    @param dx                X データ
*    @param dy                Y データ
*    @param prevVals          前の値
*    @param animationTime     アニメーションの時間
*    @param animationDuration アニメーションの遅延時間
*    @param type              タイプ
*    @param rotated           回転するかどうか
*    @return NSDictionary オブジェクト
*/
- (NSDictionary*)getUpdatedPointsDictionary:(XuniNotifyCollectionChangedEventArgs*)updateEventArgs axisX:(NSObject<IXuniAxis>*)ax axisY:(NSObject<IXuniAxis>*)ay index:(int)iser dx:(NSArray*)dx dy:(NSArray*)dy prevVals:(NSArray*)prevVals time:(double)animationTime duration:(double)animationDuration type:(id<IXuniEaseAction>)type rotated:(BOOL)rotated;

/**
*  ポイントモードのスケールを取得します。
*    @param type          型
*    @param time          時間
*    @param duration      長さ
*    @param dataInfoIndex dataInfoのインデックス
*    @param lastDataInfo  最後のデータ情報かどうか
*    @return double 値
*/
- (double)getScaleForPointMode:(id<IXuniEaseAction>)type time:(double)time duration:(double)duration dataInfoIndex:(int)dataInfoIndex lastDataInfo:(BOOL)lastDataInfo;

@end
