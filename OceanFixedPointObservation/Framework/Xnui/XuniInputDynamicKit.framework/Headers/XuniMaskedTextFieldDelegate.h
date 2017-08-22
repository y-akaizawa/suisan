//
//  XuniMaskedTextFieldDelegate.h
//  XuniInput
//
//  Created by administrator on 16/7/12.
//  Copyright © 2016年 ComponentOne. All rights reserved.
//

#ifndef XuniMaskedTextFieldDelegate_h
#define XuniMaskedTextFieldDelegate_h

/**
*/
@class XuniMaskedTextField;


/**
*  XuniMaskedTextFieldDelegate プロトコル
*/
@protocol XuniMaskedTextFieldDelegate <NSObject>
/**
*/
@optional

/**
*  コントロールのレンダリングが終了したときに呼び出されます。
*    @param sender レンダリングされたコントロール
*/
- (void)rendered:(XuniMaskedTextField*)sender;

/**
*  テキスト値が変更されたときに発生します。
*    @param sender  送信元の XuniMaskedTextField オブジェクト
*    @param oldText 古いテキスト値
*    @param newText 新しいテキスト値
*/
- (void)textChanged:(XuniMaskedTextField *)sender oldText:(NSString *)oldText newText:(NSString *)newText;

@end

#endif /* XuniMaskedTextFieldDelegate_h */
