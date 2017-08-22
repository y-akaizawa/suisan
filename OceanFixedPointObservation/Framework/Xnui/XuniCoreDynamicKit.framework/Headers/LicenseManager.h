//
//  LicenseManager.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
*  XuniLicenseManager クラス
*/
@interface XuniLicenseManager : NSObject

/**
*  キー文字列を取得します。
*    @return キー文字列
*/
+ (NSString *)getKey;

/**
*  キー文字列を設定します。
*    @param key キー文字列
*/
+ (void)setKey:(NSString *)key;

/**
*  ライセンスをチェックします。
*/
+ (void)checkLicense;

/**
*  例外を生成するときにダイアログを表示します。
*    @param withMessage    メッセージ
*    @param throwException 例外を生成するかどうか
*/
+ (void)showDialog:(NSString *)withMessage throwException:(Boolean)throwException;
@end
