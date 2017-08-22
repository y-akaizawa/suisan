//
//  FlexChart.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef FlexChartKit_h

#import "Axis.h"
#import "FlexChartEnums.h"
#import "ChartOptions.h"
#import "ChartDataLabel.h"
#import "ChartDataPoint.h"
#import "FlexChartDataLabelRenderer.h"
#import "ChartHitTestInfo.h"
#import "ChartPlotElementEventArgs.h"

#endif


#ifndef XUNI_INTERNAL_DYNAMIC_BUILD

#ifndef XuniChartCoreKit_h
#import "XuniChartCore/FlexChartBase.h"
#import "XuniChartCore/ChartLoadAnimation.h"
#import "XuniChartCore/ChartTooltip.h"
#import <CoreText/CoreText.h>
#endif

#else
#import "XuniCoreDynamicKit/XuniCoreDynamicKit.h"
#import "XuniChartCoreDynamicKit/XuniChartCoreDynamicKit.h"
#endif

/**
*/
@protocol IXuniValueFormatter;
/**
*/
@protocol IXuniEaseAction;
/**
*/
@class XuniCollectionView;
/**
*/
@class XuniRenderEngine;
/**
*/
@class XuniLegend;
/**
*/
@class XuniSeries;
/**
*/
@class XuniBaseChartTooltipView;
/**
*/
@class XuniBaseTooltipView;
/**
*/
@class XuniAnimation;
/**
*/
@class XuniChartLoadAnimation;
/**
*/
@class FlexChartOptions;
/**
*/
@class FlexChartDataLabel;
/**
*/
@class FlexChartDataLabelRenderer;
/**
*/
@class XuniChartLineMarker;
/**
*/
@class XuniChartPlotElementEventArgs;
/**
*/
@class XuniChartAnnotation;

/**
*  FlexChart は柔軟な表現ができるチャートコントロールです。 
*  幅広い種類のチャートタイプでデータを可視化します。
*/
IB_DESIGNABLE
/**
*  FlexChart コントロールは、データを視覚化する強力で柔軟な方法を提供します。
*/
@interface FlexChart : FlexChartBase<UIGestureRecognizerDelegate>

/**
*  プロット領域の範囲
*/
@property (readonly) XuniRect *plotRect;

/**
*  FlexChart のデータラベル
*/
@property (nonatomic) FlexChartDataLabel *dataLabel;

/**
*  FlexChart のデータラベル
*/
@property (nonatomic) FlexChartDataLabelRenderer *dataLabelRenderer;

/**
*  FlexChart に表示するラインマーカーを取得または設定します。
*/
@property (nonatomic) XuniChartLineMarker *lineMarker;

/**
*  データ系列のコレクションを取得または設定します。
*/
@property (readonly) XuniObservableArray<XuniSeries*> *series;

/**
*  注釈（アノテーション）の配列を取得または設定します。
*/
@property (nonatomic) XuniObservableArray<XuniChartAnnotation*> *annotations;

/**
*  軸コレクションの配列を取得します。
*/
@property (nonatomic) NSMutableArray<XuniAxis*> *axesArray;

/**
*  主水平（X）軸を取得します。
*/
@property (readonly) XuniAxis *axisX;

/**
*  主垂直（Y）軸を取得します。
*/
@property (readonly) XuniAxis *axisY;

/**
*  系列を積層するか、個別にプロットするかを取得または設定します。
*/
@property (nonatomic) XuniStacking stacking;

/**
*  このチャートをレンダリングするために使用されるシンボルのサイズを取得または設定します。
*/
@property (nonatomic) double symbolSize;

/**
*  データ欠損値を補間するかどうかを取得または設定します。
*    true の場合は、隣接するポイントに基づいて、欠けているデータの値が補間されます。false の場合は、欠損値があるポイントで、
*    線や領域に切れ目ができます。
*/
@property (nonatomic) IBInspectable BOOL interpolateNulls;

/**
*  チャートが回転した状態かどうかを取得します。
*/
@property (readonly) BOOL isReallyRotated;

/**
*  プロットの方向を反転するかどうかを取得または設定します。
*    false（デフォルト）の場合、プロットの方向は水平です。true の場合、
*    プロットの方向は垂直で、軸が入れ替わります。
*/
@property (nonatomic) IBInspectable BOOL rotated;

/**
*  チャートのアニメーションが有効かどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL isAnimated;

/**
*  チャートが初めて表示されるときに実行されるアニメーションを取得または設定します。
*/
@property (nonatomic) XuniChartLoadAnimation *loadAnimation;

/**
*  データポイントが変更されたとき、または系列が削除または非表示になったときに
*    実行されるアニメーションを取得または設定します。
*/
@property (nonatomic) XuniAnimation *updateAnimation;


/**
*  X 軸にプロットする最大項目数を取得または設定します。項目の合計数がこの値より大きい場合は、
*    スワイプして残りの項目を表示する必要があります。
*/
@property (nonatomic) IBInspectable NSUInteger maxItemsVisible;

/**
*  軸のスクロール動作を取得または設定します。
*/
@property (nonatomic) XuniZoomMode zoomMode;

/**
*  軸のスクロール動作を取得または設定します。
*/
@property (nonatomic) FlexChartOptions *options;

// Internal properties
/**
*  X 軸のラベル配列を取得します。
*/
@property (readonly) NSArray *xlabels;

/**
*  X 軸の値を取得します。
*/
@property (readonly) NSArray *xvals;

/**
*  xDataType を取得します。
*/
@property (readonly) XuniDataType xDataType;

/**
*  plotterChart を取得します。
*/
@property (readonly) XuniRect* plotterChart;

