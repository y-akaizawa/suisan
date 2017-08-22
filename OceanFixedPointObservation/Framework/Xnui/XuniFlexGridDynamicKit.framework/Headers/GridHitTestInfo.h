//
//  GridHitTestInfo.h
//  FlexGrid
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridPanel.h"
#import "GridCellRange.h"

/**
*  GridHitTestInfo クラス
*/
@interface GridHitTestInfo : NSObject

/**
*  FlexHitTestInfo オブジェクトを初期化します。
*    @param grid  FlexGrid オブジェクト
*    @param point ポイント
*    @return GridHitTestInfo オブジェクト
*/
- (id)initWithGrid:(FlexGrid *)grid atPoint:(CGPoint)point;

/**
*  GridHitTestInfo オブジェクトを初期化します。
*    @param panel グリッドパネル
*    @param point ポイント
*    @return FlexHitTestInfo オブジェクト
*/
- (id)initWithPanel:(GridPanel *)panel atPoint:(CGPoint)point;

/**
*  このヒットテスト情報（ HitTestInfo ）が参照するコントロール座標内のポイントを取得します。
*/
@property (readonly) CGPoint point;

/**
*  指定された位置にあるセルタイプを取得します。
*/
@property (readonly) GridCellType cellType;

/**
*  指定された位置にあるグリッドパネルを取得します。
*/
@property (readonly) GridPanel *gridPanel;

/**
*  指定された位置にあるセルの行インデックスを取得します。
*/
@property (readonly) int row;

/**
*  指定された位置にあるセルの列インデックスを取得します。
*/
@property (readonly) int column;

/**
*  指定された位置にあるセル範囲を取得します。
*/
@property (readonly) GridCellRange *cellRange;

/**
*  指定された位置がセルの左端に近いかどうかを取得します。
*/
@property (readonly) BOOL edgeLeft;

/**
*  指定された位置がセルの上端に近いかどうかを取得します。
*/
@property (readonly) BOOL edgeTop;

/**
*  指定された位置がセルの右端に近いかどうかを取得します。
*/
@property (readonly) BOOL edgeRight;

/**
*  指定された位置がセルの下端に近いかどうかを取得します。
*/
@property (readonly) BOOL edgeBottom;

@end
