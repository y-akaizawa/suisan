//
//  GridPanel.h
//  FlexGrid
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GridRowCollection.h"
#import "GridColumnCollection.h"

/**
*/
@class FlexGrid;
/**
*/
@class GridCellRange;
/**
*/
@class GridRowCol;

/**
*  グリッドパネル内のセルの種類を定義する値を指定します。
*/
typedef NS_ENUM (NSInteger, GridCellType){
/**
*  セルタイプなし
*/
    GridCellTypeNone,
/**
*  通常のデータセル
*/
    GridCellTypeCell,
/**
*  列ヘッダーのセル
*/
    GridCellTypeColumnHeader,
/**
*  行ヘッダーのセル
*/
    GridCellTypeRowHeader,
/**
*  左上のセル
*/
    GridCellTypeTopLeft
};

/**
*  GridRowAccessor クラス
*/
@interface GridRowAccessor: NSObject

/**
*  インデックスのあるGridPanel オブジェクトを取得します。
*/
@property (readonly) GridPanel* panel;

/**
*  アクセスしている行のインデックスを取得します。
*/
@property (readonly) int rowIndex;

/**
*  GridRowAccessor オブジェクトを初期化します。
*    @param panel     指定したGridPanel
*    @param index インデックス
*    @return GridRowAccessor オブジェクト
*/
-(id)initWithPanel:(GridPanel*)panel andIndex:(int)index;

/**
*  指定された行のセルデータを取得します。
*    @param key 列
*    @return  NSObject 値
*/
- (NSObject*)objectAtIndexedSubscript:(int)key;

/**
*  列インデックスで指定されたセルのデータにオブジェクトを設定します。
*    @param obj 値、オブジェクト
*    @param key     列
*/
- (void)setObject:(NSObject*)obj atIndexedSubscript:(int)key;
@end

/**
*  GridPanel クラス
*/
@interface GridPanel : NSObject

/**
*  指定された行インデックスから行アクセサ（GridRowAccessor）を取得します。
*    @param key     指定された行
*    @return GridRowAccessorの値
*/
- (nonnull GridRowAccessor*)objectAtIndexedSubscript:(int)key;

/**
*  FlexGridPanel オブジェクトを初期化します。
*    @param grid     FlexGrid オブジェクト
*    @param cellType セルタイプ
*    @param rows     行
*    @param cols     列
*    @return GridPanel オブジェクト
*/
- (id)initWithGrid:(FlexGrid *)grid cellType:(GridCellType)cellType rows:(GridRowCollection *)rows cols:(GridColumnCollection *)cols;


/**
*  グリッドパネルを所有する FlexGrid オブジェクトを取得します。
*/
@property (readonly) FlexGrid *grid;

/**
*  このパネルに含まれるセルのタイプを取得します。
*/
@property (readonly) GridCellType cellType;

/**
*  グリッドパネル内のコンテンツの幅サイズ合計を取得します。
*/
@property (readonly) int width;

/**
*  グリッドパネル内のコンテンツの高さサイズ合計を取得します。
*/
@property (readonly) int height;

/**
*  このパネル内のコンテンツの X オフセットを取得します。
*/
@property (readonly) int offsetX;

/**
*  このパネル内のコンテンツの Y オフセットを取得します。
*/
@property (readonly) int offsetY;

/**
*  グリッドの行コレクションを取得します。
*/
@property (readonly) GridRowCollection *rows;

/**
*  グリッドの列コレクションを取得します。
*/
@property (readonly) GridColumnCollection *columns;

/**
*  ビューに現在表示されているセルの範囲を取得します。
*/
@property (readonly) GridCellRange *viewRange;

/**
*  フォントを取得します。
*/
@property (readonly) UIFont *font;

/**
*  塗りつぶしに使用される色を取得します。
*/
@property (readonly) UIColor *fillColor;
/**
*  テキストカラーを取得します。
*/
@property (readonly) UIColor *textColor;
/**
*  内部の色を取得します
*/
@property (readonly) UIColor *lineColor;
/**
*  lineWidth を取得します。
*/
@property (readonly) double lineWidth;
/**
*  textAttributes を取得します。
*/
@property (readonly) NSMutableDictionary *textAttributes;

