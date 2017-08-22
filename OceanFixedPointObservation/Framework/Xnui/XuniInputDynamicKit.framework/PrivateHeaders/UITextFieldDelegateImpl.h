//
//  UITextFieldDelegateImpl.h
//  XuniInput
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
*/
@class XuniMaskHandler;

/**
*/
@interface XuniUITextFieldDelegateImpl : NSObject<UITextFieldDelegate>

/**
*  新しく割り当てられた XuniUITextFieldDelegateImpl オブジェクトを、指定されたマスクハンドラで初期化して返します。
*    @param maskHandler    マスクハンドラ
*    @return 初期化された XuniUITextFieldDelegateImpl オブジェクト。オブジェクトを作成できなかった場合は nil。
*/
- (instancetype)initWithMaskHandler:(XuniMaskHandler *)maskHandler;

@end
