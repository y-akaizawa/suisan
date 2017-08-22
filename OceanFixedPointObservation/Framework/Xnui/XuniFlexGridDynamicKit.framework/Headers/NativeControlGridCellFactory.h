//
//  NativeControlCellFactory.h
//  FlexGrid
//
//  Copyright © 2016 C1Marketing. All rights reserved.
//

#import "GridCellFactory.h"
#import "GridEventArgs.h"

/**
*  セルを生成するための NativeControlGridCellFactoryを操作する デリゲートクラスです。
*/
@protocol NativeControlGridCellFactoryDelegate<NSObject>
/**
*/
@optional
/**
*  セルとして表示するViewが生成されたときに発生します。
*    @param sender 送信元の FlexGrid 
*    @param panel イベントが発生した GridPanel 
*    @param range セルの範囲
*    @return ネイティブにセルを表示するUIView
*/
- (UIView*)createViewForCell:(FlexGrid *)sender panel:(GridPanel *)panel forRange:(GridCellRange *)range;

@end

/**
*  GridFormatItemEventArgs クラス
*/
@interface GridCreateViewForCellEventArgs : GridCellRangeEventArgs

/**
*  GridFormatItemEventArgs オブジェクトを初期化します。
*    @param panel   パネル
*    @param range   範囲
*    @return GridFormatItemEventArgs オブジェクト
*/
- (id)initWithPanel:(GridPanel *)panel forRange:(GridCellRange *)range;

/**
*  グリッドのセルとして表示されるViewを取得または設定します。
*/
@property UIView *view;


@end

/**
*  NativeControlGridCellFactory クラス
*/
@interface NativeControlGridCellFactory : GridCellFactory
/**
*  セルファクトリーを所有する FlexGrid を取得します。
*/
@property (readonly) FlexGrid* grid;

/**
*  セルファクトリーに関連付けられた NativeControlGridCellFactoryDelegate を取得または設定します。
*/
@property id<NativeControlGridCellFactoryDelegate> delegate;

/**
*  ネイティブのセルビューが生成されたときに発生します。
*/
@property XuniEvent<GridCreateViewForCellEventArgs*> *createViewForCell;

/**
*  NativeControlGridCellFactory オブジェクトを紹介します。
*    @param grid     セルファクトリーを所有しているFlexGrid
*    @return NativeControlGridCellFactory オブジェクト
*/
-(instancetype)initWithGrid:(FlexGrid*)grid;
@end
