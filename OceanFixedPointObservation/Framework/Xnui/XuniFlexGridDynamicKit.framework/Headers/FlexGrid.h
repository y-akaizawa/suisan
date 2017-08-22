//
//  FlexGrid.h
//  FlexGrid
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef XUNI_INTERNAL_DYNAMIC_BUILD

#ifndef XuniCoreKit_h
#import "XuniCore/CollectionView.h"
#import "XuniCore/Drawing.h"
#import "XuniCore/IXuniValueFormatter.h"
#import "XuniCore/XuniCheckBox.h"
#import "XuniCore/XuniView.h"
#endif

#else

#import <XuniCoreDynamicKit/XuniCoreDynamicKit.h>

#endif

#import "GridRowCollection.h"
#import "GridColumnCollection.h"
#import "GridPanel.h"
#import "GridCellRange.h"
#import "GridCellFactory.h"
#import "GridEventArgs.h"
#import "GridMergeManager.h"
#import "GridHitTestInfo.h"

/**
*/
@class GridMergeManager;
/**
*/
@class FlexGridDetailProvider;
/**
*/
@class GridColumn;

/**
*  FlexGrid の通知を処理するデリゲートクラス
*/
@protocol FlexGridDelegate <XuniViewDelegate>
/**
*/
@optional

/**
*  列を自動的に生成するときに発生します。
*    @param sender FlexGrid オブジェクト
*    @param propertyInfo プロパティ
*    @param column 列
*    @return boolean 列の生成をキャンセルする場合は ture
*/
- (BOOL)autoGeneratingColumn:(FlexGrid *)sender withPropertyInfo:(XuniPropertyInfo *)propertyInfo column:(GridColumn *)column;

/**
*  列のサイズが変更された後に発生します。
*    @param sender FlexGrid オブジェクト
*    @param column 列
*    @return boolean 列のサイズ変更をキャンセルする場合は ture
*/
- (void)resizedColumn:(FlexGrid *)sender column:(GridColumn *)column;

/**
*  FlexPieのキャッシュが解放される前に発生します。
*   @param sender キャッシュを開放するFlexGrid
*/
- (void)droppedCaches:(FlexGrid *)sender;

/**
*  FlexGrid が無効化される前に発生します。
*   @param sender FlexGrid オブジェクト
*/
- (void)invalidated:(FlexGrid *)sender;

/**
*  セルに表示する要素が生成されたときに発生します。
*    @param sender FlexGrid オブジェクト
*    @param panel イベントが発生した GridPanel
*    @param range セルの範囲
*    @param context 描画するコンテキスト
*    @return boolean 以降の処理がキャンセルされた場合は true 継続する場合は false（規定値）
*/
- (bool)formatItem:(FlexGrid *)sender panel:(GridPanel *)panel forRange:(GridCellRange *)range inContext:(CGContextRef)context;

/**
*  セルを上書き処理する必要がある時に発生します。
*    @param sender FlexGrid オブジェクト
*    @param panel イベントが発生した GridPanel
*    @param range セルの範囲
*    @param context 描画するコンテキスト
*    @return boolean 以降の処理がキャンセルされた場合は true 継続する場合は false（規定値）
*/
- (bool)processItemOverlay:(FlexGrid *)sender panel:(GridPanel *)panel forRange:(GridCellRange *)range inContext:(CGContextRef)context;


/**
*  セルがタップされた時に発生します。
*    @param sender FlexGrid オブジェクト
*    @param panel イベントが発生した GridPanel
*    @param range セルの範囲
*    @return boolean 以降の処理がキャンセルされた場合は true 継続する場合は false（規定値）
*/
- (bool)cellTapped:(FlexGrid *)sender panel:(GridPanel *)panel forRange:(GridCellRange *)range;

/**
*  セルがダブルタップされたときに発生します。
*    @param sender FlexGrid オブジェクト
*    @param panel イベントが発生した GridPanel
*    @param range セルの範囲
*    @return boolean 以降の処理がキャンセルされた場合は true 継続する場合は false（規定値）
*/
- (bool)cellDoubleTapped:(FlexGrid *)sender panel:(GridPanel *)panel forRange:(GridCellRange *)range;

/**
*  セルが編集モードに入る前に発生します。
*    @param sender FlexGrid オブジェクト
*    @param panel イベントが発生した GridPanel
*    @param range セルの範囲
*    @return boolean 以降の処理がキャンセルされた場合は true 継続する場合は false（規定値）
*/
- (bool)beginningEdit:(FlexGrid *)sender panel:(GridPanel *)panel forRange:(GridCellRange *)range;

