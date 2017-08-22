//
//  FlexGaugeEnums.h
//  FlexGauge
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef FlexGauge_FlexGaugeEnums_h
#define FlexGauge_FlexGaugeEnums_h


/**
*  テキストとして表示する値を指定します。
*/
typedef NS_ENUM(NSInteger, XuniShowText){
/**
*  テキストの表示なし
*/
    XuniShowTextNone,
/**
*  値をテキストとして表示
*/
    XuniShowTextValue = 1,
/**
*  最小値、最大値をテキストとして表示
*/
    XuniShowTextMinMax = 1 << 1,
/**
*  すべてのテキストを表示
*/
    XuniShowTextAll = XuniShowTextValue | XuniShowTextMinMax
};

/**
*  LinearGauge のポインタが増加する方向を表す列挙型
*/
typedef NS_ENUM(NSInteger, XuniGaugeDirection){
/**
*  ポインタの方向が右
*/
    XuniGaugeDirectionRight,
/**
*  ポインタの向きが左
*/
    XuniGaugeDirectionLeft,
/**
*  ポインタの方向が上
*/
    XuniGaugeDirectionUp,
/**
*  ゲージの向きが下
*/
    XuniGaugeDirectionDown
};

/**
*  テキストを表示する方向を表す列挙型
*/
typedef NS_ENUM(NSInteger, XuniTextDirection){
/**
*  テキストの方向が右
*/
    XuniTextDirectionRight,
/**
*  テキストの方向が左
*/
    XuniTextDirectionLeft,
/**
*  テキストの方向が上
*/
    XuniTextDirectionTop,
/**
*  テキストの方向が下
*/
    XuniTextDirectionBottom
};

/**
*  ラベルタイプの列挙型
*/
typedef NS_ENUM(NSInteger, XuniLabelType){
/**
*  最小値を表示するラベル
*/
    XuniLabelTypeMin,
/**
*  最大値を表示するラベル
*/
    XuniLabelTypeMax
};

/**
*  オブジェクトのタイプを表します。
*/
typedef NS_ENUM(NSInteger, DataType) {
/**
*  null オブジェクトタイプ
*/
    DataTypeNull,
/**
*  汎用オブジェクトタイプ
*/
    DataTypeObject,
/**
*  文字列オブジェクトタイプ
*/
    DataTypeString,
/**
*  数値オブジェクトタイプ
*/
    DataTypeNumber,
/**
*  boolean オブジェクトタイプ
*/
    DataTypeBoolean,
/**
*  日付オブジェクトタイプ
*/
    DataTypeDate,
/**
*  配列オブジェクトタイプ
*/
    DataTypeArray
};

#endif
