//
//  FlexChartEnums.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef FlexChart_FlexChartEnums_h
#define FlexChart_FlexChartEnums_h

/**
*  チャートの重なっているラベルの処理タイプの列挙型
*/
typedef NS_ENUM(NSInteger, XuniChartOverlappingLabels){
/**
*  重なっているラベルを自動的に削除します。
*/
    XuniChartOverlappingLabelsAuto,
/**
*  重なっているラベルを削除せず表示します。
*/
    XuniChartOverlappingLabelsShow
};

/**
*  チャートの軸タイプを定義します。
*/
typedef NS_ENUM(NSInteger, XuniAxisType){
/**
*  X 軸
*/
    XuniAxisTypeX,
/**
*  Y 軸
*/
    XuniAxisTypeY
};

/**
*  軸目盛りの外観タイプの列挙型
*/
typedef NS_ENUM(NSInteger, XuniTickMark){
/**
*  目盛りを表示しません。
*/
    XuniTickMarkNone,
/**
*  目盛りはプロットエリアの外側に表示されます。
*/
    XuniTickMarkOutside,
/**
*  目盛りはプロットエリアの内側に表示されます。
*/
    XuniTickMarkInside,
/**
*  目盛りは軸に交差して表示されます。
*/
    XuniTickMarkCross
};

/**
*  ズームの方向タイプの列挙型
*/
typedef NS_ENUM(NSInteger, XuniZoomMode){
/**
*  ズームは、X 方向のみ有効です。
*/
    XuniZoomModeX,
/**
*  ズームは、Y 方向のみ有効です。
*/
    XuniZoomModeY,
/**
*  ズームは、X 方向、Y 方向とも有効です。
*/
    XuniZoomModeXY,
/**
*  ズームは、X 方向、Y 方向とも無効です。
*/
    XuniZoomModeDisabled
};

/**
*  軸のスクロール位置を定義します。
*/
typedef NS_ENUM(NSInteger, XuniAxisScrollPosition){
/**
*  軸のスクロール位置最小
*/
    XuniAxisScrollPositionMin,
/**
*  軸のスクロール位置は中央
*/
    XuniAxisScrollPositionCenter,
/**
*  軸のスクロール位置最大
*/
    XuniAxisScrollPositionMax
};

/**
*  ラインマーカーの表示線タイプの列挙型
*/
typedef NS_ENUM(NSInteger, XuniChartMarkerLines){
/**
*  マーカー線を表示しません。
*/
    XuniChartMarkerLinesNone,
/**
*  マーカー戦は水平線を表示します。
*/
    XuniChartMarkerLinesVertical,
/**
*  マーカー線を水平線で表示します。
*/
    XuniChartMarkerLinesHorizontal,
/**
*  マーカー線は垂直線、水平線の両方を表示します。
*/
    XuniChartMarkerLinesBoth
};

/**
*  ラインマーカーの操作方法タイプの列挙型
*/
typedef NS_ENUM(NSInteger, XuniChartMarkerInteraction){
/**
*  操作しません。
*/
    XuniChartMarkerInteractionNone,
/**
*  タップまたはドラッグした位置にラインマーカーを移動させます。
*/
    XuniChartMarkerInteractionMove,
/**
*  ラインマーカーの線やマーカーをドラッグして位置を変更できます。
*/
    XuniChartMarkerInteractionDrag
};

/**
*  ラインマーカーの配置を指定します。
*/
typedef NS_ENUM(NSInteger, XuniChartMarkerAlignment){
/**
*  ラインマーカーは自動で適切な位置に表示されます。
*/
    XuniChartMarkerAlignmentAuto,
/**
*  ラインマーカーはポイントの右下に配置されます。
*/
    XuniChartMarkerAlignmentBottomRight,
/**
*  ラインマーカーはポイントの左下に配置されます。
*/
    XuniChartMarkerAlignmentBottomLeft,
/**
*  ラインマーカーはポイントの右上に配置されます。
*/
    XuniChartMarkerAlignmentTopRight,
/**
*  ラインマーカーはポイントの左上に配置されます。
*/
    XuniChartMarkerAlignmentTopLeft
};

/**
*  PlotElementLoading イベントのタイプを指定する列挙型
*/
typedef NS_ENUM(NSInteger, XuniPlotElementLoadingType) {
/**
*  PlotElementLoading イベントを操作しません。既定の要素を描画します。
*/
    XuniPlotElementLoadingTypeNone,
/**
*  ネイティブの PlotElementLoading イベントを操作します。
*/
    XuniPlotElementLoadingTypeNative,
/**
*  Xamarin Forms の PlotElementLoading イベントを操作します。
*/
    XuniPlotElementLoadingTypeXF
};

/**
*  注釈の付属方法を指定する列挙型
*/
typedef NS_ENUM(NSInteger, XuniChartAnnotationAttachment) {
/**
*  注釈の座標は形状データのピクセル単位で指定されます。
*/
    XuniChartAnnotationAttachmentAbsolute,
/**
*  注釈の座標はデータの座標で指定されます。
*/
    XuniChartAnnotationAttachmentDataCoordinate,
/**
*  注釈の座標はデータ系列またはデータポイントのインデックスで指定されます。
*/
    XuniChartAnnotationAttachmentDataIndex,
/**
*  注釈の座標はコントロール内の相対位置で指定されます。左上隅が（0,0)で右下隅が(1,1)です。
*/
    XuniChartAnnotationAttachmentRelative
};

/**
*  注釈の表示位置を指定する列挙型
*/
typedef NS_ENUM(NSInteger, XuniChartAnnotationPosition) {
/**
*  注釈を対象のデータポイントの下部に表示
*/
    XuniChartAnnotationPositionBottom,
/**
*  注釈を対象のデータポイントの中央に表示
*/
    XuniChartAnnotationPositionCenter,
/**
*  注釈を対象のデータポイントの左側に表示
*/
    XuniChartAnnotationPositionLeft,
/**
*  注釈を対象のデータポイントの右側に表示
*/
    XuniChartAnnotationPositionRight,
/**
*  注釈を対象のデータポイントの上部に表示
*/
    XuniChartAnnotationPositionTop
};

#endif
