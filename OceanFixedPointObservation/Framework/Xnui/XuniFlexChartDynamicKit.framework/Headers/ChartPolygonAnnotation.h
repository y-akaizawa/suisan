//
//  ChartPolygonAnnotation.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "ChartShapeAnnotation.h"

/**
*  多角形型注釈クラス
*/
@interface XuniChartPolygonAnnotation : XuniChartShapeAnnotation

/**
*  多角形型注釈のポイントのコレクションを取得または設定します。
*/
@property (nonatomic) NSMutableArray *points;

@end