/**
*  セルの編集が終了するときに発生します。
*    @param sender FlexGrid オブジェクト
*    @param panel  イベントが発生した GridPanel
*    @param range  セルの範囲
*    @param cancel 前のステップでイベントの処理をキャンセルする場合は true 
*    @return boolean 以降の処理がキャンセルされた場合は true 継続する場合は false（規定値）
*/
- (bool)cellEditEnding:(FlexGrid *)sender panel:(GridPanel *)panel forRange:(GridCellRange *)range cancel:(BOOL)cancel;

/**
*  セルがコミットまたはキャンセルされたときに発生します。
*    @param sender FlexGrid オブジェクト
*    @param panel  イベントが発生した GridPanel オブジェクト
*    @param range  範囲
*/
- (void)cellEditEnded:(FlexGrid *)sender panel:(GridPanel *)panel forRange:(GridCellRange *)range;

/**
*  編集セルが生成され、アクティブになる前に発生します。
*    @param sender FlexGrid オブジェクト
*    @param panel イベントが発生した GridPanel
*    @param range セルの範囲
*    @return boolean 以降の処理がキャンセルされた場合は true 継続する場合は false（規定値）
*/
- (bool)prepareCellForEdit:(FlexGrid *)sender panel:(GridPanel *)panel forRange:(GridCellRange *)range;

/**
*  グリッドが新しいデータソースに連結された後に発生します。
*    @param sender FlexGrid オブジェクト
*/
- (void)itemsSourceChanged:(FlexGrid *)sender;

/**
*  グリッド行がデータソースの項目に連結される前に発生します。
*    @param sender FlexGrid オブジェクト
*/
- (bool)loadingRows:(FlexGrid *)sender;

/**
*  グリッド行がデータソースの項目に連結された後に発生します。
*    @param sender FlexGrid オブジェクト
*/
- (void)loadedRows:(FlexGrid *)sender;

/**
*  グループの展開または折り畳み状態が変更されたときに発生します。
*    @param sender FlexGrid オブジェクト
*    @param panel イベントが発生した GridPanel
*    @param range セルの範囲
*    @return boolean 以降の処理がキャンセルされた場合は true 継続する場合は false（規定値）
*/
- (bool)groupCollapsedChanging:(FlexGrid *)sender panel:(GridPanel *)panel forRange:(GridCellRange *)range;

/**
*  グループが展開または折りたたまれた後に発生します。
*    @param sender FlexGrid オブジェクト
*    @param panel イベントが発生した GridPanel
*    @param range セルの範囲
*/
- (void)groupCollapsedChanged:(FlexGrid *)sender panel:(GridPanel *)panel forRange:(GridCellRange *)range;

/**
*  コントロールがスクロールして位置が変わった場合に発生します。
*    @param sender FlexGrid オブジェクト
*/
- (void)scrollPositionChanged:(FlexGrid *)sender;

/**
*  選択が変更される前に発生します。
*    @param sender FlexGrid オブジェクト
*    @param panel イベントが発生した GridPanel
*    @param range セルの範囲
*    @return boolean 以降の処理がキャンセルされた場合は true 継続する場合は false（規定値）
*/
- (bool)selectionChanging:(FlexGrid *)sender panel:(GridPanel *)panel forRange:(GridCellRange *)range;

/**
*  選択範囲が変更された後に発生します。
*    @param sender FlexGrid オブジェクト
*    @param panel イベントが発生した GridPanel
*    @param range セルの範囲
*/
- (void)selectionChanged:(FlexGrid *)sender panel:(GridPanel *)panel forRange:(GridCellRange *)range;

/**
*  列ヘッダーをタップしてソートするときに発生します。
*    @param sender FlexGrid オブジェクト
*    @param panel イベントが発生した GridPanel
*    @param range セルの範囲
*    @return boolean 以降の処理がキャンセルされた場合は true 継続する場合は false（規定値）
*/
- (bool)sortingColumn:(FlexGrid *)sender panel:(GridPanel *)panel forRange:(GridCellRange *)range;

/**
*  列ヘッダーをタップ操作してソート処理を実行した後に発生します。
*    @param sender FlexGrid オブジェクト
*    @param panel イベントが発生した GridPanel
*    @param range セルの範囲
*/
- (void)sortedColumn:(FlexGrid *)sender panel:(GridPanel *)panel forRange:(GridCellRange *)range;

- (void)cellLongPressed:(FlexGrid *)sender panel:(GridPanel *)panel forRange:(GridCellRange *)range;

