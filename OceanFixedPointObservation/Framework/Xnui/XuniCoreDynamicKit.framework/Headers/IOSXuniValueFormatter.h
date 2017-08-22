//
//  IOSXuniValueFormatter.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "IXuniValueFormatter.h"

/**
*  iOS ネイティブフォーマッタインタフェース
*/
@interface XuniIOSValueFormatter : NSObject<IXuniValueFormatter>

/**
*  iOS ネイティブフォーマッタのインスタンスを初期化します。
*    @param locale ロケール文字列
*    @return iOS ネイティブフォーマッタのインスタンス
*/
- (id)initWithLocale:(NSString *)locale;

@end
