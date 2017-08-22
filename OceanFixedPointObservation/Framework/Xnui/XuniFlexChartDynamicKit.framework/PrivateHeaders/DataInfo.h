//
//  DataInfo.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

//#import "FlexChartBaseEnums.h"

/**
*  XuniDataInfo
*/
@interface XuniDataInfo : NSObject

/**
*  X の最小値を取得または設定します。
*/
@property double minX;

/**
*  X 値の最大値を取得または設定します。
*/
@property double maxX;

/**
*  Y の最小値を取得または設定します。
*/
@property double minY;

/**
*  Y の最大値を取得または設定します。
*/
@property double maxY;

/**
*  デルタ X の値を取得または設定します。
*/
@property double deltaX;

/**
*  X のデータ型を取得または設定します。
*/
@property enum XuniDataType dataTypeX;

/**
*  Y 値のデータ型を取得または設定します。
*/
@property enum XuniDataType dataTypeY;

/**
*  系列の最大項目数を取得または設定します。
*/
@property NSUInteger maxItems;

/**
*  XuniDataInfo を初期化します。
*    @return return XuniDataInfo オブジェクト
*/
- (id)init;

/**
*  積層に利用するために計算します。
*    @param seriesList 系列のリスト
*    @param stacking   積層タイプ
*    @param xvals      X 値
*/
- (void)analyse:(NSArray*)seriesList stacking:(XuniStacking)stacking values:(NSArray*)xvals;

/**
*  X の最小値を取得します。
*    @return X の最小値
*/
- (double)getMinX;

/**
*  X の最大値を取得します。
*    @return X の最大値
*/
- (double)getMaxX;

/**
*  Y の最小値を取得します。
*    @return Y の最小値
*/
- (double)getMinY;

/**
*  Yの最大値を取得します。
*    @return Y の最大値
*/
- (double)getMaxY;

/**
*  X のデータ型を取得します。
*    @return X のデータ型
*/
- (XuniDataType)getDataTypeX;

/**
*  Y 値のデータ型を取得します。
*    @return Y 値のデータ型
*/
- (XuniDataType)getDataTypeY;

/**
*  積層された値の合計値を取得します。
*    @param key 値のキー
*    @return return 合計値
*/
- (double)getStackedAbsSum:(double)key;

/**
*  @exclude.
*/
- (NSMutableDictionary*)getStackAbs;

/**
*  X 値の配列を取得します。
*    @return X 値の配列
*/
- (NSArray*)getXVals;

/**
*  さらに項目があるかどうかを判定します。
*    @return  boolean 値
*/
- (BOOL)hasMore;

/**
*  原点項目の数がゼロ未満であるかどうかを判定します。
*    @return boolean 値
*/
- (BOOL)hasLess;

/**
*  さらに項目を表示するかどうかを判定します。
*/
- (void)showMore;

/**
*  以下の項目を表示するかどうかを判定します。
*/
- (void)showLess;

/**
*  原点項目の数を取得します。
*    @return 値
*/
- (NSUInteger)getOrigin;

/**
*  最後の項目数を取得します。
*    @return 値
*/
- (NSUInteger)getEnd;

/**
*  ページサイズを取得します。
*    @return 値
*/
- (NSUInteger)getPageSize;

/**
*  数値が有効かどうかを判定します。
*    @param value 値
*    @return boolean 値
*/
+ (BOOL)isValid:(double)value;

@end
