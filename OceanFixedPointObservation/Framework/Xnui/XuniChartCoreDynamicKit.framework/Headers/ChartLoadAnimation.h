//
//  ChartLoadAnimation.h
//  XuniChartCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "FlexChartBaseEnums.h"
#import "FlexChartBase.h"

#ifndef XuniCoreKit_h
#import "XuniCore/Animation.h"
#endif

/**
*  XuniChartLoadAnimation クラス
*/
@interface XuniChartLoadAnimation : XuniAnimation

/**
*  プロットされたポイントをどのようにアニメーション表示するかを指定します。
*/
@property (nonatomic) XuniAnimationMode animationMode;

/**
*  このロードアニメーションを所有する FlexChart オブジェクト
*/
@property (nonatomic)FlexChartBase *chart;

/**
*  XuniChartLoadAnimation を初期化します。
*/
- (id)init;

@end
