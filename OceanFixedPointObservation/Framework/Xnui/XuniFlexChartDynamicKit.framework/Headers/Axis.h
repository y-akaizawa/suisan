//
//  Axis.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "FlexChartEnums.h"

#ifndef XUNI_INTERNAL_DYNAMIC_BUILD

#ifndef XuniChartCoreKit_h
#import "XuniChartCore/FlexChartBaseEnums.h"
#import "XuniCore/CollectionView.h"
#endif

#else
#import "XuniCoreDynamicKit/XuniCoreDynamicKit.h"
#import "XuniChartCoreDynamicKit/XuniChartCoreDynamicKit.h"
#endif

#import "LabelLoadingEventArgs.h"

/**
*/
@class XuniRenderEngine;
/**
*/
@class FlexChart;
/**
*/
@class XuniLabelLoadingEventArgs;
/**
*/
@class XuniSize;
/**
*/
@class XuniRect;

/**
*  IXuniAxis プロトコル
*/
@protocol IXuniAxis

/**
*  実際の軸データの最小値を取得します。
*/
@property (readonly) double actualDataMin;

/**
*  実際の軸データの最大値を取得します。
*/
@property (readonly) double actualDataMax;

/**
*  実際の軸の最小値を取得します。
*/
@property (readonly) double actualMin;

/**
*  実際の軸の最大値を取得します。
*/
@property (readonly) double actualMax;

/**
*  データ座標からピクセル座標に変換された値を取得します。
*    @param val 値
*    @return データ座標からピクセル座標に変換された値
*/
- (double)convert:(double)val;

/**
*  指定された最大値に基づいて、データ座標の値をピクセル座標に変換します。
*    @param val データ座標内の値
*    @param specifiedMax 指定された最大値
*    @return データ座標からピクセル座標に変換された値
*/
- (double)convert:(double)val specifiedMax:(double)specifiedMax;

/**
*  指定された最大値と最小値に基づいて、データ座標の値をピクセル座標に変換します。
*    @param val          データ座標内の値
*    @param specifiedMax 指定された最大値
*    @param specifiedMin 指定された最小値
*    @return データ座標からピクセル座標に変換された値
*/
- (double)convert:(double)val specifiedMax:(double)specifiedMax specifiedMin:(double)specifiedMin;

@end

/**
*  チャート内の軸を表します。
*/
@interface XuniAxis : NSObject<IXuniAxis>

/**
*  軸のチャートを取得または設定します。
*/
@property (nonatomic)FlexChart *chart;

/**
*  軸の原点を取得または設定します。
*/
@property (nonatomic)double origin;

/**
*  原点を設定された後の軸のオフセットを取得または設定します。
*/
@property (nonatomic)double offset;

/**
*  @exclude.
*/
@property (nonatomic)NSString *axisName;

/**
*  プロットエリアに対する軸の位置を取得または設定します。
*/
@property (nonatomic) XuniPosition position;

/**
*  軸タイトルを取得または設定します。
*/
@property (nonatomic) NSString *title;

/**
*  注釈の書式設定を取得または設定します。
*/
@property (nonatomic) NSString *format;

/**
*  軸ラベルを描画する角度を取得または設定します。
*/
@property (nonatomic) double labelAngle;

/**
*  軸ラベルのフォントを取得または設定します。
*/
@property (nonatomic) UIFont *labelFont;

/**
*  軸ラベルのテキスト色を取得または設定します。
*/
@property (nonatomic) UIColor *labelTextColor;

/**
*  軸タイトルのフォントを取得または設定します。
*/
@property (nonatomic) UIFont *titleFont;

/**
*  軸タイトルのテキスト色を取得または設定します。
*/
@property (nonatomic) UIColor *titleTextColor;

/**
*  軸線の色を取得または設定します。
*/
@property (nonatomic) UIColor *lineColor;

/**
*  軸線の幅を取得または設定します。
*/
@property (nonatomic) double lineWidth;

/**
*  主グリッド線の色を取得または設定します。
*/
@property (nonatomic) UIColor *majorGridColor;

/**
*  主グリッドの塗りつぶし色を取得または設定します。
*/
@property (nonatomic) UIColor *majorGridFill;

