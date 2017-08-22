//
//  GridRowCollection.h
//  FlexGrid
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "GridRowColCollection.h"

/**
*/
@class FlexGrid;
/**
*/
@class GridRow;

/**
*  GridRowCollection クラス
*/
@interface GridRowCollection : GridRowColCollection<GridRow*>

/**
*  GridRowCollection オブジェクトを初期化します。
*    @param grid グリッド
*    @param size サイズ
*    @return GridRowCollection オブジェクト
*/
- (id)initWithGrid:(FlexGrid *)grid defaultSize:(int)size;

/**
*  このコレクション内のグループ行のデフォルトサイズを取得または設定します。
*/
@property (nonatomic) int defaultGroupSize;

@end
