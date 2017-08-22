//
//  XuniGauge.h
//  FlexGauge
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

//#define Animation XuniGaugeAnimation
#import <CoreText/CoreText.h>

#import "FlexGaugeEnums.h"

#ifndef XUNI_INTERNAL_DYNAMIC_BUILD

#ifndef XuniCoreKit_h
#import "XuniCore/CollectionView.h"
#import "XuniCore/Easing.h"
#import "XuniCore/XuniView.h"
#endif

#else
#import "XuniCoreDynamicKit/XuniCoreDynamicKit.h"
#endif

/**
*/
@class XuniObservableArray;
/**
*/
@class XuniGaugeRange;
/**
*/
@class XuniRenderEngine;
/**
*/
@class XuniAnimation;
/**
*/
@class XuniRect;
/**
*/
@protocol IXuniValueFormatter;

/**
*/
@class XuniGauge;

/**
*  XuniGaugeDelegate プロトコル
*/
@protocol XuniGaugeDelegate <XuniViewDelegate>
/**
*/
@optional

/**
*  値が変更されたときに処理を実行します。
*    @param sender 対象となる Gauge のオブジェクト
*    @param value 値
*/
- (void)valueChanged:(XuniGauge*)sender value:(double)value;

@end

/**
*/
@class XuniPointEventArgs;

/**
*  XuniGauge の基本クラス
*/
@interface XuniGauge : XuniView<UIGestureRecognizerDelegate>

/**
*  ゲージがタップされたときに発生します。
*/
@property XuniEvent<XuniPointEventArgs*> *gaugeTapped;

/**
*  イベント引数を作成し、onChartRendering を呼び出します。
*    @param point タップされたポイント
*/
- (void) raiseGaugeTapped: (XuniPoint*) point;

/**
*  Gauge が描画されるときに発生します
*/
@property XuniEvent<XuniEventArgs*> *gaugeRendered;

/**
*  イベント引数を作成し、onChartRendering イベントを呼び出します。
*/
- (void) raiseGaugeRendered;

/**
*  Gauge の値が変わったときに発生します。
*/
@property XuniEvent<XuniEventArgs*> *gaugeValueChanged;

/**
*  イベント引数を作成し、onChartRendering イベントを呼び出します。
*/
- (void) raiseGaugeValueChanged;



/**
*  通知を処理するためのデリゲートを取得または設定します。
*/
@property (nonatomic, weak) id<XuniGaugeDelegate> delegate;

/**
*  フェースの色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *faceColor;

/**
*  フェースの境界線の色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *faceBorderColor;

/**
*  フェースの境界線の幅を取得または設定します。
*/
@property (nonatomic) IBInspectable double faceBorderWidth;

/**
*  フェースの境界線の破線を取得または設定します。
*/
@property (nonatomic) NSArray<NSNumber*>* faceBorderDashes;

/**
*  ポインタの色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *pointerColor;

/**
*  最大ラベルの不透明度を取得または設定します。
*/
@property (nonatomic) IBInspectable double maxOpacity;

/**
*  最大ラベルのフォントサイズを取得または設定します。
*/
@property (nonatomic) IBInspectable double maxFontSize;

/**
*  最大ラベルのフォント色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *maxFontColor;

/**
*  最大値ラベルのフォントを取得または設定します。
*/
@property (nonatomic) IBInspectable NSString* maxFontName;

/**
*  最大ラベルのフォントを取得または設定します。
*/
@property (nonatomic) UIFont *maxFont;

/**
*  最小ラベルの不透明度を取得または設定します。
*/
@property (nonatomic) IBInspectable double minOpacity;

/**
*  最小ラベルのフォントサイズを取得または設定します。
*/
@property (nonatomic) IBInspectable double minFontSize;

/**
*  最小ラベルのフォント色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *minFontColor;

/**
*  最小値ラベルのフォントを取得または設定します。
*/
@property (nonatomic) IBInspectable NSString* minFontName;

/**
*  最小ラベルのフォントを取得または設定します。
*/
@property (nonatomic) UIFont *minFont;

/**
*  ゲージに表示される値を取得または設定します。
*/
@property (nonatomic) IBInspectable double value;

/**
*  値のフォントサイズを取得または設定します。
*/
@property (nonatomic) IBInspectable double valueFontSize;

/**
*  値のフォント色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *valueFontColor;

/**
*  値のフォントを取得または設定します。
*/
@property (nonatomic) IBInspectable NSString* valueFontName;

/**
*  値ラベルのフォントを取得または設定します。
*/
@property (nonatomic) UIFont *valueFont;

/**
*  値を変更できるかどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL isReadOnly;

/**
*  コントロールでアニメーションが有効かどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL isEnabled;

/**
*  コントロールでアニメーションが有効かどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL isAnimated;

/**
*  コントロールが最初に表示されるときに実行されるロードアニメーションを取得または設定します。
*/
@property (nonatomic) XuniAnimation *loadAnimation;

/**
*  コントロールの値が更新されたときに実行される更新アニメーションを取得または設定します。
*/
@property (nonatomic) XuniAnimation *updateAnimation;

/**
*  範囲の最小値を取得または設定します。
*/
@property (nonatomic) IBInspectable double min;

/**
*  範囲の最大値を取得または設定します。
*/
@property (nonatomic) IBInspectable double max;

/**
*  範囲の原点値を取得または設定します。
*/
@property (nonatomic) IBInspectable double origin;

