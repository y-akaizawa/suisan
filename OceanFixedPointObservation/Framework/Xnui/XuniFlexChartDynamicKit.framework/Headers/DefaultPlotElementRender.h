//
//  DefaultPlotElementRender.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XuniCoreKit_h
#import "XuniCore/Event.h"
#endif

/**
*  BasePlotElementRender クラス
*/
@interface BasePlotElementRender : NSObject

/**
*  処理を実行します。
*    @return オブジェクト
*/
- (NSObject *)execute;

/**
*  処理を実行します。
*    @param args パラメータの配列array of parameters.
*    @return オブジェクト
*/
- (NSObject *)execute:(NSArray *)args;

@end

/**
*  DefaultPlotElementRender クラス
*/
@interface DefaultPlotElementRender : BasePlotElementRender

/**
*  DefaultPlotElementRender オブジェクトを初期化します。
*    @param renderEngine レンダリングエンジン
*    @param x            X 値
*    @param y            Y 値
*    @param borderWidth  境界線の幅
*    @param symbolSize   シンボルのサイズ
*    @param fillColor    塗りつぶしに使用される色
*    @param borderColor  境界線の色
*    @param symbolMarker シンボルのマーカー
*    @return DefaultPlotElementRender  オブジェクト
*/
- (id)init:(NSObject<IXuniRenderEngine>*)renderEngine x:(double)x y:(double)y borderWidth:(double)borderWidth symbolSize:(double)symbolSize borderColor:(UIColor*)borderColor symbolMarker:(XuniMarkerType)symbolMarker;

/**
*  シンボルの四角形領域を取得します。
*    @return CGRect オブジェクト
*/
- (CGRect)getSymbolRect;

@end

/**
*  DefaultBarElementRender クラス
*/
@interface DefaultBarElementRender : BasePlotElementRender

/**
*  DefaultBarElementRender オブジェクトを初期化します。
*    @param renderEngine レンダリングエンジン
*    @param x            X 値
*    @param y            Y 値
*    @param width        幅
*    @param height       高さ
*    @return DefaultBarElementRender オブジェクト
*/
- (id)init:(NSObject<IXuniRenderEngine>*)renderEngine x:(double)x y:(double)y width:(double)width height:(double)height;

/**
*  バーの四角形領域を取得します。
*    @return CGRect オブジェクト
*/
- (CGRect)getBarRect;

@end

/**
*  DefaultFinanceElementRender クラス
*/
@interface DefaultFinanceElementRender : BasePlotElementRender

/**
*  DefaultFinanceElementRender オブジェクトを初期化します。
*    @param renderEngine   レンダリングエンジン
*    @param x              X 値
*    @param y              Y 値
*    @param w              W 値
*    @param hi             高値
*    @param lo             安値
*    @param open           始値
*    @param close          終値
*    @param isCandle       ローソク足チャートかどうか
*    @param rotated        チャートが回転しているかどうか
*    @param isAxisReversed チャートが反転しているかどうか
*    @return DefaultFinanceElementRender オブジェクト
*/
- (id)init:(NSObject<IXuniRenderEngine>*)renderEngine x:(double)x y:(double)y w:(double)w hi:(double)hi lo:(double)lo open:(double)open close:(double)close isCandle:(BOOL)isCandle isRotated:(BOOL)rotated reversed:(BOOL)isAxisReversed;

@end