/**
*  主グリッド線の幅を取得または設定します。
*/
@property (nonatomic) double majorGridWidth;

/**
*  大目盛りマークの色を取得または設定します。
*/
@property (nonatomic) UIColor *majorTickColor;

/**
*  大目盛りマークの幅を取得または設定します。
*/
@property (nonatomic) double majorTickWidth;

/**
*  大目盛りマークの長さを取得または設定します。
*/
@property (nonatomic) double majorTickLength;

/**
*  副グリッド線の色を取得または設定します。
*/
@property (nonatomic) UIColor *minorGridColor;

/**
*  副グリッドの塗りつぶし色を取得または設定します。
*/
@property (nonatomic) UIColor *minorGridFill;

/**
*  副グリッド線の幅を取得または設定します。
*/
@property (nonatomic) double minorGridWidth;

/**
*  小目盛りマークの色を取得または設定します。
*/
@property (nonatomic) UIColor *minorTickColor;

/**
*  小目盛りマークの幅を取得または設定します。
*/
@property (nonatomic) double minorTickWidth;

/**
*  小目盛りマークの長さを取得または設定します。
*/
@property (nonatomic) double minorTickLength;

/**
*  実際の軸の最小値を取得します。
*/
@property (readonly) double actualMin;

/**
*  実際の軸の最大値を取得します。
*/
@property (readonly) double actualMax;

/**
*  適切な軸の最小値を取得または設定します。
*/
@property (nonatomic) NSObject *min;

/**
*  グリッドの破線パターンを取得または設定します。
*/
@property (nonatomic) NSArray<NSNumber*> *majorGridDashes;

/**
*  グリッドの破線パターンを取得または設定します。
*/
@property (nonatomic) NSArray<NSNumber*> *minorGridDashes;

/**
*  適切な軸の最大値を取得または設定します。
*/
@property (nonatomic) NSObject *max;

/**
*  軸タイプ（X または Y）を取得します。
*/
@property (readonly) XuniAxisType axisType;

/**
*  軸が時間の値を含むかどうかを取得します。
*/
@property (nonatomic) BOOL isTimeAxis;

/**
*  データインデックスが示す軸の時間の値を取得します。
*/
@property (nonatomic) NSArray *dataIndexTimeVals;

/**
*  軸線が表示されるかどうかを取得または設定します。
*/
@property (nonatomic) BOOL axisLineVisible;

/**
*  軸ラベルを表示するかどうかを取得または設定します。
*/
@property (nonatomic) BOOL labelsVisible;

/**
*  軸に主グリッド線を含めるかどうかを取得または設定します。
*/
@property (nonatomic) BOOL majorGridVisible;

/**
*  大目盛りマークと軸との重なりを取得または設定します。
*/
@property (nonatomic) double majorTickOverlap;

/**
*  軸の大目盛りマーク間の距離を取得または設定します。
*/
@property (nonatomic) double majorUnit;

/**
*  軸に副グリッド線を含めるかどうかを取得または設定します。
*/
@property (nonatomic) BOOL minorGridVisible;

/**
*  小目盛りマークと軸との重なりを取得または設定します。
*/
@property (nonatomic) double minorTickOverlap;

/**
*  軸の小目盛りマーク間の距離を取得または設定します。
*/
@property (nonatomic) double minorUnit;

/**
*  軸が反転されているかどうかを取得または設定します。
*/
@property BOOL reversed;

/**
*  ビューに表示される値の絶対範囲を取得または設定します。
*/
@property (nonatomic) double displayedRange;

/**
*  軸の対数の底を取得または設定します。
*/
@property (nonatomic) NSNumber* logBase;

/**
*  ビューに表示される値の相対範囲を取得または設定します。
*/
@property (nonatomic) double scale;

/**
*  軸の相対スクロール位置を取得または設定します。
*/
@property (nonatomic) double scrollPosition;

// Internal properties
/**
*  サイズを取得または設定します。
*/
@property (readonly) XuniSize *annoSize;

/**
*  ピンチジェスチャの比例関係を取得または設定します。
*/
@property CGFloat gestureProportion;

/**
*  適切なサイズを取得または設定します。
*/
@property XuniSize *desiredSize;

/**
*  軸の四角形を取得または設定します。
*/
@property (readonly) XuniRect *axrect;

