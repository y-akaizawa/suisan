//
//  FlexChartBase.h
//  XuniChartCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "FlexChartBaseEnums.h"

#ifndef XUNI_INTERNAL_DYNAMIC_BUILD
#ifndef XuniCoreKit_h
#import "XuniCore/CollectionView.h"
#import "XuniCore/Drawing.h"
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
@class XuniHitTestInfo;
/**
*/
@class XuniSeries;
/**
*/
@class XuniRenderEngine;
/**
*/
@class XuniLegend;
/**
*/
@class XuniAxis;
/**
*/
@class XuniChartTooltip;
/**
*/
@class XuniLabelLoadingEventArgs;
/**
*/
@class FlexChartBase;
/**
*/
@class BasePlotElementRender;

/**
*  チャートのパレットを表示します。
*/
@protocol IXuniPalette

/**
*  インデックスに基づいてパレットからより色を取得します。
*    @param i パレット内の色のインデックス
*    @return インデックスに対応する UIColor 値
*/
- (UIColor*)getColor:(NSUInteger)i;

/**
*  インデックスに基づいてパレットからより色を取得します。
*    @param i パレット内の色のインデックス
*    @param opacity 色の不透明度
*    @return 指定されたインデックスと不透明度に対応する UIColor 値
*/
- (UIColor*)getColor:(NSUInteger)i opacity:(double)opacity;

/**
*  インデックスに基づいてパレットからより明るい色を取得します。
*    @param i パレット内の色のインデックス
*    @return 指定されたインデックスに対応する UIColor 値
*/
- (UIColor*)getColorLight:(NSUInteger)i;

/**
*  インデックスに基づいてパレットからより暗い色を取得します。
*    @param i パレット内の色のインデックス
*    @return 指定されたインデックスに対応する UIColor 値
*/
- (UIColor*)getColorDark:(NSUInteger)i;

/**
*  指定された色より明るい色を取得します。
*    @param color UIColor 値
*    @return より明るい UIColor 値
*/
- (UIColor*)lighten:(UIColor*)color;

/**
*  指定された色より明るい色を取得します。
*    @param color UIColor 値
*    @param opacity 色の不透明度
*    @return より明るい UIColor 値
*/
- (UIColor*)lighten:(UIColor*)color opacity:(double)opacity;

/**
*  指定された色より暗い色を取得します。
*    @param color UIColor 値
*    @return より暗い UIColor 値
*/
- (UIColor*)darken:(UIColor*)color;

@end

/**
*  FlexChartDelegate プロトコル
*/
@protocol FlexChartDelegate <XuniViewDelegate>
/**
*/
@optional

/**
*  選択範囲が変更されたときに何らかの処理を実行します。
*    @param sender このイベントの対象となる FlexChart オブジェクト
*    @param hitTestInfo 指定されたポイントにあるチャート要素の情報
*/
- (void)selectionChanged:(FlexChartBase*)sender hitTestInfo:(XuniHitTestInfo*)hitTestInfo;

/**
*  系列の表示/非表示が変更されたときに何らかの処理を実行します。
*    @param sender このイベントの対象となる FlexChart オブジェクト
*    @param series 変更された座標にあるチャート系列
*/
- (void)seriesVisibilityChanged:(FlexChartBase*)sender series:(XuniSeries*)series;

/**
*  軸範囲が変更されたかどうかを取得します
*    @param sender このイベントの対象となるFlexChart オブジェクト
*    @param axis   範囲が変更された軸
*/
- (void)axisRangeChanged:(FlexChartBase*)sender axis:(XuniAxis *)axis;

/**
*  カスタマイズされたツールチップを処理します。
*    @param sender イベントの対象となるFlexChart オブジェクト
*    @param point     タップされたポイント
*    @param isVisible ツールチップの表示/非表示
*    @param data      ツールチップデータ
*/
- (void)handleTooltip:(FlexChartBase*)sender point:(XuniPoint*)point isVisible:(BOOL)isVisible data:(NSArray*)data;

