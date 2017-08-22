//
//  DropDownDelegate.h
//  DropDown
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef DropDownDelegate_h
#define DropDownDelegate_h

/**
*/
@class XuniDropDown;
/**
*/
@class XuniDropDownOpenChangedEventArgs;
/**
*/
@class XuniDropDownOpenChangingEventArgs;

/**
*  XuniDropDownDelegate プロトコル
*/
@protocol XuniDropDownDelegate <NSObject>
/**
*/
@optional

/**
*  isDropDownOpen プロパティが変更されるときに発生します。
*    @param sender isDropDownOpen プロパティが変更されるドロップダウン
*    @param args   イベント引数
*/
- (void)isDropDownOpenChanging:(XuniDropDown *)sender args:(XuniDropDownOpenChangingEventArgs *)args;

/**
*  isDropDownOpen プロパティが変更されたときに発生します。
*    @param sender isDropDownOpen プロパティが変更されたドロップダウン
*    @param args   イベント引数
*/
- (void)isDropDownOpenChanged:(XuniDropDown *)sender args:(XuniDropDownOpenChangedEventArgs *)args;

/**
*  コントロールのレンダリングが終了したときに呼び出されます。
*    @param sender レンダリングされたコントロール
*/
- (void)rendered:(XuniDropDown*)sender;

@end


#endif /* DropDownDelegate_h */
