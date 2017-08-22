//
//  GridColumnCollection.h
//  FlexGrid
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "GridRowColCollection.h"

/**
*/
@class GridColumn;

/**
*  GridColumnCollection クラス
*/
@interface GridColumnCollection : GridRowColCollection<GridColumn*>
/**
*  データ接続している列のGridColumn オブジェクトを取得します。
*    @param key     データ接続
*    @return GridColumn オブジェクト
*/
- (GridColumn*)objectForKeyedSubscript:(NSString*)key;
@end
