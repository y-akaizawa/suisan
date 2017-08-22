//
//  DataPointPrivate.h
//  XuniChartCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XuniChartCore_DataPointPrivate_h
#define XuniChartCore_DataPointPrivate_h

#ifdef XUNI_INTERNAL_DYNAMIC_BUILD
#import "XuniChartCoreDynamicKit/DataPoint.h"
#else
#import "DataPoint.h"
#endif

/**
*  XuniDataPoint クラス
*/
@interface XuniDataPoint ()

/**
*  このデータポイントの値を数値型（ double ）で取得または設定します。
*/
@property double value;

/**
*  このデータポイントのポイントインデックスを取得または設定します。
*/
@property int pointIndex;

/**
*  このデータポイントに連結されている基底のオブジェクトを取得または設定します。
*/
@property NSObject *dataObject;

@end

#endif
