//
//  FlexChartBaseEnums.h
//  XuniChartCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XuniChartCore_FlexChartBaseEnums_h
#define XuniChartCore_FlexChartBaseEnums_h



/**
*  凡例の方向を識別します。
*/
typedef NS_ENUM(NSInteger, XuniChartLegendOrientation){
/**
*  凡例を水平方向に表示
*/
    XuniChartLegendOrientationHorizontal,
/**
*  凡例を垂直に整列して配置
*/
    XuniChartLegendOrientationVertical,
/**
*  凡例の表示向きを自動的に設定
*/
    XuniChartLegendOrientationAuto
};


/**
*  チャートタイプを指定する列挙型
*/
typedef NS_ENUM(NSInteger, XuniChartType) {
/**
*  チャートタイプなし
*/
    XuniChartTypeNull,
/**
*  横棒グラフ
*/
    XuniChartTypeColumn,
/**
*  横棒グラフ
*/
    XuniChartTypeBar,
/**
*  散布図
*/
    XuniChartTypeScatter,
/**
*  折れ線グラフ
*/
    XuniChartTypeLine,
/**
*  折れ線グラフ（シンボル付き）
*/
    XuniChartTypeLineSymbols,
/**
*  面グラフ
*/
    XuniChartTypeArea,
/**
*  バブルチャート
*/
    XuniChartTypeBubble,
/**
*  ローソク足チャート
*/
    XuniChartTypeCandlestick,
/**
*  HLOC（ High-Low-Open-Close ） チャート
*/
    XuniChartTypeHighLowOpenClose,
/**
*  スプライングラフ
*/
    XuniChartTypeSpline,
/**
*  スプライングラフ（シンボル付き）
*/
    XuniChartTypeSplineSymbols,
/**
*  スプライン面グラフ
*/
    XuniChartTypeSplineArea
};


/**
*  チャート要素の列挙型
*/
typedef NS_ENUM(NSInteger, XuniChartElement) {
/**
*  チャートのプロット領域要素
*/
    XuniChartElementPlotArea,
/**
*  チャートの X 軸要素
*/
    XuniChartElementAxisX,
/**
*  チャートの Y 軸要素
*/
    XuniChartElementAxisY,
/**
*  チャート領域の要素
*/
    XuniChartElementChartArea,
/**
*  チャートの凡例要素
*/
    XuniChartElementLegend,
/**
*  チャートのヘッダー要素
*/
    XuniChartElementHeader,
/**
*  チャートのフッター要素
*/
    XuniChartElementFooter,
/**
*  チャートの注釈（アノテーション）要素
*/
    XuniChartElementAnnotation,
/**
*  チャートの要素なし
*/
    XuniChartElementNone
};

/**
*  系列の表示/非表示を指定します。
*/
typedef NS_ENUM(NSInteger, XuniSeriesVisibility) {
/**
*  系列を表示する
*/
    XuniSeriesVisibilityVisible,

/**
*  系列のプロットの表示/非表示を設定します。
*/
    XuniSeriesVisibilityPlot,

/**
*  凡例の表示/非表示を設定します。
*/
    XuniSeriesVisibilityLegend,

/**
*  系列を非表示
*/
    XuniSeriesVisibilityHidden
};

/**
*  チャートデータの積層オプションを指定します。
*/
typedef NS_ENUM(NSInteger, XuniStacking) {
/**
*  チャート系列を積層なしに設定
*/
    XuniStackingNone,

/**
*  チャート系列を積層して描画
*/
    XuniStackingStacked,

/**
*  チャート系列を積層で描画し、データの合計が100%になるように正規化します。
*/
    XuniStackingStacked100pc
};

/**
*  チャートのデータ選択モードを指定する列挙型
*/
typedef NS_ENUM(NSInteger, XuniSelectionMode) {
/**
*  選択モードは指定しない
*/
    XuniSelectionModeNone,
/**
*  選択モードは系列
*/
    XuniSelectionModeSeries,
/**
*  選択モードはデータポイント
*/
    XuniSelectionModePoint
};


/**
*  2 ポイント間の距離を測定する方法を指定します。
*/
typedef NS_ENUM(NSInteger, XuniMeasureOption) {
/**
*  2 ポイント間の距離を X 座標間の距離として測定
*/
    XuniMeasureOptionX,
/**
*  2 ポイント間の距離を Y 座標間の距離として測定
*/
    XuniMeasureOptionY,
/**
*  2 ポイント間の距離を測定
*/
    XuniMeasureOptionXY
};


/**
*  グラフの軸または凡例の位置を指定する列挙型
*/
typedef NS_ENUM(NSInteger, XuniPosition) {
/**
*  軸や凡例の位置を指定しない
*/
    XuniPositionNone,
/**
*  軸や凡例を左に配置
*/
    XuniPositionLeft,
/**
*  軸や凡例を上に配置
*/
    XuniPositionTop,
/**
*  軸や凡例を右に配置
*/
    XuniPositionRight,
/**
*  軸や凡例を下に配置
*/
    XuniPositionBottom
};

/**
*  グラフの軸または凡例の位置を指定する列挙型
*/
typedef NS_ENUM(NSInteger, XuniChartLegendPosition) {
/**
*  凡例の表示位置を指定しない
*/
    XuniChartLegendPositionNone,
/**
*  軸や凡例の表示位置は左
*/
    XuniChartLegendPositionLeft,
/**
*  凡例の表示位置は上
*/
    XuniChartLegendPositionTop,
/**
*  凡例の表示位置は右
*/
    XuniChartLegendPositionRight,
/**
*  凡例の表示位置は下
*/
    XuniChartLegendPositionBottom,
/**
*  凡例の表示位置を自動的に設定
*/
    XuniChartLegendPositionAuto
};


/**
*  プロットされたポイントをどのようにアニメーション表示するかを指定します。
*/
typedef NS_ENUM(NSInteger, XuniAnimationMode) {
/**
*  アニメーションモードはすべて
*/
    XuniAnimationModeAll,
/**
*  アニメーションモードはデータポイント
*/
    XuniAnimationModePoint,
/**
*  アニメーションモードは系列
*/
    XuniAnimationModeSeries
};

/**
*  系列プロットデータポイントマーカータイプ
*/
typedef NS_ENUM(NSInteger, XuniMarkerType) {
/**
*  データポイントをドットでマークします。
*/
    XuniMarkerTypeDot,
/**
*  データポイントを四角形のボックスでマーク
*/
    XuniMarkerTypeBox
};

#endif
