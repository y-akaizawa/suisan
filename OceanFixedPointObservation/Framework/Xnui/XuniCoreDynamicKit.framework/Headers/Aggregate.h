//
//  Aggregate.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
*  値のグループに対して計算する集計の種類を指定します。
*/
typedef NS_ENUM (NSInteger, XuniAggregate){
/**
*  集計なし
*/
    XuniAggregateNone,
/**
*  グループ内の数値の合計を返します。
*/
    XuniAggregateSum,
/**
*  グループ内の null 以外の数を返します。
*/
    XuniAggregateCnt,
/**
*  グループ内の数値の平均値を返します。
*/
    XuniAggregateAvg,
/**
*  グループ内の最大値を返します。
*/
    XuniAggregateMax,
/**
*  グループ内の最小値を返します。
*/
    XuniAggregateMin,
/**
*  グループ内の最大数値と最小数値の差を返します。
*/
    XuniAggregateRng,
/**
*  グループ内の数値の標本標準偏差を返します
*   （n-1 に基づく式を使用）。
*/
    XuniAggregateStd,
/**
*  グループ内の数値の標本分散を返します
*   （n-1 に基づく式を使用）。
*/
    XuniAggregateVar,
/**
*  グループ内の値の母標準偏差を返します
*   （n に基づく式を使用）。
*/
    XuniAggregateStdPop,
/**
*  グループ内の値の母分散を返します
*   （n に基づく式を使用）。
*/
    XuniAggregateVarPop
};

/**
*  配列内の値から集計値を計算します。
*    @param aggType XuniAggregate タイプ
*    @param items   連結先から渡されるプロパティ名を含むオブジェクトのリスト
*    @param binding 集計の対象として items 内の各項目から抽出するプロパティ
*    @return 集計結果
*/
double XuniGetAggregate(XuniAggregate aggType, NSArray *items, NSString *binding);