/**
*  値の書式を取得または設定します。
*/
@property (nonatomic) NSObject<IXuniValueFormatter> *valueFormatter;

/**
*  カスタムプロット要素を取得または設定します。
*/
@property (nonatomic) UIView *customPlotElement;

/**
*  プロット要素の読み込みが開始するかどうかを取得または設定します。
*/
@property (nonatomic) BOOL beginPlotElementLoading;

/**
*  XFの軸ラベルをロードするイベントを操作するかどうかを取得します。
*/
@property (nonatomic) BOOL isHandleXFPlotElementLoading;

// Internal properties for update animation
/**
*  アクティブな updateAnimation を取得または設定します。
*/
@property (nonatomic) XuniAnimation *activeUpdateAnimation;

/**
*  UpdateTask1 かどうかを取得または設定します。
*/
@property (nonatomic) BOOL isUpdateTask1;

/**
*  UpdateTask2 かどうかを取得または設定します。
*/
@property (nonatomic) BOOL isUpdateTask2;

/**
*  seriesCollection が更新されたかどうかを取得または設定します。
*/
@property (nonatomic) BOOL isSeriesCollectionUpdated;

/**
*  collectionView が更新されたかどうかを取得または設定します。
*/
@property (nonatomic) BOOL isCollectionViewUpdated;

/**
*  更新イベントの引数を取得または設定します。
*/
@property (nonatomic) XuniNotifyCollectionChangedEventArgs *updateEventArgs;

/**
*  直前の Y 軸の最大値を取得または設定します。
*/
@property (nonatomic) double prevAxisYMax;

/**
*  直前の Y 軸の最小値を取得または設定します。
*/
@property (nonatomic) double prevAxisYMin;

/**
*  直前の X 軸の最大値を取得または設定します。
*/
@property (nonatomic) double prevAxisXMax;

/**
*  前の軸 X の最小値を取得または設定します。
*/
@property (nonatomic) double prevAxisXMin;

/**
*  直前の X 値の配列を取得または設定します。
*/
@property (nonatomic) NSMutableArray *prevXValsArray;

/**
*  直前の Y 軸の値配列を取得または設定します。
*/
@property (nonatomic) NSMutableArray *prevYValsArray;

/**
*  @exclude.
*/
@property (nonatomic) NSMutableDictionary *stackAbs;

/**
*  チャートの更新アニメーションが表示中かどうかを取得します。
*/
@property (readonly) BOOL isChartUpdate;

/**
*  plotElementLoading イベントを取得または設定します。
*/
@property (nonatomic) XuniEvent<XuniChartPlotElementEventArgs*> *plotElementLoading;

/**
*  プロット要素がロードされる前に plotElementLoading event イベントを発生させます。
*    @param args イベント引数
*/
- (void)onPlotElementLoading:(XuniChartPlotElementEventArgs *)args;

/**
*  ポイントをコントロール座標からチャートデータ座標に変換します。
*    @param point コントロール座標のポイント
*    @return チャートデータ座標のポイント
*/
- (XuniPoint*)pointToData:(XuniPoint*)point;

/**
*  ポイントのチャートデータ座標をコントロール座標に変換します。
*    @param point  チャートデータ座標のポイント
*    @return コントロール座標のポイント
*/
- (XuniPoint*)dataToPoint:(XuniPoint*)point;

/**
*  指定されたデータポイントの情報を HitTestInfo オブジェクトとして取得します。
*    @param point 画面座標内の調査するポイント
*    @return データポイントの情報を含む XuniChartHitTestInfo オブジェクト
*/
- (XuniChartHitTestInfo *)hitTest:(XuniPoint *)point;

// Internal methods
/**
*  イージングタイプを取得します。
*    @return イージングタイプ
*/
- (id<IXuniEaseAction> )getEasing;

/**
*  フォントのディスクリプタを取得します。
*    @param attributes フォント属性
*    @return ディスクリプタ
*/
- (UIFontDescriptor*)getDescriptor:(NSMutableDictionary*)attributes;

/**
*  系列が選択されているかどうかを判定します。
*    @param series  系列
*    @return boolean 選択されている場合は true
*/
- (BOOL)isSeriesSelected:(XuniSeries*)series;

/**
*  X/Y軸周辺のデータポイントを配列で取得します。
*    @param x X 座標
*    @param y Y 座標
*    @return return データポイントの配列
*/
- (NSArray *)getDataPointsAroundPoint:(double)x y:(double)y;

/**
*  値を取得します。
*    @param index      系列のインデックス
*    @param formatted  書式が設定されているかどうか
*    @param pointIndex 系列のポイントインデックス
*    @param series     系列
*    @return 値
*/
- (id)getHitTestInfoValue:(int)index formatted:(BOOL)formatted pointIndex:(int)pointIndex series:(XuniSeries*)series;

/**
*  チャート要素の特定の場所についての情報を取得します。
*    @param point       指定するチャート内データの Point 座標
*    @param seriesIndex 系列のインデックス
*    @return 指定されたポイントのチャート要素
*/
- (XuniChartHitTestInfo *)hitTestSeries:(XuniPoint *)point seriesIndex:(int)seriesIndex;

/**
*  近似値に基づいて補間する値を取得します。
*    @param arrvalues 値の配列
*    @param index     インデックス
*    @param count     値の個数
*    @return 補間する値
*/
- (double)getInterpolatedValue:(NSArray *)arrvalues index:(int)index count:(int)count;

/**
*  すべての系列が非表示かどうかを判断します。
*    @return 非表示の場合はtrue
*/
- (BOOL)isAllSeriesHidden;

@end