@end

/**
*  行ヘッダと列ヘッダの表示/非表示を定義する列挙型
*/
typedef NS_ENUM (NSInteger, GridHeadersVisibility){
/**
*  グリッドのヘッダは表示しない
*/
    GridHeadersVisibilityNone = 0,
/**
*  グリッドの列ヘッダのみ表示
*/
    GridHeadersVisibilityColumn = 1,
/**
*  グリッドの行ヘッダのみ表示
*/
    GridHeadersVisibilityRow = 1 << 1,
/**
*  グリッドの列、行ヘッダをすべて表示
*/
    GridHeadersVisibilityAll = GridHeadersVisibilityColumn|GridHeadersVisibilityRow
};

/**
*  グリッド線の表示状態を定義する列挙型
*/
typedef NS_ENUM (NSInteger, GridLinesVisibility){
/**
*  グリッド線は非表示
*/
    GridLinesVisibilityNone = 0,
/**
*  グリッド線の水平線を表示
*/
    GridLinesVisibilityHorizontal = 1,
/**
*  垂直のグリッド線を表示
*/
    GridLinesVisibilityVertical = 1 << 1,
/**
*  すべてのグリッド線（垂直線、水平線）を表示
*/
    GridLinesVisibilityAll = GridLinesVisibilityVertical | GridLinesVisibilityHorizontal
};


/**
*  詳細行の表示モードを定義する列挙型
*/
typedef NS_ENUM (NSInteger, GridDetailVisibilityMode){
/**
*  詳細行の表示モードは指定しない
*/
    GridDetailVisibilityModeNone,
/**
*  詳細行を1件ずつ展開して表示するモード
*/
    GridDetailVisibilityModeExpandSingle,
/**
*  詳細行は複数の行を展開して表示するモード
*/
    GridDetailVisibilityModeExpandMultiple,
/**
*  詳細行は選択した行を展開して表示するモード
*/
    GridDetailVisibilityModeSelection
};

/**
*  マージ（セルの結合）の許可を定義する列挙型
*/
typedef NS_ENUM (NSInteger, GridAllowMerging){
/**
*  マージ（セルの結合）を許可しない
*/
    GridAllowMergingNone = 0,

/**
*  セルの結合を許可する
*/
    GridAllowMergingCells = 1 << 1,

/**
*  列ヘッダーのマージ（セルの結合）を許可
*/
    GridAllowMergingColumnHeaders = 1 << 2,

/**
*  行ヘッダーのマージ（セルの結合）を許可
*/
    GridAllowMergingRowHeaders = 1 << 3,

/**
*  すべてのヘッダーの結合（マージ）を許可
*/
    GridAllowMergingAllHeaders = GridAllowMergingColumnHeaders | GridAllowMergingRowHeaders,

/**
*  マージ（セルの結合）を許可
*/
    GridAllowMergingAll = GridAllowMergingCells | GridAllowMergingAllHeaders
};

/**
*  選択動作を定義する列挙型
*/
typedef NS_ENUM (NSInteger, GridSelectionMode){
/**
*  選択モードの指定なし
*/
    GridSelectionModeNone,
/**
*  選択モードはセル単位
*/
    GridSelectionModeCell,
/**
*  選択モードはセル範囲
*/
    GridSelectionModeCellRange,
/**
*  選択モードは行単位
*/
    GridSelectionModeRow,
/**
*  選択モードは行範囲
*/
    GridSelectionModeRowRange
};

/**
*  セルの選択状態を定義する列挙型
*/
typedef NS_ENUM (NSInteger, GridSelectedState){
/**
*  選択状態なし
*/
    GridSelectedStateNone,
/**
*  セルは選択されています
*/
    GridSelectedStateSelected,
/**
*  カーソルが選択されています
*/
    GridSelectedStateCursor
};

/**
*  グリッドのオートサイズモードを定義する列挙型
*/
typedef NS_ENUM (NSInteger, GridAutoSizeMode){
/**
*  オートサイズモードの指定なし
*/
    GridAutoSizeModeNone = 0,
/**
*  セルを自動的にリサイズする
*/
    GridAutoSizeModeCells = 1 << 1,
/**
*  ヘッダーを自動的にリサイズする
*/
    GridAutoSizeModeHeaders = 1 << 2,
/**
*  セル、ヘッダーの両方を自動的にリサイズする
*/
    GridAutoSizeModeBoth = GridAutoSizeModeCells | GridAutoSizeModeHeaders
};


/**
*/
@class GridRowAccessor;