/**
*  プロット要素ロードイベントを処理します。
*    @param sender イベントの対象となるFlexChart オブジェクト
*    @param renderEngine レンダリングエンジン
*    @param rect 四角形領域
*    @param point ポイント
*    @param seriesIndex 系列のインデックス
*    @param pointIndex ポイントのインデックス
*    @param defaultRender デフォルトのレンダラ
*    @return boolean 値
*/
- (BOOL)handlePlotElementLoading:(FlexChartBase*)sender renderEngine:(XuniRenderEngine *)renderEngine rect:(XuniRect*)rect pointIndex:(int)pointIndex point:(XuniPoint*)point seriesIndex:(int)seriesIndex defaultRender:(BasePlotElementRender *)defaultRender;

/**
*  ラベルのロードイベントを処理します。
*    @param sender このイベントの対象となるFlexChart オブジェクト
*    @param renderEngine  レンダリングエンジン
*    @param axisIndex     軸のインデックス
*    @param eventArgs     イベント引数
*    @return boolean 値
*/
- (BOOL)handleLabelLoading:(FlexChartBase*)sender renderEngine:(XuniRenderEngine *)renderEngine axisIndex:(int)axisIndex eventArgs:(XuniLabelLoadingEventArgs*)eventArgs;

/**
*  ラインマーカー位置が変更されたとにに処理を実行します。
*    @param sender 対象となるFlexChart オブジェクト
*/
- (void)lineMarkerPositionChanged:(FlexChartBase*)sender;

@end

/**
*  FlexChart の派生元の基本コントロール
*/
@interface FlexChartBase : XuniView<IXuniPalette>

/**
*  チャートのツールチップを取得または設定します。
*/
@property (nonatomic) XuniChartTooltip* tooltip;

/**
*  プロット領域の空白設定です。これらのプロパティは、軸/プロット領域の四角形領域とヘッダー/フッター/凡例で構成される外側の四角形領域の間のスペースに影響します。
*/
@property (nonatomic) UIEdgeInsets plotMargin;

/**
*  FlexChart のパディング（隙間）を取得または設定します。
*/
@property (nonatomic) UIEdgeInsets padding;

/**
*  チャートデータを保持する IXuniCollectionView を取得します。
*/
@property (nonatomic) XuniCollectionView *collectionView;

/**
*  通知を処理するためのデリゲートを取得または設定します。
*/
@property (nonatomic, weak) id<FlexChartDelegate> delegate;

/**
*  ユーザーの操作が有効かどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL isEnabled;

/**
*  Y 軸にプロットされる連結プロパティの名前を取得または設定します。
*/
@property (nonatomic) IBInspectable NSString *binding;

/**
*  X 軸にプロットされる連結プロパティの名前を取得または設定します。
*/
@property (nonatomic) IBInspectable NSString *bindingX;

/**
*  チャート凡例オブジェクトを取得または設定します。
*/
@property (nonatomic) XuniLegend *legend;

/**
*  チャートヘッダーを取得または設定します。
*/
@property (nonatomic) IBInspectable NSString *header;

/**
*  チャートフッターを取得または設定します。
*/
@property (nonatomic) IBInspectable NSString *footer;

/**
*  チャートヘッダーのフォントを取得または設定します。
*/
@property (nonatomic) UIFont *headerFont;

/**
*  チャートヘッダーのテキスト色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *headerTextColor;

/**
*  チャートヘッダーの水平方向の配置を取得または設定します。
*/
@property (nonatomic) XuniHorizontalAlignment headerTextAlignment;

/**
*  チャートフッターのフォントを取得または設定します。
*/
@property (nonatomic) UIFont *footerFont;

/**
*  チャートフッターのテキスト色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *footerTextColor;

/**
*  チャートフッターの水平方向の配置を取得または設定します。
*/
@property (nonatomic) XuniHorizontalAlignment footerTextAlignment;

