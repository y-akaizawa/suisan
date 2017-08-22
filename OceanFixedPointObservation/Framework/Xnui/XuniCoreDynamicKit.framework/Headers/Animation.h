//
//  Animation.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Easing.h"

/**
*  XuniAnimation
*/
@interface XuniAnimation : NSObject

/**
*  アニメーション全体の長さを取得または設定します。
*/
@property (nonatomic) double duration;

/**
*  アニメーションが開始されるまでの遅延時間を取得または設定します。
*/
@property (nonatomic) double startDelay;

/**
*  アニメーションに使用されるイージング機能を取得または設定します。
*/
@property (nonatomic) id<IXuniEaseAction> easing;

/**
*  XuniAnimation オブジェクトを初期化します。
*    @return XuniAnimation オブジェクト
*/
- (id)init;

/**
*  XuniAnimation オブジェクトを初期化します。
*    @return XuniAnimation オブジェクト
*/
+ (id)none;

/**
*  アニメーションが有効かどうかを判定します。
*    @return boolean 値
*/
- (BOOL)isValid;

@end