/**
*  FlexGridはシンプルかつ柔軟で強力なグリッドコントロールです。
*  行と列の表形式でデータを表示するスプレッドシートの操作性をモバイルアプリで実現し、タッチ操作で行や列あるいはセルの選択をしたり、セル内容の編集も可能になります。
*/
IB_DESIGNABLE
/**
*  FlexGrid コントロールは、データを表形式で表示および編集する強力で柔軟な方法を提供します。
*/
@interface FlexGrid : XuniView<UIGestureRecognizerDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
/**
*/
;

/**
*  行インデックスを指定して行アクセス（GridRowAccessor）を取得します。
*    @param key     行
*    @return GridRowAccessor 値
*/
- (nonnull GridRowAccessor*)objectAtIndexedSubscript:(int)key;

/**
*  FlexGrid をタップする前に発生します。イベントはXuniPointEventArgsを引数に呼び出されます。
*/
@property XuniEvent<XuniPointEventArgs*> *flexGridTapped;

/**
*  FlexGrid が描画されるときに発生します。イベントは XuniEventArgs を引数に呼び出されます。
*/
@property XuniEvent<XuniEventArgs*> *flexGridRendering;

/**
*  FlexGrid オブジェクトが描画されたときに発生します。イベントは XuniEventArgs を引数に呼び出されます。
*/
@property XuniEvent<XuniEventArgs*> *flexGridRendered;

/**
*  FlexGrid が無効化されている場合に発生します。イベントは XuniEventArgs を引数に呼び出されます。
*/
@property XuniEvent<XuniEventArgs*> *flexGridInvalidated;

/**
*  FlexGridのキャッシュを開放したときに発生します。
*/
@property XuniEvent<XuniEventArgs*> *flexGridDroppedCaches;

/**
*  セルに描画する要素が作成されたときに発生します。イベントはFlexFormatItemEventArgsを引数に呼び出されます。
*/
@property XuniEvent<GridFormatItemEventArgs*> *flexGridFormatItem;

/**
*  セルを上書き処理する必要がある時に発生します。
*/
@property XuniEvent<GridFormatItemEventArgs*> *flexGridProcessItemOverlay;

/**
*  セルがタップされたときに発生します。イベントは FlexCellRangeEventArgs を引数に呼び出されます。
*/
@property XuniEvent<GridCellRangeEventArgs*> *flexGridCellTapped;

/**
*  セルがダブルタップされたときに発生します。イベントは FlexCellRangeEventArgs を引数に呼び出されます。
*/
@property XuniEvent<GridCellRangeEventArgs*> *flexGridCellDoubleTapped;

/**
*  セルが編集モードになる前に発生します。イベントは FlexCellRangeEventArgs を引数に呼び出されます。
*/
@property XuniEvent<GridCellRangeEventArgs*> *flexGridBeginningEdit;

/**
*  セルの編集が終了したときに発生します。イベントは FlexCellRangeEventArgs を引数に呼び出されます。
*/
@property XuniEvent<GridCellRangeEventArgs*> *flexGridCellEditEnding;

/**
*  セルの編集が終了した後に発生します。イベントは FlexCellRangeEventArgs を引数に呼び出されます。
*/
@property XuniEvent<GridCellRangeEventArgs*> *flexGridCellEditEnded;

/**
*  編集セルが作成され、アクティブな状態になる前に発生します。イベントは FlexCellRangeEventArgs を引数に呼び出されます。
*/
@property XuniEvent<GridCellRangeEventArgs*> *flexGridPrepareCellForEdit;

/**
*  グリッドが新しいデータソース（ItemSource）に接続した後に発生します。イベントは  XuniEventArgs を引数に呼び出されます。
*/
@property XuniEvent<XuniEventArgs*> *flexGridItemsSourceChanged;

/**
*  グリッドの行がデータソース内の項目に接続される前に発生します。イベントは  XuniEventArgs を引数に呼び出されます。
*/
@property XuniEvent<XuniEventArgs*> *flexGridLoadingRows;

/**
*  グリッドの行がデータソース内の項目に接続された後に発生します。イベントは  XuniEventArgs を引数に呼び出されます。
*/
@property XuniEvent<XuniEventArgs*> *flexGridLoadedRows;

/**
*  グループの展開または折り畳み状態が変更されたときに発生します。イベントはFlexCellRangeEventArgs を引数に呼び出されます。
*/
@property XuniEvent<GridCellRangeEventArgs*> *flexGridGroupCollapsedChanging;

