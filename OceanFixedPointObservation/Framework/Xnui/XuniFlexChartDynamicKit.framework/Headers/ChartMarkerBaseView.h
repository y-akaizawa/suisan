//
//  ChartMarkerBaseView.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

/**
*/
@protocol IXuniChartMarkerRender;
/**
*/
@class XuniChartLineMarker;

/**
*  XuniChartMarkerBaseView クラス
*/
@interface XuniChartMarkerBaseView : UIView<UIGestureRecognizerDelegate>

/**
*  マーカーのレンダリングを取得または設定します。
*/
@property (nonatomic) NSObject<IXuniChartMarkerRender> *markerRender;

/**
*  XuniChartMarkerBaseView のインスタンスを初期化します。
*    @param lineMarker XuniChartLineMarker のインスタンス.
*    @return XuniChartMarkerBaseView のインスタンス
*/
- (id)initWithLineMarker:(XuniChartLineMarker *)lineMarker;

@end
