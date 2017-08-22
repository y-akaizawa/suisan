//
//  GridGroupRow.h
//  FlexGrid
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "GridRow.h"
#import "GridCellRange.h"

/**
*  GridGroupRow クラス
*/
@interface GridGroupRow : GridRow

/**
*  この GroupRow に関連付けられたグループの階層レベルを取得または設定します。
*/
@property (nonatomic) NSUInteger level;

/**
*  このグループ行が子行を持つかどうかを示す値を取得します。
*/
@property (readonly) BOOL hasChildren;

/**
*  このグループ行が折りたたまれるか（子の行が非表示になる）、展開されるか（子の行が表示される）を指定する値を取得または設定します。
*/
@property (nonatomic) BOOL isCollapsed;

/**
*  この GroupRow によって表されるグループ内のすべての行と、グリッド内のすべての列を含む GridCellRange オブジェクトを取得します。
*/
@property (readonly) GridCellRange *cellRange;

/**
*  このグループ行のレンダリングサイズを取得します。
*/
@property (readonly) int renderSize;

/**
*  GridGroupRow オブジェクトを初期化します。
*    @return GridGroupRow オブジェクト
*/
- (id)init;

@end
