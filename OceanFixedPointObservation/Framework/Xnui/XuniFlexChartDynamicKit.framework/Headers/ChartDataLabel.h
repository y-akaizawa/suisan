//
//  ChartDataLabel.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//


#ifndef FlexChartKit_h
#import "Axis.h"
#import "FlexChartEnums.h"
#import "ChartOptions.h"
#endif

#ifndef XUNI_INTERNAL_DYNAMIC_BUILD

#ifndef XuniChartCoreKit_h
#import "XuniChartCore/FlexChartBase.h"
#import "XuniChartCore/ChartLoadAnimation.h"
#import "XuniChartCore/BaseDataLabel.h"
#endif

#else
#import "XuniCoreDynamicKit/XuniCoreDynamicKit.h"
#import "XuniChartCoreDynamicKit/XuniChartCoreDynamicKit.h"
#endif

/**
*  チャートのデータラベルを表示する位置を指定する列挙型
*/
typedef NS_ENUM(NSInteger, FlexChartDataLabelPosition){
/**
*  データラベルは表示されません
*/
    FlexChartDataLabelPositionNone,
/**
*  データポイントの左に表示されます
*/
    FlexChartDataLabelPositionLeft,
/**
*  データポイントの右に表示されます
*/
    FlexChartDataLabelPositionRight,
/**
*  データポイントの上に表示されます
*/
    FlexChartDataLabelPositionTop,
/**
*  データポイントの下に表示されます
*/
    FlexChartDataLabelPositionBottom,
/**
*  データポイントの中心に表示されます
*/
    FlexChartDataLabelPositionCenter
};

/**
*  チャートのデータラベル
*/
@interface FlexChartDataLabel : XuniBaseDataLabel

/**
*  FlexChartDataLabel オブジェクトを初期化します。
*    @param chart FlexChart オブジェクト
*    @return FlexChartDataLabel オブジェクト
*/
-(id)init:(FlexChart*)chart;

/**
*  データラベルの位置を取得または設定します。
*/
@property(nonatomic) FlexChartDataLabelPosition position;
@end