/**
*  各系列の表示に使用されるデフォルトの色を含む配列を取得または設定します。
*/
@property (nonatomic) NSArray *palette;

/**
*  凡例項目をクリックしたときに系列の表示/非表示を切り替えるかどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL legendToggle;

/**
*  FlexChart のテキスト色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *textColor;

/**
*  チャートの背景色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *backgroundColor;

/**
*  チャートの境界線の色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *borderColor;

/**
*  チャートの境界線の幅を取得または設定します。
*/
@property (nonatomic) IBInspectable double borderWidth;

/**
*  プロットエリアの背景色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *plotAreaBackgroundColor;

/**
*  チャートの選択された部分の境界線の色を取得または設定します。 chart.
*/
@property (nonatomic) IBInspectable UIColor *selectedBorderColor;

/**
*  チャートの選択された境界線の幅を取得または設定します。
*/
@property (nonatomic) IBInspectable double selectedBorderWidth;

/**
*  チャートの選択された境界線の破線を取得または設定します。
*/
@property (nonatomic) NSArray<NSNumber*>* selectedDashes;

/**
*  チャートの選択モードを取得または設定します。
*/
@property (nonatomic) XuniSelectionMode selectionMode;

/**
*  すべての系列のチャートデータソースを取得または設定します。
*/
@property (nonatomic) NSMutableArray *itemsSource;

/**
*  すべてのデータ系列のグラフタイプを取得または設定します。
*/
@property (nonatomic) XuniChartType chartType;

/**
*  チャートの選択範囲を取得または設定します。
*/
@property (nonatomic) XuniSeries *selection;

/**
*  チャート選択範囲のインデックスを取得または設定します。
*/
@property (nonatomic) int selectionIndex;

/**
*  レンダリングエンジンを取得します。
*/
@property (readonly) XuniRenderEngine* renderEngine;

/**
*  チャートの四角形領域を取得します。
*/
@property (readonly) XuniRect* rectChart;

/**
*  チャートヘッダーの四角形領域を取得します。
*/
@property (readonly) XuniRect* rectHeader;

/**
*  チャートフッターの四角形領域を取得します。
*/
@property (readonly) XuniRect* rectFooter;

/**
*  @exclude.
*/
@property (nonatomic) BOOL isSeriesVisibilityAnimation;

/**
*  チャートのレンダリングが終了したときに発生します
*/
@property XuniEvent<XuniEventArgs*> *chartRendered;

/**
*  イベント引数を作成し、onChartRendered を呼び出します。
*/
- (void) raiseChartRendered;

/**
*  チャートのレンダリングの開始前に発生します
*/
@property XuniEvent<XuniEventArgs*> *chartRendering;

/**
*  イベント引数を作成し、onChartRendering を呼び出します。
*/
- (void) raiseChartRendering;

/**
*  チャートのレンダリングの開始前に発生します
*/
@property XuniEvent<XuniPointEventArgs*> *chartTapped;

/**
*  イベント引数を作成し、onChartRendering を呼び出します。
*    @param point タップしたイベントが発生した X/Y 座標
*/
- (void) raiseChartTapped: (XuniPoint*) point;


/**
*  チャートが再描画されます。
*/
- (void)invalidate;

/**
*  チャートをリフレッシュします。
*/
- (void)refresh;

// Internal methods
/**
*  チャートのプロパティを初期化します。
*/
- (void)initInternals;

/**
*  @abstract チャートを現在のデータソースに連結します。
*/
- (void)bindChart;

/**
*  系列をクリアします。
*/
- (void)clearSeries;

/**
*  チャートのレンダリングを準備します。
*/
- (void)prepareForRender;

/**
*  チャートをレンダリングします。
*    @param engine レンダリングエンジン
*/
- (void)render:(XuniRenderEngine*)engine;

/**
*  ポイントをコントロールに変換します。
*    @param x ポイントの X 値
*    @param y ポイントの Y 値
*    @return コントロールのポイント
*/
- (XuniPoint*)toControl:(double)x y:(double)y;

