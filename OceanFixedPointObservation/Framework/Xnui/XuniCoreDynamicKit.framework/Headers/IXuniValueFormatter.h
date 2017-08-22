//
//  IXuniValueFormatter.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "Util.h"

/**
*  IXuniValueFormatter プロトコル
*/
@protocol IXuniValueFormatter

/**
*  書式文字列を使用して値を書式設定します。
*    @param value 書式設定する値
*    @param format 書式文字列
*    @return 書式設定された文字列
*/
- (NSString *)format:(NSObject *)value format:(NSString *)format;


/**
*  書式文字列を使用して値を書式設定します。
*    @param value 書式設定する値
*    @param format 書式文字列
*    @param dataType 値のデータ型
*    @return 書式設定された文字列
*/
- (NSString *)format:(NSObject *)value format:(NSString *)format dataType:(XuniDataType)dataType;

@optional
- (NSString *)format:(NSObject *)value format:(NSString *)format dataType:(XuniDataType)dataType isJaCalendar:(BOOL)isJaCalendar;
@end
