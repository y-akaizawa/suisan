//
//  ChartLineMarker.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XuniCoreKit_h
#import "XuniCore/Event.h"
#endif

/**
*/
@class FlexChart;
/**
*/
@class XuniChartMarkerBaseView;
/**
*/
@class XuniPoint;
/**
*/
@class XuniRect;
/**
*/
@class XuniSize;

#import "IChartMarkerRender.h"



#define DRAG_OFFSET 25

/**
*  XuniChartLineMarker クラス
*/
@interface XuniChartLineMarker : NSObject

/**
*  positionChanged イベントを取得または設定します。
*/
@property (nonatomic) XuniEvent<XuniEventArgs*> *positionChanged;

/**
*  ラインマーカーの線の表示タイプを取得または設定します。
*/
@property (nonatomic) XuniChartMarkerLines lines;

/**
*  マーカーの操作方法タイプを取得または設定します。
*/
@property (nonatomic) XuniChartMarkerInteraction interaction;

/**
*  ラベルの配置位置を取得または設定します。
*/
@property (nonatomic) XuniChartMarkerAlignment alignment;

/**
*  マーカーラインをドラッグで操作する場合に、ラベルをドラッグできるかどうかを定義します。
*/
@property (nonatomic) BOOL dragContent;

/**
*  ラインマーカーを表示するかどうかを取得または設定します。
*/
@property (nonatomic) BOOL isVisible;

/**
*  プロット領域内のラインマーカーの水平相対位置を取得または設定します。
*/
@property (nonatomic) double horizontalPosition;

/**
*  プロット領域内のラインマーカーの垂直相対位置を取得または設定します。
*/
@property (nonatomic) double verticalPosition;

/**
*  現在の X 値をチャートの座標として取得します。
*/
@property (readonly) double x;

/**
*  現在の Y 値をチャートの座標として取得します。
*/
@property (readonly) double y;

/**
*  ラインマーカーのが表示された系列のインデックスを取得または設定します。
*/
@property (nonatomic) int seriesIndex;

/**
*  マーカーに表示するコンテンツを取得または設定します。
*/
@property (nonatomic) XuniChartMarkerBaseView *content;

/**
*  水平線の幅を取得または設定します。
*/
@property (nonatomic) double horizontalLineWidth;

/**
*  水平線の色を取得または設定します。
*/
@property (nonatomic) UIColor *horizontalLineColor;

/**
*  垂直線の幅を取得または設定します。
*/
@property (nonatomic) double verticalLineWidth;

/**
*  垂直線の色を取得または設定します。
*/
@property (nonatomic) UIColor *verticalLineColor;

/**
*  データポイントを取得または設定します。
*/
@property (nonatomic) NSArray *dataPoints;

/**
*  @exclude.
*/
@property (readonly) BOOL firstShow;

/**
*  @exclude.
*/
@property (readonly) BOOL isShowXFContent;

/**
*  XuniChartLineMarker オブジェクトを初期化します。
*    @param chart   FlexChart オブジェクト
*    @return XuniChartLineMarkerオブジェクト
*/
- (id)initWithChart:(FlexChart *)chart;

/**
*  ラインマーカーを指定した位置に表示します。
*    @param xPos   X 位置
*    @param yPos   Y 位置
*/
- (void)showAt:(double)xPos yPos:(double)yPos;

/**
*  チャートのマーカーを非表示にします。
*/
- (void)hide;

/**
*  表示する内容の位置を算出します。
*    @param contentSize 表示する内容のサイズ
*    @return 表示する位置
*/
- (XuniPoint *)calculateContentPosition:(XuniSize *)contentSize;

@end

/**
*  デフォルトのマーカーのレンダリング
*/
@interface XamarinChartMarkerRender : NSObject<IXuniChartMarkerRender>

/**
*  チャートのマーカーを表示します。
*/
- (void)show;

/**
*  チャートのマーカーを非表示にします。
*/
- (void)hide;

@end
