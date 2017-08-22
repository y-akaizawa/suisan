//
//  XuniRadialGauge.h
//  FlexGauge
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "XuniGauge.h"

/**
*  XuniRadialGauge は円形のインジケーターです。
*  データポイントを可視化してアニメーション表示する対話性の優れたアプリを開発できます。
*/
IB_DESIGNABLE
/**
*  XuniRadialGauge は、1 つの値を表すインジケータと、参照値を表す範囲（オプション）を使用して、円形の目盛りを表示します。
*/
@interface XuniRadialGauge : XuniGauge


/**
*  円形ゲージの開始角度を取得または設定します。
*/
@property (nonatomic) IBInspectable double startAngle;
/**
*  円形ゲージの移動角度を取得または設定します。
*/
@property (nonatomic) IBInspectable double sweepAngle;
/**
*  ゲージを自動スケールするかどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL autoScale;

@end
