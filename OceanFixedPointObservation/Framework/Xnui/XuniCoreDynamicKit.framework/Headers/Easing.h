//
//  Easing.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>

/**
*  XuniDirection 方向を定義する列挙型
*/
typedef NS_ENUM (NSInteger, XuniDirection){
/**
*  水平方向
*/
    XuniDirectionHorizontal,
/**
*  垂直方向
*/
    XuniDirectionVertical
};


/**
*  汎用アクションプロトコル
*/
@protocol IXuniEaseAction <NSObject>

/**
*  パラメータを指定してイージングアニメーションの値を取得します。
*    @param t アニメーションの時間
*    @param b 指定された初期値
*    @param c 指定された変更値
*    @param d アニメーションの長さ
*    @return イージングアニメーションの値
*/
- (double)ease:(double)t beginning:(double)b change:(double)c duration:(double)d;

/**
*  ビューのアニメーションカーブを取得します。
*    @return ビューのアニメーションカーブ
*/
- (UIViewAnimationCurve)viewAnimationCurve;
@end

/**
*  汎用アクションクラス
*/
@interface XuniEaseAction : NSObject<IXuniEaseAction>

/**
*  パラメータを指定してイージングアニメーションの値を取得します。
*    @param t アニメーションの時間
*    @param b 指定された初期値
*    @param c 指定された変更値
*    @param d アニメーションの長さ
*    @return イージングアニメーションの値
*/
- (double)ease:(double)t beginning:(double)b change:(double)c duration:(double)d;

/**
*  ビューのアニメーションカーブを取得します。
*    @return ビューのアニメーションカーブ
*/
- (UIViewAnimationCurve)viewAnimationCurve;
@end

/**
*  XuniEaseLinearAction クラス
*/
@interface XuniEaseLinearAction : XuniEaseAction

@end

/**
*  XuniEaseInAction クラス
*/
@interface XuniEaseInAction : XuniEaseAction

@end

/**
*  XuniEaseOutAction クラス
*/
@interface XuniEaseOutAction : XuniEaseAction

@end

/**
*  XuniEaseInOutAction クラス
*/
@interface XuniEaseInOutAction : XuniEaseAction

@end

/**
*  BackIn イージング
*/
@interface XuniBackIn : XuniEaseInAction
@end

/**
*  BackOut イージング
*/
@interface XuniBackOut : XuniEaseOutAction
@end

/**
*  BackInOut イージング
*/
@interface XuniBackInOut : XuniEaseInOutAction
@end

/**
*  BounceIn イージング
*/
@interface XuniBounceIn : XuniEaseInAction
@end

/**
*  BounceOut イージング
*/
@interface XuniBounceOut : XuniEaseOutAction
@end

/**
*  BounceInOut イージング
*/
@interface XuniBounceInOut : XuniEaseInOutAction
@end

/**
*  CircIn イージング
*/
@interface XuniCircIn : XuniEaseInAction
@end

/**
*  CircOut イージング
*/
@interface XuniCircOut : XuniEaseOutAction
@end

/**
*  CircInOut イージング
*/
@interface XuniCircInOut : XuniEaseInOutAction
@end

/**
*  CubicIn イージング
*/
@interface XuniCubicIn : XuniEaseInAction
@end

/**
*  CubicOut イージング
*/
@interface XuniCubicOut : XuniEaseOutAction
@end

/**
*  CubicInOut イージング
*/
@interface XuniCubicInOut : XuniEaseInOutAction
@end

/**
*  ElasticIn イージング
*/
@interface XuniElasticIn : XuniEaseInAction
@end

/**
*  ElasticOut イージング
*/
@interface XuniElasticOut : XuniEaseOutAction
@end

/**
*  ElasticInOut イージング
*/
@interface XuniElasticInOut : XuniEaseInOutAction
@end

/**
*  ExpoIn イージング
*/
@interface XuniExpoIn : XuniEaseInAction
@end

/**
*  ExpoOut イージング
*/
@interface XuniExpoOut : XuniEaseOutAction
@end

/**
*  ExpoInOut イージング
*/
@interface XuniExpoInOut : XuniEaseInOutAction
@end

/**
*  LinearIn イージング
*/
@interface XuniLinearIn : XuniEaseLinearAction
@end

/**
*  LinearOut イージング
*/
@interface XuniLinearOut : XuniEaseLinearAction
@end

/**
*  LinearInOut イージング
*/
@interface XuniLinearInOut : XuniEaseLinearAction
@end

/**
*  QuadIn イージング
*/
@interface XuniQuadIn : XuniEaseInAction
@end

/**
*  QuadOut イージング
*/
@interface XuniQuadOut : XuniEaseOutAction
@end

/**
*  QuadInOut イージング
*/
@interface XuniQuadInOut : XuniEaseInOutAction
@end

/**
*  QuartIn イージング
*/
@interface XuniQuartIn : XuniEaseInAction
@end

/**
*  QuartOut イージング
*/
@interface XuniQuartOut : XuniEaseOutAction
@end

/**
*  QuartInOut イージング
*/
@interface XuniQuartInOut : XuniEaseInOutAction
@end

/**
*  QuintIn イージング
*/
@interface XuniQuintIn : XuniEaseInAction
@end

/**
*  QuintOut イージング
*/
@interface XuniQuintOut : XuniEaseOutAction
@end

/**
*  QuintInOut イージング
*/
@interface XuniQuintInOut : XuniEaseInOutAction
@end

/**
*  SineIn イージング
*/
@interface XuniSineIn : XuniEaseInAction
@end

/**
*  SineOut イージング
*/
@interface XuniSineOut : XuniEaseOutAction
@end