/**
*  グループの展開または折り畳み状態が変更されたときに発生します。イベントは FlexCellRangeEventArgs を引数に呼び出されます。
*/
@property XuniEvent<GridCellRangeEventArgs*> *flexGridGroupCollapsedChanged;

/**
*  FlexGrid のグリッドがスクロールした後に発生します。イベントは XuniEventArgs を引数に呼び出されます。
*/
@property XuniEvent<XuniEventArgs*> *flexGridScrollPositionChanged;

/**
*  選択が変更される前に発生します。イベントは FlexCellRangeEventArgs を引数に呼び出されます。
*/
@property XuniEvent<GridCellRangeEventArgs*> *flexGridSelectionChanging;

/**
*  選択が変更されたときに発生します。イベントは FlexCellRangeEventArgs を引数に呼び出されます。
*/
@property XuniEvent<GridCellRangeEventArgs*> *flexGridSelectionChanged;

/**
*  ユーザーが列ヘッダーをタップしてソートを適用する前に発生します。イベントはFlexCellRangeEventArgsを引数に呼び出されます。
*/
@property XuniEvent<GridCellRangeEventArgs*> *flexGridSortingColumn;

/**
*  列ヘッダーをタップしてソート処理を実行した後に発生します。イベントは  FlexCellRangeEventArgs を引数に呼び出されます。
*/
@property XuniEvent<GridCellRangeEventArgs*> *flexGridSortedColumn;

/**
*  列を自動的に生成したときに発生します。
*/
@property XuniEvent<GridAutoGeneratingColumnEventArgs*> *flexGridAutoGeneratingColumn;

/**
*  列ヘッダーをタップ操作で列の大きさを変更したときに発生します。イベントは  FlexCellRangeEventArgs を引数に呼び出されます。
*/
@property XuniEvent<GridResizedColumnEventArgs*> *flexGridResizedColumn;

@property XuniEvent<GridCellRangeEventArgs*> *flexGridCellLongPressed;

/**
*  FlexGridのキャッシュを開放します。
*/
- (void)dropCaches;


/**
*  アンバウンドモードで値をグリッドのスクロールが可能な領域内のセルに設定します。
*    @param data      値
*    @param r         行
*    @param c         列
*/
- (void)setCellData:(NSObject *)data forRow:(int)r inColumn:(int)c;


/**
*  グリッドのスクロールが最下部に達した場合に trueを返します。
*    @return boolean 値
*/
- (bool)isScrolledToBottom;

/**
*  オートサイズモードを取得または設定します。
*/
@property (nonatomic) GridAutoSizeMode autoSizeMode;

/**
*  マージ（セルの結合）を許可する内容を取得または設定します。
*/
@property (nonatomic) GridAllowMerging allowMerging;

/**
*  マージを管理する GridMergeManager を取得または設定します。
*/
@property (nonatomic) GridMergeManager *mergeManager;

/**
*  詳細行を管理する FlexGridDetailProvider を取得または設定します。
*/
@property (nonatomic) FlexGridDetailProvider *detailProvider;

/**
*  タッチフィードバックの状態を表します。true のときは有効
*/
@property IBInspectable BOOL touchFeedback;

/**
*  グリッドの列幅の変更を許可するかどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL allowResizing;

/**
*  サイズ変更中の列のインデックスを取得します。
*/
@property (readonly) int columnBeingSized;

/**
*  通知を処理するためのデリゲートを取得または設定します。
*/
@property (nonatomic, weak) id<FlexGridDelegate> delegate;

/**
*  すべての系列のグリッドデータソースを取得または設定します。
*/
@property (nonatomic) NSMutableArray *itemsSource;

/**
*  グリッドに表示するデータを含む  ICollectionView を取得します。
*/
@property (nonatomic) XuniCollectionView *collectionView;




/**
*  行ヘッダと列ヘッダを表示するかどうかを決定する値を取得または設定します。
*/
@property (nonatomic) GridHeadersVisibility headersVisibility;

/**
*  現在の選択モードを取得または設定します。
*/
@property (nonatomic) GridSelectionMode selectionMode;

/**
*  グリッドがデータソース（ itemsSource ）に基づいて自動的に列を生成するかどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL autoGenerateColumns;

/**
*  ユーザーの操作が有効かどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable  BOOL isEnabled;

/**
*  ユーザーがダブルタップによってグリッドセルを編集できるかどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL isReadOnly;

/**
*  ユーザーが列ヘッダセルをクリックして列をソートできるかどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL allowSorting;

/**
*  グリッドの列ヘッダにソートインジケータを表示するかどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL showSort;

/**
*  データグループを区切るためにグリッドにグループ行を挿入するかどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL showGroups;

/**
*  データセルを含むグリッドパネルを取得します。
*/
@property (readonly) GridPanel *cells;

