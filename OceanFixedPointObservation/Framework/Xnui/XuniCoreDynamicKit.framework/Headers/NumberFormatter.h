//
//  NumberFormatter.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
*  XuniNumberFormatter オブジェクト
*/
@interface XuniNumberFormatter : NSObject

/**
*  パターンを指定して、書式設定された数値を取得します。
*    @param number  数値
*    @param pattern パターン
*    @return 書式設定された数値の文字列
*/
+ (NSString *)numberToStringWithParameters:(NSNumber *)number andPattern:(NSString *)pattern;

/**
*  パターンと言語ロケールを指定して、書式設定された数値を取得します。
*    @param number  数値
*    @param pattern パターン
*    @param locale  言語ロケール
*    @return 書式設定された数値の文字列
*/
+ (NSString *)numberToStringWithParameters:(NSNumber *)number andPattern:(NSString *)pattern andLanguageLocale:(NSString *)locale;

@end
