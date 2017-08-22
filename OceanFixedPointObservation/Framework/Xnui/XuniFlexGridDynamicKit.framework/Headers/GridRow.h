//
//  GridRow.h
//  FlexGrid
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "GridRowCol.h"

/**
*  GridRow
*/
@interface GridRow : GridRowCol


/**
*  この項目の連結先のデータコレクション内の項目を取得または設定します。
*/
@property (nonatomic) NSObject *dataItem;

/**
*  この行の高さを取得または設定します。
*/
@property (nonatomic) int height;

/**
*  この行の高さの最小値を取得または設定します。
*/
@property (nonatomic) int minHeight;

/**
*  この行の高さの最大値を取得または設定します。
*/
@property (nonatomic) int maxHeight;

/**
*  この行のレンダリング高さを取得します。
*/
@property (readonly) int renderHeight;

/**
*  GridRow オブジェクトを初期化します。
*    @return GridRow オブジェクト
*/
- (id)init;

/**
*  項目を指定して GridRow オブジェクトを初期化します。
*    @param dataItem 項目
*    @return GridRow オブジェクト
*/
- (id)initWithData:(NSObject *)dataItem;

@end