/**
*  列ヘッダセルを保持するグリッドパネルを取得します。
*/
@property (readonly) GridPanel *columnHeaders;

/**
*  行ヘッダセルを保持するグリッドパネルを取得します。
*/
@property (readonly) GridPanel *rowHeaders;

/**
*  左上のセルを含むグリッドパネルを取得します。
*/
@property (readonly) GridPanel *topLeftCells;

/**
*  グリッドの行コレクションを取得します。
*/
@property (readonly) GridRowCollection *rows;

/**
*  グリッドの列コレクションを取得します。
*/
@property (readonly) GridColumnCollection *columns;

/**
*  グリッドのクライアント四角形領域を取得します。
*/
@property (readonly) CGRect clientRect;

/**
*  現在の選択範囲を取得または設定します。
*/
@property (nonatomic) GridCellRange *selection;

/**
*  現在アクティブなセルエディタを表す UIView を取得します。
*/
@property (nonatomic) UIView *activeEditor;

/**
*  現在アクティブなセルエディタの基底値を取得します。
*/
@property (readonly) NSObject *activeEditorValue;

/**
*  現在編集中のセルを識別するセル範囲を取得します。
*/
@property (readonly) GridCellRange *editRange;

/**
*  ビューに現在表示されているセルの範囲を取得します。
*/
@property (readonly) GridCellRange *viewRange;

/**
*  このグリッドのセルを作成して更新するセルファクトリ（CellFactory）を取得します。
*/
@property (nonatomic) GridCellFactory *cellFactory;

/**
*  コントロールの境界線のストローク色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *borderColor;

/**
*  FlexGrid コントロールの境界線の色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *frozenCellsBorderColor;

/**
*  コントロール内のテキストとシンボルの前景色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *textColor;

/**
*  コントロールのフォントを取得または設定します。
*/
@property (nonatomic) UIFont *font;

/**
*  奇数行の背景に使用する色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *alternatingRowBackgroundColor;

/**
*  列ヘッダの背景色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *columnHeaderBackgroundColor;

/**
*  列ヘッダのテキスト色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *columnHeaderTextColor;

/**
*  列ヘッダのフォントを取得または設定します。
*/
@property (nonatomic) UIFont *columnHeaderFont;

/**
*  セル間にある線の描画に使用する色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *gridLinesColor;

/**
*  表示するグリッド線を示す値を取得または設定します。
*/
@property (nonatomic) GridLinesVisibility gridLinesVisibility;

/**
*  グリッド線の幅を取得または設定します。
*/
@property (nonatomic) IBInspectable double gridLinesWidth;

/**
*  グループヘッダーに表示するテキストの書式文字列を取得または設定します。
*/
@property (nonatomic) IBInspectable NSString *groupHeaderFormat;

/**
*  グループ化された行の背景色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *groupRowBackgroundColor;

/**
*  グループ化された行のテキスト色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *groupRowTextColor;

/**
*  行ヘッダセルと列ヘッダセルの間にある線の描画に使用する色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *headerGridLinesColor;

/**
*  選択された列ヘッダと行ヘッダの背景色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *headerSelectedBackgroundColor;

/**
*  選択された列ヘッダと行ヘッダのテキスト色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *headerSelectedTextColor;

/**
*  行ヘッダの背景色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *rowHeaderBackgroundColor;

/**
*  行ヘッダーのテキスト色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *rowHeaderTextColor;

/**
*  行ヘッダのフォントを取得または設定します。
*/
@property (nonatomic) UIFont *rowHeaderFont;

/**
*  選択マーカーの塗りつぶしに使用される色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *selectionAdornerColor;

/**
*  選択マーカーの境界線の色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *selectionAdornerBorderColor;

/**
*  選択されたセルの背景色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *selectionBackgroundColor;

/**
*  選択されたセルのテキスト色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *selectionTextColor;

/**
*  異なるレベルの行グループをオフセットするために使用されるインデントを取得または設定します。
*/
@property (nonatomic) IBInspectable double treeIndent;

/**
*  コントロールが現在タッチイベントを処理中かどうかを示す値を取得します。
*/
@property (readonly) BOOL isTouching;

/**
*  コントロールが現在更新されているかどうかを示す値を取得します。
*/
@property (readonly) BOOL isUpdating;

