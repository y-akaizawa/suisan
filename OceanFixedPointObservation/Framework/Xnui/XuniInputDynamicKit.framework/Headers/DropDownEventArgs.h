//
//  DropDownEventArgs.h
//  DropDown
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XUNI_INTERNAL_DYNAMIC_BUILD

#ifndef XuniCoreKit_h
#import "XuniCore/Event.h"
#endif

#else

#import <XuniCoreDynamicKit/XuniCoreDynamicKit.h>

#endif

/**
*/
@class XuniDropDownHeaderView;
/**
*/
@class XuniDropDown;
/**
*/
@class XuniDropDownView;

/**
*  XuniDropDownOpenChangingEventArgs クラス
*    DropDownOpenChanging イベントの引数
*/
@interface XuniDropDownOpenChangingEventArgs : XuniEventArgs

/**
*  ドロップダウンを取得または設定します。
*/
@property(nonatomic) XuniDropDown *dropDown;

/**
*  新しく割り当てられた XuniDropDownOpenChangedEventArgs オブジェクトを初期化して返します。
*    @param dropDown  dropDown コントロール
*    @return 初期化された XuniDropDownOpenChangedEventArgs オブジェクト。オブジェクトを作成できなかった場合は nil。
*/
- (instancetype)initWithDropDown:(XuniDropDown *)dropDown;

@end

/**
*  XuniDropDownOpenChangedEventArgs クラス
*    DropDownOpenChanged イベントの引数
*/
@interface XuniDropDownOpenChangedEventArgs : XuniEventArgs

/**
*  ドロップダウンを取得または設定します。
*/
@property(nonatomic) XuniDropDown *dropDown;

/**
*  新しく割り当てられた XuniDropDownOpenChangedEventArgs オブジェクトを初期化して返します。
*    @param dropDown  dropDown コントロール
*    @return 初期化された XuniDropDownOpenChangedEventArgs オブジェクト。オブジェクトを作成できなかった場合は nil。
*/
- (instancetype)initWithDropDown:(XuniDropDown *)dropDown;

@end
