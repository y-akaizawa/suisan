//
//  HitTestInfo.h
//  XuniChartCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

/**
*  XuniHitTestInfo クラス
*/
@interface XuniHitTestInfo : NSObject

/**
*  ヒットテストやタッチイベントが発生した座標を取得します。
*/
@property (readonly) XuniPoint *point;

/**
*  XuniHitTestInfo オブジェクトを初期化します。
*    @param x the X 軸
*    @param y the Y 軸
*    @return XuniHitTestInfo オブジェクト
*/
- (id)initWithX:(double)x y:(double)y;

@end