/**
*  グリッドのスクロール位置を表すポイントを取得または設定します。
*/
@property (nonatomic) CGPoint scrollPosition;

/**
*  固定行の数を取得または設定します。
*/
@property (nonatomic) IBInspectable int frozenRows;

/**
*  固定列の数を取得または設定します。
*/
@property (nonatomic) IBInspectable int frozenColumns;

/**
*  列ヘッダーを表示する行を取得または設定します。
*/
@property (nonatomic) GridRow* columnHeaderRow;

@property (nonatomic, readonly) UILongPressGestureRecognizer* longPressRecognizer;

/**
*  値フォーマッター（ValueFormatter）を取得または設定します。
*/
@property (nonatomic) NSObject<IXuniValueFormatter> *valueFormatter;

/**
*  FlexChart のグリッド表示をリフレッシュします。
*/
- (void)invalidate;

/**
*  ビューポート座標内のセルの範囲を取得します。
*    @param r 行
*    @param c 列
*    @return ビューポート座標内のセルの範囲
*/
- (CGRect)getCellRectForRow:(int)r inColumn:(int)c;

/**
*  グリッドのスクロール可能領域にあるセルに格納された値を取得します。
*    @param r         行
*    @param c         列
*    @param formatted 書式設定するかどうか。
*    @return グリッドのスクロール可能領域にあるセルに格納された値
*/
- (NSObject *)getCellDataForRow:(int)r inColumn:(int)c formatted:(BOOL)formatted;

/**
*  セルの選択状態を示す FlexSelectedState 値を取得します。
*    @param r 行
*    @param c 列
*    @return セルの選択状態を示す FlexSelectedState 値
*/
- (GridSelectedState)getSelectedStateForRow:(int)r inColumn:(int)c;

/**
*  セルの編集が開始するときに発生します。
*    @param fullEdit 全体を編集する場合は true
*    @param row      行
*    @param column   列
*    @return a boolean 結果
*/
- (BOOL)startEditing:(BOOL)fullEdit row:(int)row column:(int)column;

/**
*  保留中の編集をすべてコミットし、編集モードを終了します。
*    @param cancel キャンセルするかどうか
*    @return boolean 値
*/
- (BOOL)finishEditing:(BOOL)cancel;

/**
*  すべてのグループ行を指定されたレベルに折りたたみます。
*    @param level レベル
*/
- (void)collapseGroupsToLevel:(int)level;

/**
*  ヒットテスト情報（GridHitTestInfo オブジェクト）を取得します。
*    @param point データ点（Point）
*    @return GridHitTestInfo オブジェクト
*/
- (GridHitTestInfo *)hitTest:(CGPoint)point;

/**
*  指定したセルを表示するためにグリッドをスクロールして表示領域を変更します。
*    @param r 行
*    @param c 列
*    @return グリッドがスクロールした場合はtrue
*/
- (bool)scrollIntoView:(int)r c:(int)c;

/**
*  セルの範囲を選択し、オプションで選択範囲を表示範囲までスクロールします。
*    @param range 範囲
*    @param show  表示するかどうか
*/
- (void)selectCellRange:(GridCellRange *)range show:(BOOL)show;

/**
*  セルの範囲を選択し、オプションで選択範囲を表示範囲までスクロールします。
*    @param range 範囲
*/
- (void)selectCellRange:(GridCellRange *)range;

/**
*  1 つの列をそのコンテンツに合わせてサイズ変更します。
*    @param column 列
*/
- (void)autoSizeColumn:(int)column;


/**
*  内容に合わせて列のサイズを変更します。
*    @param column 列
*    @param header 列インデックスがヘッダーを参照する場合は true。一般セルの場合は false
*/
- (void)autoSizeColumn:(int)column header:(bool)header;

/**
*  内容に合わせて列のサイズを変更します。
*    @param column 列
*    @param header 列インデックスがヘッダーを参照する場合は true。一般セルの場合は false
*    @param extra  余白
*/
- (void)autoSizeColumn:(int)column header:(bool)header extra:(int)extra;

/**
*  内容に合わせて、グリッドのすべての列のサイズを変更します。
*/
- (void)autoSizeColumns;

/**
*  指定した範囲の列を内容に合わせてサイズを変更します。
*    @param first 範囲の先頭列
*    @param last  範囲の最終列
*/
- (void)autoSizeColumns:(int)first to:(int)last;

/**
*  内容に合わせて、グリッド列範囲のサイズを変更します。
*    @param first  範囲の先頭列
*    @param last   範囲の最終列
*    @param header 列インデックスがヘッダーを参照する場合は true。一般セルの場合は false
*/
- (void)autoSizeColumns:(int)first to:(int)last header:(bool)header;

