//
//  XuniCheckbox.h
//  XuniCore
//
//  Copyright © 2016 C1Marketing. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
*  XuniCheckBox コントロールは iOS の標準チェックボックス機能を提供します。
*/
IB_DESIGNABLE
/**
*/
@interface XuniCheckBox : UIButton <UIGestureRecognizerDelegate>

/**
*  チェックボックスの状態を取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL isChecked;

/**
*  読み取り専用の状態を設定し、操作を有効または無効にします。
*/
@property IBInspectable BOOL isReadOnly;

/**
*  チェックボックスのサイズを取得または設定します。
*/
@property (nonatomic) IBInspectable int intrinsicSize;

@end
