//
//  XuniMaskElement.h
//  XuniInput
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XuniInputEnums.h"

#define MASK_ELEMENT_NONE 0x0


/**
*/
@interface XuniMaskElement : NSObject

/**
*  マスクワイルドカード文字を取得または設定します。
*/
@property (nonatomic) unichar wildcard;

/**
*  大文字／小文字のタイプを取得または設定します。
*/
@property (nonatomic) XuniCharCaseType charCase;

/**
*  マスクリテラル文字を取得または設定します。
*/
@property (nonatomic) unichar literal;

/**
*  マスク文字がオプションかどうかを取得または設定します。
*/
@property (nonatomic) BOOL isOptional;

/**
*  リテラルをコンテンツとして解釈できるかどうかを取得または設定します。
*/
@property (nonatomic) BOOL isVague;

/**
*  新しく割り当てられた XuniMaskElement オブジェクトを、指定されたマスク文字で初期化して返します。
*    @param maskChar   マスク文字
*    @param isWildcard マスク文字がワイルドカードかリテラルか
*    @param isOptional マスク文字がオプションかどうか
*    @param caseType   大文字／小文字のタイプ
*    @return 初期化された XuniMaskedTextField オブジェクト。オブジェクトを作成できなかった場合は nil。
*/
- (instancetype)initWithMask:(unichar)maskChar isWildcard:(BOOL)isWildcard isOptional:(BOOL)isOptional caseType:(XuniCharCaseType)caseType;

@end