/**
*  SineInOut イージング
*/
@interface XuniSineInOut : XuniEaseInOutAction
@end


/**
*  イージングユーティリティ
*/
@interface XuniEasingUtil : NSObject

/**
*  パラメータを指定してイージングアニメーションの値を取得します。
*    @param ease イージング
*    @param t    アニメーションの時間
*    @param b    指定された初期値
*    @param c    指定された変更値
*    @param d    アニメーションの長さ
*    @return イージングアニメーションの値
*/
+ (double)ease:(id<IXuniEaseAction>)ease time:(double)t beginning:(double)b change:(double)c duration:(double)d;

/**
*  パラメータを指定して NSDictionary を取得します。
*    @param xs     ポイントの X 値を含む配列
*    @param ys     ポイントの Y 値を含む配列
*    @param bottom 下端
*    @param t      アニメーションの時間
*    @param d      アニメーションの長さ
*    @param dir    アニメーションの方向
*    @param ease   イージング
*    @return NSDictionary
*/
+ (NSDictionary *)easePointsListX:(NSArray *)xs Y:(NSArray *)ys bottom:(double)bottom time:(double)t duration:(double)d direction:(XuniDirection)dir ease:(id<IXuniEaseAction>)ease;
@end

//Presets
/**
*  XuniEasing イージング
*/
@interface XuniEasing : NSObject

/**
*  インデックスに基づくイージング
*    @param index 指定されたインデックス
*    @return イージングアニメーションのタイプ
*/
+ (id<IXuniEaseAction>)EaseByIndex:(NSInteger)index;

/**
*  イージングタイプからインデックスを取得します。
*    @param ease イージングタイプ
*    @return インデックス
*/
+ (NSInteger)IndexFromEase:(id<IXuniEaseAction>)ease;

/**
*  EaseNone オブジェクトを取得します。
*    @return なし
*/
+ (id<IXuniEaseAction>)EaseNone;

/**
*  XuniBackIn オブジェクトを取得します。
*    @return XuniBackIn オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInBack;
/**
*  XuniBackOut オブジェクトを取得します。
*    @return XuniBackOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseOutBack;
/**
*  XuniBackInOut オブジェクトを取得します。
*    @return XuniBackInOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInOutBack;

/**
*  XuniBounceIn オブジェクトを取得します。
*    @return XuniBounceIn オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInBounce;
/**
*  XuniBounceOut オブジェクトを取得します。
*    @return XuniBounceOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseOutBounce;
/**
*  XuniBounceInOut オブジェクトを取得します。
*    @return XuniBounceInOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInOutBounce;

/**
*  XuniCircIn オブジェクトを取得します
*    @return XuniCircIn オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInCirc;
/**
*  XuniCircOut オブジェクトを取得します。
*    @return XuniCircOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseOutCirc;
/**
*  XuniCircInOut オブジェクトを取得します。
*    @return XuniCircInOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInOutCirc;

/**
*  XuniCubicIn オブジェクトを取得します。
*    @return XuniCubicIn オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInCubic;
/**
*  XuniCubicOut オブジェクトを取得します。
*    @return XuniCubicOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseOutCubic;
/**
*  XuniCubicInOut オブジェクトを取得します。
*    @return XuniCubicInOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInOutCubic;

/**
*  XuniElasticIn オブジェクトを取得します。
*    @return XuniElasticIn オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInElastic;
/**
*  XuniElasticOut オブジェクトを取得します。
*    @return XuniElasticOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseOutElastic;
/**
*  XuniElasticInOut オブジェクトを取得します。
*    @return XuniElasticInOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInOutElastic;

/**
*  XuniExpoIn オブジェクトを取得します。
*    @return XuniExpoIn オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInExpo;
/**
*  XuniExpoOut オブジェクトを取得します。
*    @return XuniExpoOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseOutExpo;
/**
*  XuniExpoInOut オブジェクトを取得します。
*    @return XuniExpoInOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInOutExpo;

/**
*  XuniLinearIn オブジェクトを取得します。
*    @return XuniLinearIn オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInLinear;
/**
*  XuniLinearOut オブジェクトを取得します。
*    @return XuniLinearOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseOutLinear;
/**
*  XuniLinearInOut オブジェクトを取得します。
*    @return XuniLinearInOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInOutLinear;

/**
*  XuniQuadIn オブジェクトを取得します。
*    @return XuniQuadIn オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInQuad;
/**
*  XuniQuadOut オブジェクトを取得します。
*    @return XuniQuadOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseOutQuad;
/**
*  XuniQuadInOut オブジェクトを取得します。
*    @return XuniQuadInOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInOutQuad;

/**
*  XuniQuartIn オブジェクトを取得します。
*    @return XuniQuartIn オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInQuart;
/**
*  XuniQuartOut オブジェクトを取得します。
*    @return XuniQuartOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseOutQuart;
/**
*  XuniQuartInOut オブジェクトを取得します。
*    @return XuniQuartInOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInOutQuart;

/**
*  XuniQuintIn オブジェクトを取得します。
*    @return XuniQuintIn オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInQuint;
/**
*  XuniQuintOut オブジェクトを取得します。
*    @return XuniQuintOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseOutQuint;
/**
*  XuniQuintInOut オブジェクトを取得します。
*    @return XuniQuintInOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInOutQuint;

/**
*  XuniSineIn オブジェクトを取得します。
*    @return XuniSineIn オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInSine;
/**
*  XuniSineOut オブジェクトを取得します。
*    @return XuniSineOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseOutSine;
/**
*  XuniSineInOut オブジェクトを取得します。
*    @return XuniSineInOut オブジェクト
*/
+ (id<IXuniEaseAction>)EaseInOutSine;

@end
