//
//  Series.h
//  XuniChartCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

/**
*/
@class FlexChart;
/**
*/
@class XuniHitTestInfo;
/**
*/
@class XuniRenderEngine;
/**
*/
@class XuniAxis;
/**
*/
@class XuniCollectionView;

/**
*  データ系列のインタフェース
*/
@protocol IXuniSeries

/**
*  この系列のチャートタイプを取得または設定します。
*/
@property (nonatomic) XuniChartType chartType;

/**
*  プロット要素の塗りつぶしに使用される色を取得または設定します。
*/
@property (nonatomic) UIColor *color;

/**
*  プロット要素の境界線の色を取得または設定します。
*/
@property (nonatomic) UIColor *borderColor;

/**
*  プロット要素の境界線の幅を取得または設定します。
*/
@property (nonatomic) double borderWidth;

/**
*  プロット要素に適用される不透明度の値を取得します。
*/
@property (nonatomic) double opacity;

/**
*  シンボルの塗りつぶしに使用される色を取得または設定します。
*/
@property (nonatomic) UIColor *symbolColor;

/**
*  シンボルの境界線の色を取得または設定します。
*/
@property (nonatomic) UIColor *symbolBorderColor;

/**
*  シンボルの境界線の幅を取得または設定します。
*/
@property (nonatomic) double symbolBorderWidth;

/**
*  シンボルの不透明度を取得または設定します。
*/
@property (nonatomic) double symbolOpacity;

/**
*  シンボルのマーカーを取得または設定します。
*/
@property (nonatomic) XuniMarkerType symbolMarker;

/**
*  シンボルのサイズを取得または設定します。
*/
@property (nonatomic) double symbolSize;

/**
*  系列のアニメーションの表示時間を取得または設定します。
*/
@property (nonatomic) double animationTime;

/**
*  系列のアニメーションの遅延時間を取得または設定します。
*/
@property (nonatomic) double animationDuration;

/**
*  系列の要素の行番号を取得または設定します。
*/
@property (nonatomic) int itemRowNum;

/**
*  系列の要素の列番号を取得または設定します。
*/
@property (nonatomic) int itemColumnNum;

/**
*  値を取得します。
*    @param dim データ型を識別するために使用
*    @return 値
*/
- (NSArray*)getValues:(int)dim;

/**
*  データ型を取得します。
*    @param dim データ型を識別するために使用
*    @return データ型
*/
- (XuniDataType)getDataType:(int)dim;

/**
*  凡例を描画します。
*    @param engine レンダリングエンジン
*    @param rect   凡例を描画する四角形領域
*/
- (void)drawLegendItem:(XuniRenderEngine*)engine inRect:(XuniRect*)rect;

/**
*  系列項目のサイズを計測して取得します。
*    @param engine レンダリングエンジン
*    @return 系列項目のサイズ
*/
- (XuniSize*)measureLegendItem:(XuniRenderEngine*)engine;

@end

/**
*  チャートの系列を表示します。
*/
@interface XuniSeries : NSObject<IXuniSeries>

/**
*  この系列を所有する FlexChart オブジェクト
*/
@property (nonatomic) FlexChart *chart;

/**
*  系列に連結する X 軸
*/
@property (nonatomic) XuniAxis *axisX;

/**
*  系列に連結された Y 軸
*/
@property (nonatomic) XuniAxis *axisY;

/**
*  X 軸の名前を取得または設定します。
*/
@property (nonatomic) NSString *axisXname;

/**
*  Y 軸の名前を取得します。
*/
@property (nonatomic) NSString *axisYname;

/**
*  この系列のチャートタイプを取得または設定します。
*/
@property (nonatomic) XuniChartType chartType;

/**
*  汎用に表示する系列の名前を取得または設定します。名前のない系列は凡例に表示されません。
*/
@property (nonatomic) NSString *name;

/**
*  Y 軸に値をプロットするデータの連結プロパティ名を取得または設定します。
*/
@property (nonatomic) NSString *binding;

/**
*  X 軸にプロットされるデータの連結プロパティ名を取得または設定します。
*/
@property (nonatomic) NSString *bindingX;

