//
//  ChartTextAnnotationPrivate.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef ChartTextAnnotationPrivate_h
#define ChartTextAnnotationPrivate_h

#import "ChartTextAnnotation.h"

/**
*  XuniChartTextAnnotation クラス
*/
@interface XuniChartTextAnnotation ()

/**
*  テキスト型注釈を描画します。
*    @param engine レンダリングエンジン
*    @param rect   文字列を描画する四角形領域
*/
- (void)renderText:(XuniRenderEngine *)engine rect:(CGRect)rect;

@end

#endif