/**
*  指定した範囲の列を内容に合わせてサイズを変更します。
*    @param first 先頭列
*    @param last  最終列
*    @param header 列インデックスがヘッダーを参照する場合は true。一般セルの場合は false
*    @param extra 余白
*/
- (void)autoSizeColumns:(int)first to:(int)last header:(bool)header extra:(int)extra;


/**
*  内容にあわせて行のサイズを変更します。
*    @param row 行
*/
- (void)autoSizeRow:(int)row;


/**
*  内容に合わせて行のサイズを変更します。
*    @param row 行
*    @param header 行インデックスがヘッダーを参照する場合は true。一般セルの場合は false
*/
- (void)autoSizeRow:(int)row header:(bool)header;


/**
*  内容に合わせて行のサイズを変更します。
*    @param row 行
*    @param header 行インデックスがヘッダーを参照する場合は true。一般セルの場合は false
*    @param extra 余白
*/
- (void)autoSizeRow:(int)row header:(bool)header extra:(int)extra;


/**
*  内容に合わせてすべての行のサイズを変更します。
*/
- (void)autoSizeRows;

/**
*  指定した範囲の行を内容に合わせてサイズを変更します。
*    @param first 範囲の先頭行
*    @param last  範囲の最終行
*/
- (void)autoSizeRows:(int)first to:(int)last;

/**
*  指定した範囲の行を内容に合わせてサイズを変更します。
*    @param first 範囲の先頭行
*    @param last  範囲の最終行
*    @param header 行インデックスがヘッダーを参照する場合は true。一般セルの場合は false
*/
- (void)autoSizeRows:(int)first to:(int)last header:(bool)header;


/**
*  指定した範囲の行を内容に合わせてサイズを変更します。
*    @param first 範囲の先頭行
*    @param last  範囲の最終行
*    @param header 行インデックスがヘッダーを参照する場合は true。一般セルの場合は false
*    @param extra 余白
*/
- (void)autoSizeRows:(int)first to:(int)last header:(bool)header extra:(int)extra;

// Internal
/**
*  グリッドの原点の X 値を取得または設定します。
*/
@property (readonly) double originX;
/**
*  グリッドの原点のY 値を取得または設定します。
*/
@property (readonly) double originY;
/**
*  セルのオフセットをポイントで取得または設定します。
*/
@property (readonly) CGPoint offset;
/**
*  四角形領域内にグリッドを描画します。
*    @param rect 四角形領域
*/
- (void)drawRect:(CGRect)rect;
/**
*  項目をグループに追加します。
*    @param name  グループ名
*    @param items 項目
*/
- (void)addGroup:(NSString *)name withItems:(NSMutableArray *)items;
/**
*  グループから指定された項目を削除します。
*    @param name  グループ名
*    @param index 項目のインデックス
*/
- (void)removeFromGroup:(NSString *)name atIndex:(int)index;
/**
*  コレクションビュー（CollectionView）に項目を追加します。
*    @param item 項目
*/
- (void)addItem:(NSObject *)item;
/**
*  デフォルトの行サイズを取得します。
*    @return デフォルトの行サイズ
*/
- (int)defaultRowSize;



//################## Syntax <candies> for Interface Builder design-time configuration that are bound to FlexGrid API

/**
*  列ヘッダーの表示状態を取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL columnHeaderVisible;

/**
*  行ヘッダーの表示状態を取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL rowHeaderVisible;

/**
*  水平グリッド線の表示状態を取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL horizontalLinesVisible;

/**
*  垂直グリッド線の表示状態を取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL verticalLinesVisible;

/**
*  セルのフォントを取得または設定します。
*/
@property (nonatomic) IBInspectable NSString* fontName;

/**
*  セルのフォントサイズを取得または設定します。
*/
@property (nonatomic) IBInspectable CGFloat fontSize;

/**
*  列ヘッダーのフォントを取得または設定します。
*/
@property (nonatomic) IBInspectable NSString* columnHeaderFontName;

/**
*  列ヘッダーのフォントサイズを取得または設定します。
*/
@property (nonatomic) IBInspectable CGFloat columnHeaderFontSize;

/**
*  行ヘッダーのフォントを取得または設定します。
*/
@property (nonatomic) IBInspectable NSString* rowHeaderFontName;

/**
*  行ヘッダーのフォントサイズを取得または設定します。
*/
@property (nonatomic) IBInspectable CGFloat rowHeaderFontSize;


@end
