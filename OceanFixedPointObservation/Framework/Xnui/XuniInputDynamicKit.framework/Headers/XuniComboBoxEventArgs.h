//
//  XuniComboBoxEventArgs.h
//  XuniInput
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XUNI_INTERNAL_DYNAMIC_BUILD

#ifndef XuniCoreKit_h

#import "XuniCore/Event.h"

#endif

#else
#import "XuniCoreDynamicKit/XuniCoreDynamicKit.h"
#endif

/**
*  XuniDropDownItemLoadingEventArgs クラス
*    dropDownItemLoading イベントの引数
*/
@interface XuniDropDownItemLoadingEventArgs : XuniEventArgs

/**
*  ドロップダウン項目データを取得します。
*/
@property (readonly) NSObject *itemData;

/**
*  ドロップダウン項目四角形を取得します。
*/
@property (readonly) CGRect itemRect;

/**
*  新しく割り当てられた XuniDropDownItemLoadingEventArgs オブジェクトを初期化して返します。
*    @param itemData  ドロップダウン項目データ
*    @param itemRect  ドロップダウン項目四角形領域
*    @return 初期化された XuniDropDownItemLoadingEventArgs オブジェクト。オブジェクトを作成できなかった場合は nil。
*/
- (instancetype)initWithData:(NSObject *)itemData itemRect:(CGRect)itemRect;

@end
