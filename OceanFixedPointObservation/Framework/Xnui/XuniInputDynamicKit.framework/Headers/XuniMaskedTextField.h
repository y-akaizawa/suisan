//
//  XuniMaskedTextField.h
//  XuniInput
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "XuniMaskedTextFieldDelegate.h"

/**
*/
@class XuniEvent;

/**
*/
IB_DESIGNABLE
/**
*/
@interface XuniMaskedTextField : UITextField

/**
*  通知を処理するためのデリゲートを取得または設定します。
*/
@property (nonatomic, weak) id<XuniMaskedTextFieldDelegate> maskDelegate;

/**
*  ユーザーのキー入力に伴って入力を検証するために使用されるマスクを取得または設定します。
*    マスクは、1 つ以上のマスク要素から成る文字列でなければなりません。
*/
@property (nonatomic) IBInspectable NSString *mask;

/**
*  マスクが完全に満足されているかどうかを示す boolean 値を取得します。
*/
@property (nonatomic, readonly) IBInspectable BOOL maskFull;

/**
*  コントロール内の入力位置を示すために使用される記号を取得または設定します。
*/
@property (nonatomic) IBInspectable NSString *promptChar;

/**
*  コントロールの未加工の値を取得または設定します（プロンプトとマスクリテラルを除く）。
*/
@property (nonatomic) IBInspectable NSString *value;

/**
*  コントロールのパディングを取得または設定します。
*/
@property (nonatomic) UIEdgeInsets padding;

/**
*  テキスト値が変更されたときに発生します。
*/
@property XuniEvent *textChanged;

/**
*  フォントのディスクリプタを取得します。
*    @param attributes フォント属性
*    @return フォントのディスクリプタ
*/
- (UIFontDescriptor *)getDecriptor:(NSMutableDictionary *)attributes;

@end
