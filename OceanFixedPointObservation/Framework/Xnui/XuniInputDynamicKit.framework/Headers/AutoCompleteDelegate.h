//
//  AutoCompleteDelegate.h
//  XuniInput
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef AutoCompleteDelegate_h
#define AutoCompleteDelegate_h
#import "XuniComboBoxDelegate.h"

/**
*/
@class XuniAutoComplete;
/**
*/
@class XuniAutoCompleteFilteringEventArgs;
//@protocol XuniComboBoxDelegate;

/**
*  XuniAutoCompleteDelegate プロトコル
*/
@protocol XuniAutoCompleteDelegate <XuniComboBoxDelegate>
/**
*/
@optional

//- (void)selectedIndexChanged:(XuniAutoComplete *)sender;

//- (void)textChanged:(XuniAutoComplete *)sender;

/**
*  suggestionList のセルをカスタマイズします。
*    @param cell カスタマイズしたビューの追加に使用されるセル
*/
- (void)customizeTheCellsOfSuggestionList:(UITableViewCell *)cell;

/**
*  コントロールが項目のリストにフィルタを適用するときに発生します。
*    @param sender XuniAutoComplete
*    @param text   テキスト
*/
- (void)filtering:(XuniAutoComplete *)sender eventArgs:(XuniAutoCompleteFilteringEventArgs*)eventArgs;

/**
*  インデックスを指定して Xamarin カスタムビューを取得します。
*    @param index 項目のインデックス
*/
-(UIView *)getXamarinCustomView:(XuniAutoComplete *)sender WithIndex:(int)index;

@end

#endif /* AutoCompleteDelegate_h */