/**
*  軸がラベルに重なっているかどうかを取得または設定します。
*/
@property (nonatomic)XuniChartOverlappingLabels overlappingLabels;

/**
*  labelLoading イベントを取得または設定します。
*/
@property (nonatomic) XuniEvent<XuniLabelLoadingEventArgs*> *labelLoading;

/**
*  XFの軸ラベルをロードするイベントを操作するかどうかを取得します。
*/
@property (nonatomic) BOOL isHandleXFAxisLabelLoading;

// Internal methods for scrolling

/**
*  軸が系列の上に配置するかどうかを取得または設定します。
*/
@property (nonatomic) BOOL above;

/**
*  グリッド線が存在するかどうかを取得または設定します。
*/
@property (nonatomic) BOOL gridLineIsExsit;

/**
*  boolean 型値を取得します。
*    @return boolean 値
*/
- (BOOL)hasMore;

/**
*  boolean 型値を取得します。
*    @return boolean 型値
*/
- (BOOL)hasLess;

/**
*  boolean 型値を取得します。
*    @return boolean 型値
*/
- (void)showMore;

/**
*  boolean 型値を取得します。
*    @return boolean 型値
*/
- (void)showLess;


/**
*  軸を特定のデータ値にスクロールします
*    @param dataValue スクロール先の値
*    @param position 相対データ位置による位置
*/
- (void)scrollTo:(double)dataValue position:(XuniAxisScrollPosition)position;

// Internal methods
/**
*  Axis のインスタンスを初期化します。
*    @return Axis のインスタンス
*/
-(instancetype)init;
/**
*  Axis のインスタンスを初期化します。
*    @param position 軸の位置
*    @param chart    チャート
*    @return Axis のインスタンス
*/
- (id)initWithPosition:(XuniPosition)position forChart:(FlexChart*)chart;

/**
*  軸の高さを取得します。
*    @param engine レンダリングエンジン
*    @return 軸の高さ
*/
- (double)getHeight:(XuniRenderEngine*)engine;

/**
*  指定されたデータ範囲に基づいて実際の軸制限を更新します。
*    @param dataType データ型
*    @param dataMin  最小データ
*    @param dataMax  最大データ
*    @param labels   軸のラベル
*    @param values   軸の値
*/
- (void)updateActualLimits:(XuniDataType)dataType dataMin:(double)dataMin dataMax:(double)dataMax labels:(NSArray*)labels values:(NSArray*)values;

/**
*  指定されたデータ範囲に基づいて実際の軸制限を更新します。
*    @param dataType データ型
*    @param dataMin  最小データ
*    @param dataMax  最大データ
*/
- (void)updateActualLimits:(XuniDataType)dataType dataMin:(double)dataMin dataMax:(double)dataMax;

/**
*  レイアウト軸
*    @param axisRect 軸の四角形
*    @param plotRect 軸のプロット四角形
*/
- (void)layout:(XuniRect*)axisRect plotRect:(XuniRect*)plotRect;

/**
*  軸をレンダリングします。
*    @param engine レンダリングエンジン
*    @param overlap ラベルの重なりタイプ
*/
- (void)render:(XuniRenderEngine*)engine isOverlap:(XuniChartOverlappingLabels)overlap;

/**
*  データ座標からピクセル座標に変換された値を取得します。
*    @param val 値
*    @return データ座標からピクセル座標に変換された値
*/
- (double)convert:(double)val;

/**
*  ピクセル座標からデータ座標に変換された値を取得します。
*    @param val 値
*    @return ピクセル座標からデータ座標に変換された値
*/
- (double)convertBack:(double)val;

/**
*  書式設定された値文字列を取得します。
*    @param val val
*    @return 書式設定された値文字列
*/
- (NSString*)formatValue:(double)val;

@property XuniEvent<XuniEventArgs*> *rangeChanged;


/**
*  イベント引数を作成し、rangeChanged を呼び出します。
*/
- (void) raiseRangeChanged;

/**
*  ScrollDataValue をリフレッシュします。
*    @param scrollPosition ScrollDataValue の計算に使用される scrollPosition 値。
*/
- (void)refreshScrollDataValue:(double)scrollPosition;
@end
