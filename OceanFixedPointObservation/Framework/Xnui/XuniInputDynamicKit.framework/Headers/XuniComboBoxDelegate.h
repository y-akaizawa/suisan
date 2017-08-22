//
//  XuniComboBoxDelegate.h
//  XuniInput
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XuniComboBoxDelegate_h
#define XuniComboBoxDelegate_h

/**
*/
@class XuniComboBox;
/**
*/
@class XuniDropDownItemLoadingEventArgs;
/**
*/
@protocol XuniDropDownDelegate;

/**
*  XuniComboBoxDelegate プロトコル
*/
@protocol XuniComboBoxDelegate <XuniDropDownDelegate>
/**
*/
@optional

/**
*  選択されたインデックス（selectedIndex）の値が変化したときに発生します。
*    @param sender 送信元のXuniComboBox オブジェクト
*/
- (void)selectedIndexChanged:(XuniComboBox *)sender;

/**
*  テキスト値が変更されたときに発生します。
*    @param sender 送信元のXuniComboBox オブジェクト
*/
- (void)textChanged:(XuniComboBox *)sender;

/**
*  ドロップダウン項目がロードされるときに発生します。
*    @param sender 送信元のXuniComboBox オブジェクト
*    @param args   イベント引数
*    @return ドロップダウン項目内に表示されるカスタマイズされたビューを返します。
*/
- (UIView *)dropDownItemLoading:(XuniComboBox *)sender args:(XuniDropDownItemLoadingEventArgs *)args;

@end

#endif /* XuniComboBoxDelegate_h */