/**
*  系列のデータソースを取得または設定します。
*/
@property (nonatomic) NSMutableArray *itemsSource;

/**
*  系列データを含むコレクションビュー（ XuniCollectionView ）を取得します。
*/
@property (nonatomic) XuniCollectionView *collectionView;

/**
*  系列の表示状態を取得または設定します。
*/
@property (nonatomic) XuniSeriesVisibility visibility;

/**
*  プロット要素の塗りつぶしに使用される色を取得または設定します。
*/
@property (nonatomic) UIColor *color;

/**
*  プロット要素の境界線の色を取得または設定します。
*/
@property (nonatomic) UIColor *borderColor;

/**
*  プロット要素の境界線の幅を取得または設定します。
*/
@property (nonatomic) double borderWidth;

/**
*  プロット要素に適用される不透明度の値を取得します。
*/
@property (nonatomic) double opacity;

/**
*  シンボルの塗りつぶしに使用される色を取得または設定します。
*/
@property (nonatomic) UIColor *symbolColor;

/**
*  シンボルの境界線の色を取得または設定します。
*/
@property (nonatomic) UIColor *symbolBorderColor;

/**
*  シンボルの境界線の幅を取得または設定します。
*/
@property (nonatomic) double symbolBorderWidth;

/**
*  シンボルの不透明度を取得または設定します。
*/
@property (nonatomic) double symbolOpacity;

/**
*  シンボルのマーカーを取得または設定します。
*/
@property (nonatomic) XuniMarkerType symbolMarker;

/**
*  シンボルのサイズを取得または設定します。
*/
@property (nonatomic) double symbolSize;

/**
*  系列の値を取得または設定します。
*/
@property (nonatomic, readonly) NSArray* values;

/**
*  系列の X 値を取得または設定します。
*/
@property (nonatomic, readonly) NSArray* xvalues;

/**
*  系列のアニメーションの表示時間を取得または設定します。
*/
@property (nonatomic) double animationTime;

/**
*  系列のアニメーションの遅延時間を取得または設定します。
*/
@property (nonatomic) double animationDuration;

/**
*  系列の要素の行番号を取得または設定します。
*/
@property (nonatomic) int itemRowNum;

/**
*  系列の要素の列番号を取得または設定します。
*/
@property (nonatomic) int itemColumnNum;

// Internal methods

/**
*  系列オブジェクトを初期化します
*    @return 系列オブジェクト
*/
-(instancetype)init;
/**
*  系列オブジェクトを初期化します。
*    @param chart   FlexChart オブジェクト
*    @param binding 連結プロパティ名
*    @param name    値を取得する項目
*    @return 系列オブジェクト
*/
- (id)initForChart:(FlexChart *)chart binding:(NSString *)binding name:(NSString *)name;

/**
*  タッチした領域の情報を取得します。
*    @param point ヒットテスト情報( HitTestInfo )が参照するチャート内の座標ポイント
*    @return 該当する領域の情報
*/
- (XuniHitTestInfo*)hitTest:(XuniPoint*)point;

/**
*  タッチした領域の情報を取得します。
*    @param x ポイントの X 値
*    @param y ポイントの Y 値
*    @return 該当する領域の情報
*/
- (XuniHitTestInfo*)hitTest:(double)x y:(double)y;

/**
*  値をクリアします。
*/
- (void)clearValues;

/**
*  インデックスに該当した項目を取得します。
*    @param pointIndex 項目のインデックス
*    @return 該当する項目
*/
- (id)getItem:(NSInteger)pointIndex;

/**
*  連結された値を取得します。
*    @param index 連結オブジェクト配列のインデックス
*    @return 連結された値
*/
- (NSArray*)getBindingValues:(NSInteger)index;

/**
*  連結された値を取得します。
*    @param index 連結オブジェクト配列のインデックス
*    @return 連結された値
*/
- (NSString*)getBinding:(NSInteger)index;

/**
*  データソース（ itemSource ）の件数を取得します。
*    @return データソースの件数
*/
- (NSInteger)getLength;

@end
