//
//  GridRowColCollection.h
//  FlexGrid
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XUNI_INTERNAL_DYNAMIC_BUILD

#ifndef XuniCoreKit_h
#import "XuniCore/ObservableArray.h"
#endif

#else

#import <XuniCoreDynamicKit/XuniCoreDynamicKit.h>

#endif

/**
*/
@class FlexGrid;
/**
*/
@class GridPanel;
/**
*/
@class GridRowCol;

/**
*  GridRowColCollection クラス
*/
@interface GridRowColCollection<__covariant ObjectType> : XuniObservableArray<ObjectType>

/**
*  GridRowColCollection オブジェクトを初期化します。
*    @param grid FlexGrid オブジェクト
*    @param size サイズ
*    @return GridRowColCollection オブジェクト
*/
- (id)initWithGrid:(FlexGrid *)grid defaultSize:(int)size;


/**
*  このコレクション内の要素のデフォルトサイズを取得または設定します。
*/
@property (nonatomic) int defaultSize;

/**
*  このコレクション内の固定行または固定列の数を取得します。
*/
@property (nonatomic) int frozen;

/**
*  このコレクション内の要素の最小サイズを取得または設定します。
*/
@property (nonatomic) int minSize;

/**
*  このコレクション内の要素の最大サイズを取得または設定します。
*/
@property (nonatomic) int maxSize;

/**
*  このコレクション内の要素の合計サイズを取得します。
*/
@property (readonly) int totalSize;

/**
*  このコレクションを所有する FlexGrid を取得します。
*/
@property (readonly) FlexGrid *grid;

/**
*  このコレクションを所有する GridPanel を取得します。
*/
@property (readonly) GridPanel *gridPanel;


/**
*  指定された位置のインデックスを取得します。
*    @param position 位置
*    @return インデックス
*/
- (int)getIndexAt:(int)position;

/**
*  項目を追加します。
*    @param item 項目
*/
- (void)push:(id)item;



@end
