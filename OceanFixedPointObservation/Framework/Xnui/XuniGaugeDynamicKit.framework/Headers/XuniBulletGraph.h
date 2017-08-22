//
//  XuniBulletGraph.h
//  FlexGauge
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "XuniLinearGauge.h"

/**
*  XuniBulletGraph（ブレットグラフ）は、線形ゲージの一種でダッシュボードでの利用に適しています。
*/
IB_DESIGNABLE
/**
*  XuniBulletGraph は直線型ゲージの一種で、特にダッシュボードで使用することを意図して設計されています。
*/
@interface XuniBulletGraph : XuniLinearGauge

/**
*  不良値の基準値を取得または設定します。
*/
@property (nonatomic) IBInspectable double bad;

/**
*  良値の基準値を取得または設定します。
*/
@property (nonatomic) IBInspectable double good;

/**
*  目標値を取得または設定します。
*/
@property (nonatomic) IBInspectable double target;

/**
*  不良値範囲の塗りつぶしを取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *badRangeColor;

/**
*  良値範囲の塗りつぶしを取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *goodRangeColor;

/**
*  目標値の塗りつぶしを取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *targetColor;

@end
