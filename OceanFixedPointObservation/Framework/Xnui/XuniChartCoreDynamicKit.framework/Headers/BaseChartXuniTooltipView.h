//
//  BaseChartXuniTooltipView.h
//  XuniChartCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XuniCoreKit_h
#import "XuniCore/XuniTooltip.h"
#endif

/**
*/
@class XuniDataPoint;

/**
*  チャートに表示するツールチップの基本クラスです。
*/
@interface XuniBaseChartTooltipView : XuniBaseTooltipView

/**
*  チャートデータを取得または設定します。
*/
@property(nonatomic) XuniDataPoint* chartData;

@end
