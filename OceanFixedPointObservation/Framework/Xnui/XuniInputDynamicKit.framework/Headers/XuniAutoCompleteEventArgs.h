//
//  XuniAutoCompleteEventArgs.h
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
*  XuniAutoCompleteFilteringEventArgs クラス。
*    フィルタ処理イベントの引数
*/
@interface XuniAutoCompleteFilteringEventArgs : XuniEventArgs

/**
*  フィルタ処理をキャンセルするかどうかを取得または設定します。
*/
@property (nonatomic) BOOL cancel;

/**
*  オートコンプリート項目ソースを取得します。
*/
@property (nonatomic) NSMutableArray *itemSource;

/**
*  新しく割り当てられた XuniAutoCompleteFilteringEventArgs オブジェクトを初期化して返します。
*    @param itemSource  オートコンプリート項目ソース
*    @param handled  フィルタ処理をキャンセルするかどうか
*    @return 初期化された XuniAutoCompleteFilteringEventArgs オブジェクト。オブジェクトを作成できなかった場合は nil。
*/
- (instancetype)initWithItemSource:(NSMutableArray *)itemSource cancel:(BOOL)cancel;

@end
