//
//  GridEventArgs.h
//  FlexGrid
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef XUNI_INTERNAL_DYNAMIC_BUILD

#ifndef XuniCoreKit_h
#import "XuniCore/Event.h"
#endif

#else

#import <XuniCoreDynamicKit/XuniCoreDynamicKit.h>

#endif

#import "GridCellRange.h"
#import "GridRow.h"
#import "GridColumn.h"

/**
*  GridCellRangeEventArgs クラス
*/
@interface GridCellRangeEventArgs : XuniCancelEventArgs

/**
*  FlexCellRangeEventArgs オブジェクトを初期化します。
*  @param panel パネル
*  @param range 範囲
*  @return FlexCellRangeEventArgs オブジェクト
*/
- (id)initWithPanel:(GridPanel *)panel forRange:(GridCellRange *)range;

/**
*  このイベントによって影響を受けた行のインデックスを取得します。
*/
@property (readonly) int row;

/**
*  このイベントの発生対象となった列のインデックスを取得します。
*/
@property (readonly) int col;

/**
*  このイベントの発生対象となったグリッドパネルを取得します。
*/
@property (readonly) GridPanel *panel;

/**
*  このイベントの発生対象となったセル範囲を取得します。
*/
@property (readonly) GridCellRange *cellRange;

@end

/**
*  GridFormatItemEventArgs クラス
*/
@interface GridFormatItemEventArgs : GridCellRangeEventArgs

/**
*  FlexFormatItemEventArgs オブジェクトを初期化します。
*  @param panel パネル
*  @param range 範囲
*  @param context コンテキスト
*  @return FlexFormatItemEventArgs オブジェクト
*/
- (id)initWithPanel:(GridPanel *)panel forRange:(GridCellRange *)range inContext:(CGContextRef)context;

/**
*  描画操作に使用するグラフィックコンテキストを取得します。
*/
@property (readonly) CGContextRef context;

@end

/**
*  GridDetailCellCreatingEventArgs クラス
*/
@interface GridDetailCellCreatingEventArgs : XuniCancelEventArgs

/**
*  グリッドの詳細行になるビューを取得または設定します。
*/
@property UIView *view;


/**
*  生成される FlexRow オブジェクトを取得または設定します。
*/
@property (readonly) GridRow *row;

/**
*  FlexGridDetailCellCreatingEventArgs オブジェクトを初期化します。
*  @param row 詳細行を生成する FlexRow オブジェクト
*  @return FlexGridDetailCellCreatingEventArgs オブジェクト
*/
- (id)initWithRow:(GridRow *)row;
@end

/**
*  GridRowHeaderLoadingEventArgs クラス
*/
@interface GridRowHeaderLoadingEventArgs : XuniCancelEventArgs
/**
*  グリッドの行ヘッダーに表示されるボタンを取得または設定します。
*/
@property UIButton *button;

/**
*  生成される FlexRow オブジェクトを取得または設定します。
*/
@property (readonly) GridRow *row;

/**
*  FlexGridRowHeaderLoadingEventArgs オブジェクトを初期化します。
*  @param row 詳細行を生成する FlexRow オブジェクト
*  @param button 行ヘッダーに生成される初期状態の仮のボタン
*  @return FlexGridRowHeaderLoadingEventArgs オブジェクト
*/
- (id)initWithRow:(GridRow *)row withButton:(UIButton *)button;
@end

/**
*  GridAutoGeneratingColumnEventArgs クラス
*/
@interface GridAutoGeneratingColumnEventArgs : XuniCancelEventArgs
/**
*  G各列が生成されるときの XuniPropertyInfo を取得します。
*/
@property (readonly) XuniPropertyInfo *propertyInfo;

/**
*  生成される FlexColumn オブジェクトを取得または設定します。
*/
@property GridColumn *column;

/**
*  FlexGridAutoGeneratingColumnEventArgs オブジェクトを初期化します。
*  @param column 初期状態で生成される FlexColumn オブジェクト
*  @param propertyInfo 生成される列のプロパティの XuniPropertyInfo オブジェクト
*  @return FlexGridAutoGeneratingColumnEventArgs オブジェクト
*/
- (id)initWithColumn:(GridColumn *)column andPropertyInfo:(XuniPropertyInfo *)propertyInfo;
@end

/**
*  GridResizedColumnEventArgs クラス
*/
@interface GridResizedColumnEventArgs : XuniEventArgs
/**
*  サイズ変更される FlexColum オブジェクトを取得します。
*/
@property (readonly) GridColumn *column;

/**
*  FlexGridResizedColumnEventArgs オブジェクトを初期化します。
*  @param column サイズ変更される FlexColumn オブジェクト
*  @return FlexGridResizedColumnEventArgs オブジェクト
*/
- (id)initWithColumn:(GridColumn *)column;
@end
