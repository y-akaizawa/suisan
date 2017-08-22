//
//  XuniLinearGauge.h
//  FlexGauge
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "XuniGauge.h"

/**
*  XuniLinearGauge は線形のインジケーターです。
*  データポイントを可視化してアニメーション表示する対話性の優れたアプリを開発できます。
*/
IB_DESIGNABLE
/**
*  XuniLinearGauge は、1 つの値を表すインジケータと、参照値を表す範囲（オプション）を使用して、直線型の目盛りを表示します。
*/
@interface XuniLinearGauge : XuniGauge

/**
*  ゲージのポインタの方向
*/
@property (nonatomic) XuniGaugeDirection direction;

/**
*  指定した範囲の四角形領域を取得します。
*    @param rng   ゲージの範囲
*    @param value 特定の値
*    @return 範囲の四角形領域
*/
- (XuniRect*)getRangeRect:(XuniGaugeRange*)rng value:(double)value;


///#### Syntax <candies> for design-time property setting

/**
*  ゲージが垂直表示かどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL isVertical;

/**
*  ゲージが反転表示かどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL isReversed;


@end
