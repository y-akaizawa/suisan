//
//  GridCellRange.h
//  FlexGrid
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GridPanel.h"

/**
*  GridCellRange クラス
*/
@interface GridCellRange : NSObject

/**
*  FlexCellRange オブジェクトを初期化します。
*    @return FlexCellRange オブジェクト
*/
- (id)init;

/**
*  FlexCellRange オブジェクトを初期化します。
*    @param row 行
*    @param col 列
*    @return FlexCellRange オブジェクト
*/
- (id)initWithRow:(int)row col:(int)col;

/**
*  FlexCellRange オブジェクトを初期化します。
*    @param row  範囲内の最初の行
*    @param col  範囲内の最初の列
*    @param row2 範囲内の最後の行
*    @param col2 範囲内の最後の列
*    @return FlexCellRange オブジェクト
*/
- (id)initWithRow:(int)row col:(int)col row2:(int)row2 col2:(int)col2;

/**
*  FlexCellRange オブジェクトを複製してクローンを作成します。
*    @return FlexCellRange オブジェクト
*/
- (GridCellRange *)clone;

/**
*  2 つの FlexCellRange オブジェクトが等しいかどうかを判定します。
*    @param other 比較するもう一方の FlexCellRange オブジェクト
*    @return boolean 値
*/
- (BOOL)isEqual:(GridCellRange *)other;

/**
*  2 つのオブジェクトに共通部分があるかどうかを判定します。
*    @param other 比較するもう一方の FlexCellRange オブジェクト
*    @return boolean 値
*/
- (BOOL)intersects:(GridCellRange *)other;

/**
*  この範囲内の最初の行のインデックスを取得または設定します。
*/
@property int row;

/**
*  この範囲内の最初の列のインデックスを取得または設定します。
*/
@property int col;

/**
*  この範囲内の最後の行のインデックスを取得または設定します。
*/
@property int row2;

/**
*  この範囲内の最後の列のインデックスを取得または設定します。
*/
@property int col2;

/**
*  この範囲内の行数を取得します。
*/
@property (readonly) int rowSpan;

/**
*  この範囲内の列数を取得します。
*/
@property (readonly) int columnSpan;

/**
*  この範囲内の上端の行のインデックスを取得します。
*/
@property (readonly) int topRow;

/**
*  この範囲内の下端の行のインデックスを取得します。
*/
@property (readonly) int bottomRow;

/**
*  この範囲内の左端の列のインデックスを取得します。
*/
@property (readonly) int leftCol;

/**
*  この範囲内の右端の列のインデックスを取得します。
*/
@property (readonly) int rightCol;

/**
*  この範囲に有効な行インデックスと列インデックス（> -1）が含まれるかどうかをチェックします。
*/
@property (readonly) BOOL isValid;

/**
*  この範囲が単一のセルかどうかをチェックします（row == row2 && col == col2）。
*/
@property (readonly) BOOL isSingleCell;

/**
*  レンダリングサイズを取得します。
*    @param panel グリッドパネル
*    @return レンダリングサイズ
*/
- (CGSize)getRenderSize:(GridPanel *)panel;

/**
*  指定された行が含まれているかどうかを判定します。
*    @param r 行
*    @return boolean 値
*/
- (BOOL)containsRow:(int)r;

/**
*  指定された列が含まれているかどうかを判定します。
*    @param c 列
*    @return boolean 値
*/
- (BOOL)containsColumn:(int)c;

/**
*  指定された FlexCellRange オブジェクトが含まれるかどうかを判定します。
*    @param other FlexCellRange オブジェクト
*    @return boolean 値
*/
- (BOOL)contains:(GridCellRange *)other;

@end