/**
*  パラメータを指定してセルにデータを設定します。
*    @param value 値
*    @param r     行
*    @param c     列
*/
- (void)setCellData:(NSObject *)value forRow:(int)r inColumn:(int)c;

/**
*  行のセルデータを取得します。
*    @param r         行
*    @param c         列
*    @param formatted 書式設定するかどうか
*    @return NSObject 値
*/
- (NSObject *)getCellDataForRow:(int)r inColumn:(int)c formatted:(BOOL)formatted;

/**
*  行のセル四角形を取得します。
*    @param r 行
*    @param c 列
*    @return 四角形領域
*/
- (CGRect)getCellRectForRow:(int)r inColumn:(int)c;

/**
*  行のセルの四角形領域を取得します。
*    @param r 行
*    @param c 列
*    @param range 結合範囲
*    @return 四角形領域
*/
- (CGRect)getCellRectForRow:(int)r inColumn:(int)c withMergeRange:(GridCellRange*)range;


/**
*  行のセルを描画します。
*    @param r 行
*    @param c 列
*    @param b 背景付きかどうか
*/
- (void)drawCellForRow:(int)r inColumn:(int)c withBackground:(BOOL)b;

/**
*  行のセルを描画します。
*    @param r 行
*    @param c 列
*    @param b 背景付きかどうか
*    @param f 前景かどうか
*/
- (void)drawCellForRow:(int)r inColumn:(int)c withBackground:(BOOL)b andForeground:(BOOL)f;

/**
*  行のセル背景を描画します。
*    @param r 行
*    @param c 列
*    @param t 四角形領域
*    @param range 結合範囲
*/
- (void)drawCellBackgroundForRow:(int)r inColumn:(int)c withRect:(CGRect)t andRange:(GridCellRange *)range;

/**
*  行のセル背景を描画します。
*    @param r 行
*    @param c 列
*    @param t 四角形領域
*    @param range 結合範囲
*    @param customBgClr カスタマイズした背景色
*/
- (void)drawCellBackgroundForRow:(int)r inColumn:(int)c withRect:(CGRect)t andRange:(GridCellRange *)range assumingCustomBGColor:(UIColor*)customBgClr;


/**
*  列の左側境界線を表示するかどうかを指定します。 
*    @param c 列インデックス
*    @return boolean 値
*/
- (BOOL)isColLeftVisible:(int)c;

/**
*  列の右側境界線を表示するかどうかを指定します。 
*    @param c 列インデックス
*    @return boolean 値
*/
- (BOOL)isColRightVisible:(int)c;

/**
*  行の上部境界線を表示するかどうかを指定します。
*    @param r 行インデックス
*    @return boolean 値
*/
- (BOOL)isRowTopVisible:(int)r;

/**
*  行の下部境界線を表示するかどうかを指定します。
*    @param r 行のインデックス
*    @return boolean 値
*/
- (BOOL)isRowBottomVisible:(int)r;

/**
*  セルを描画します。
*/
- (void)drawCells;

/**
*  指定した行または列のキャッシュをリセットします。
*    @param rc FlexRowCol オブジェクト
*/
- (void)resetCache:(GridRowCol *)rc;

/**
*  選択範囲を描画します。
*/
- (void)drawSelection;

/**
*  固定ポイントを取得します。
*    @return 固定ポイント
*/
- (CGPoint)frozenPoint;

/**
*  グリッドパネルがクリッピングされている四角形領域を取得します。
*    @return 四角形領域
*/
- (CGRect)getClipRect;

/**
*  マーカーを取得する内部メソッドです。
*    @param pt マーカーのポイント
*/
- (int)getAdorner:(CGPoint)pt;

/**
*  内部利用。先頭列の列インデックスを取得します。
*    @return インデックス
*/
- (int)getFirstVisibleColumn;

/**
*  内部利用。先頭列の行インデックスを取得します。
*    @return インデックス
*/
- (int)getFirstVisibleRow;

@end
