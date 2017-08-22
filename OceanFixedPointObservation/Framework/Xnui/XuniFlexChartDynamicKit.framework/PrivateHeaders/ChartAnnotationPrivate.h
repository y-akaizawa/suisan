//
//  ChartAnnotationPrivate.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef ChartAnnotationPrivate_h
#define ChartAnnotationPrivate_h

#import "ChartAnnotation.h"

/**
*  XuniChartAnnotation クラス
*/
@interface XuniChartAnnotation ()

/**
*  パスを取得または設定します。
*/
@property struct CGPath *path;

/**
*  変換を取得または設定します。
*/
@property CGAffineTransform annoTransform;

/**
*  注釈を描画する必要があるかどうかを判定します。
*    @param engine レンダリングエンジン
*    @return boolean 必要な場合は ture
*/
- (BOOL)isNeedRender:(XuniRenderEngine *)engine;

/**
*  注釈を描画します。
*    @param engine レンダリングエンジン
*    @return boolean 結果
*/
- (BOOL)render:(XuniRenderEngine *)engine;

/**
*  注釈の絶対位置をポイントで取得します。
*    @param point      注釈のポイント
*    @param position   ポイントに対する注釈の位置
*    @param attachment 注釈の添付方法
*    @param engine レンダリングエンジン
*    @return 絶対位置のポイント
*/
- (XuniPoint *)getAbsolutePoint:(XuniPoint *)point position:(XuniChartAnnotationPosition)position attachment:(XuniChartAnnotationAttachment)attachment engine:(XuniRenderEngine*)engine;

/**
*  注釈がポイントを含むかどうかを判定します。
*    @param point ポイント
*    @return boolean ポイントを含む場合は true
*/
- (BOOL)isContains:(XuniPoint *)point;

/**
*  クリップされた四角形領域を設定する必要があるかどうかを判定します。
*    @return boolean 必要がある場合は true
*/
- (BOOL)isNeedClipRect;

@end

#endif
