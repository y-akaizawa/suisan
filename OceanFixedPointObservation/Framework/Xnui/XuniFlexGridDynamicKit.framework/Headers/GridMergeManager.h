//
//  GridMergeManager.h
//  FlexGrid
//
//  Copyright © 2016 C1Marketing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlexGrid.h"


/**
*  GridMergeManager クラス
*/
@interface GridMergeManager : NSObject
/**
*  GridMergeManager に関連付けられた FlexGrid を取得します。
*/
@property (readonly) FlexGrid *grid;

/**
*  GridMergeManager オブジェクトを初期化します。
*    @param grid   指定された FlexGrid
*    @return GridMergeManager オブジェクト
*/
- (id)initWithGrid:(FlexGrid *)grid;

- (GridCellRange *)getMergedRangeForCells:(GridCellRange *)range ofType:(GridCellType)type;

@end
