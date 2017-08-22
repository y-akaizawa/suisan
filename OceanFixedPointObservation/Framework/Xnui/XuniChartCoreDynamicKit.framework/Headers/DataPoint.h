//
//  DataPoint.h
//  XuniChartCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

/**
*  XuniDataPoint クラス
*/
@interface XuniDataPoint : NSObject

/**
*  このデータポイントの値を数値型（ double ）で取得します。
*/
@property (readonly) double value;

/**
*  このデータポイントのポイントインデックスを取得します。
*/
@property (readonly) int pointIndex;

/**
*  このデータポイントに連結されている基底のオブジェクトを取得します。
*/
@property (readonly) NSObject *dataObject;

@end