/**
*  ステップを取得または設定します。
*/
@property (nonatomic) IBInspectable double step;

/**
*  ゲージ値をテキストとして表示するために使用される書式文字列を取得または設定します。
*/
@property (nonatomic) IBInspectable NSString* format;

/**
*  ゲージの全体的な座標空間および外観を表すために使用される範囲を face として取得または設定します。
*/
@property (nonatomic) XuniGaugeRange* face;

/**
*  ゲージの現在の値を表すために使用される範囲を取得または設定します。
*/
@property (nonatomic) XuniGaugeRange* pointer;

/**
*  範囲プロパティに含まれる範囲をゲージに表示するかどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL showRanges;

/**
*  ゲージの範囲を取得または設定します。
*/
@property (nonatomic) XuniObservableArray<XuniGaugeRange*>* ranges;

/**
*  ゲージにどの値をテキストとして表示するかを取得または設定します。
*/
@property (nonatomic) XuniShowText showText;

/**
*  範囲の古い値を取得または設定します。
*/
@property (nonatomic) IBInspectable double oldValue;

/**
*  0 ～ 1 のスケールでゲージの太さを取得または設定します。
*/
@property (nonatomic) IBInspectable double thickness;

/**
*  ゲージのフレームを取得または設定します。
*/
@property (nonatomic) XuniRect* rectGauge;

/**
*  ゲージのレンダリングエンジンを取得または設定します。
*/
@property (readonly) XuniRenderEngine* renderEngine;

/**
*  アニメーション中の色を取得または設定します。
*/
@property (nonatomic) UIColor* animColor;

/**
*  アニメーションのイージングタイプを取得または設定します。
*/
@property (nonatomic) id<IXuniEaseAction> easingType;

/**
*  値フォーマッタを取得または設定します。
*/
@property (nonatomic) NSObject<IXuniValueFormatter> *valueFormatter;

/**
*  @exclude
*/
- (void)initialization;
/**
*  必要に応じて、ゲージをリフレッシュして再描画します。
*/
- (void)invalidate;
/**
*  四角形領域を描画する内部メソッドです。
*    @param rect 描画する四角形領域
*/
- (void)drawRect:(CGRect)rect;
/**
*  テキスト要素のコンテンツと位置を更新します。
*/
- (void)updateText;
/**
*  範囲要素を更新します。
*    @param rng   ゲージの範囲
*    @param value 範囲の値
*    @param time  更新に要する時間
*/
- (void)updateRangeElement:(XuniGaugeRange*)rng value:(double)value time:(double)time;

/**
*  ポイントの値を取得します。
*    @param point ヒットテスト情報（ HitTestInfo ）が参照するコントロール座標内のポイント
*    @return ゲージの値（ double ）
*/
- (double)getValueFromPoint:(XuniPoint*)point;

/**
*  ゲージの特定のポイントに対応する数値を取得します。
*    @param point ヒットテスト情報（ HitTestInfo ）が参照するコントロール座標内のポイント
*    @return ゲージの特定のポイントに対応する数値
*/
- (double)hitTest:(XuniPoint*)point;

/**
*  ゲージの特定のポイントに対応する数値を取得します。
*    @param x ポイントの X 値
*    @param y ポイントの Y 値
*    @return ゲージの特定のポイントに対応する値
*/
- (double)hitTest:(double)x y:(double)y;

/**
*  ゲージの最小値（ min ）と最大値（ max ）のプロパティに基づいて、値をパーセンテージ（ ％ ）に変換します。
*    @param value 特定の値
*    @return パーセンテージの値
*/
- (double)getPercent:(double)value;

/**
*  ゲージの範囲に基づいてポインタ範囲の色を取得します。
*    @param value 特定の値
*    @return ゲージの範囲に基づくポインタ範囲の色
*/
- (UIColor*)getPointerColor:(double)value;

/**
*  最小値と最大値の間で値を制限します。
*    @param value 特定の値
*    @param min   最小値
*    @param max   最大値
*    @return 最小値と最大値の間の値
*/
- (double)clamp:(double)value min:(double)min max:(double)max;


/**
*  タップジェスチャに応答します。
*    @param recognizer タップジェスチャを認識する Recognizer
*/
- (void)respondToTapGesture:(UITapGestureRecognizer*)recognizer;

/**
*  アニメーションのイージングを取得します。
*    @return イージングタイプ
*/
- (id<IXuniEaseAction>)getAnimationEasing;

/**
*  アニメーションの長さを取得します。
*    @return アニメーションの長さ
*/
- (double)getAnimationDuration;

/**
*  書式文字列
*    @param number 特定の数値
*    @return 書式設定された文字列
*/
- (NSString *)formatDecimal:(double)number;

/**
*  コントロールをリフレッシュしてゲージを再描画します
*/
- (void)refresh;

/**
*  フォントのディスクリプタ（ Decriptor ）を取得します。
*    @param attributes フォント属性
*    @return ディスクリプタ
*/
- (UIFontDescriptor*)getDescriptor:(NSMutableDictionary*)attributes;

///#### Syntax <candies> for design-time property setting

/**
*  最大値、最小値を表示するかどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL showMinMax;

/**
*  ゲージの値をラベルに表示するかどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL showValue;

/**
*  ポインタの大きさ（thickness）を取得または設定します。
*/
@property (nonatomic) IBInspectable double pointerThickness;

@end