/**
*  適切な凡例サイズを取得します。
*    @param engine     XuniRenderEngine オブジェクト
*    @param isVertical 縦かどうか
*    @return 適切な凡例サイズ
*/
- (XuniSize*)getLegendDesiredSize:(XuniRenderEngine*)engine isVertical:(BOOL)isVertical;

/**
*  凡例を描画します。
*    @param engine     XuniRenderEngine オブジェクト
*    @param point      チャートデータ座標のポイント
*    @param isVertical 縦かどうか
*    @param areas      系列の領域
*/
- (void)renderLegend:(XuniRenderEngine*)engine atPoint:(XuniPoint*)point isVertical:(BOOL)isVertical areas:(NSMutableArray*)areas;

/**
*  フッターまたはヘッダーのタイトルを描画します。
*    @param engine   レンダリングエンジン
*    @param rect     フッターまたはヘッダーのフレーム
*    @param title    フッターまたはヘッダーのタイトル
*    @param isFooter フッターかどうか
*    @return フレーム
*/
- (XuniRect*)drawTitle:(XuniRenderEngine*)engine rect:(XuniRect*)rect title:(NSString*)title isFooter:(BOOL)isFooter;

/**
*  データポイントが四角形領域に含まれるかどうか判定します。
*    @param rect  四角形領域
*    @param point ヒットテスト情報が参照するデータ点の座標
*    @return boolean 値
*/
+ (BOOL)contains:(XuniRect*)rect point:(XuniPoint*)point;

/**
*  テキストを描画します。
*    @param engine レンダリングエンジン
*    @param text   項目のテキスト
*    @param pos    テキストの位置
*    @param halign 水平方向の配置
*    @param valign 垂直方向の配置
*    @param sz     テキストのサイズ
*/
+ (void)renderText:(XuniRenderEngine*)engine text:(NSString*)text pos:(XuniPoint*)pos halign:(XuniHorizontalAlignment)halign valign:(XuniVerticalAlignment)valign size:(XuniSize *)sz;

/**
*  テキストを描画します。
*      @param engine レンダリングエンジン
*      @param text   項目のテキスト
*      @param pos    テキストの位置
*      @param halign 水平方向の配置
*      @param valign 垂直方向の配置
*/
+ (void)renderText:(XuniRenderEngine*)engine text:(NSString*)text pos:(XuniPoint*)pos halign:(XuniHorizontalAlignment)halign valign:(XuniVerticalAlignment)valign;

/**
*  回転したテキストをレンダリングします。
*    @param engine レンダリングエンジン
*    @param text   項目のテキスト
*    @param pos    テキストの位置
*    @param halign 水平方向の配置
*    @param valign 垂直方向の配置
*    @param center テキストの中心
*    @param angle  テキストの角度
*    @param sz     テキストのサイズ
*/
+ (void)renderRotatedText:(XuniRenderEngine*)engine text:(NSString*)text pos:(XuniPoint*)pos halign:(XuniHorizontalAlignment)halign valign:(XuniVerticalAlignment)valign center:(XuniPoint*)center angle:(double)angle size:(XuniSize *)sz;

/**
*  回転したテキストを描画します
*    @param engine レンダリングエンジン
*    @param text   項目のテキスト
*    @param pos    テキストの位置
*    @param halign 水平方向の配置
*    @param valign 垂直方向の配置
*    @param center テキストの中心
*    @param angle  テキストの角度
*/
+ (void)renderRotatedText:(XuniRenderEngine*)engine text:(NSString*)text pos:(XuniPoint*)pos halign:(XuniHorizontalAlignment)halign valign:(XuniVerticalAlignment)valign center:(XuniPoint*)center angle:(double)angle;

/**
*  軸名を使用して軸を検索します。
*    @param axisName 軸名
*    @return 軸
*/
- (XuniAxis *)findAxis:(NSString *)axisName;

@end
