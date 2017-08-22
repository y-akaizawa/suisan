
//
//  RuntimeLicenseHandler.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RuntimeLicenseMessages.h"
#import "RuntimeLicenseCodes.h"

/**
*  LicenseChecker クラス
*/
@interface LicenseChecker : NSObject

/**
*  ライセンス文字列を指定してライセンスの有無を検証します。
*    @param LicenseString ライセンス文字列 
*    @return 検証結果
*/
+ (int)VerifyLicense:(NSString *)LicenseString;

/**
*  残りの日数を取得します。
*    @return 残りの日数
*/
+ (int)GetDaysRemaining;

/**
*  previousCheck の boolean 値を取得します。
*    @return previousCheck の boolean 値。
*/
+ (Boolean)PreviousLicenseCheck;

/**
*  ステータスメッセージを取得します。
*    @return ステータスメッセージ
*/
+ (NSString *)GetStatusMessage;

/**
*  リセットします。
*/
+ (void)Reset;

@end

/**
*  CertParser クラス
*/
@interface CertParser : NSObject

/**
*  証明書パーサー（ CertParser ）オブジェクトを初期化します。
*    @param certRef 指定された certRef
*    @return CertParser オブジェクト
*/
- (id)init:(SecCertificateRef)certRef;

/**
*  boolean 型の結果を取得します。
*    @return boolean 型
*/
- (Boolean)Evaluate;

/**
*  シリアル番号の文字列を取得します。
*    @return シリアル番号の文字列
*/
- (NSString *)SerialNumberString;

/**
*  発行者名を取得します。
*    @return 発行者名
*/
- (NSString *)IssuerName;

/**
*  対象名を取得します。
*    @return 対象名
*/
- (NSString *)SubjectName;

/**
*  フィンガープリントの文字列を取得します。
*    @return フィンガープリントの文字列
*/
- (NSString *)Thumbprint;

- (NSDate *)NotBefore;

/**
*  文字列 notAfter を指定して NSDate 値を取得します。
*    @return NSDate 値
*/
- (NSDate *)NotAfter;

@end

/**
*  RuntimeLicenseHandler クラス
*/
@interface RuntimeLicenseHandler : NSObject

/**
*  残りの日数を取得または設定します。
*/
@property(readonly) int daysRemaining;

/**
*  RuntimeLicenseHandler オブジェクトを初期化します。
*    @return RuntimeLicenseHandler オブジェクト
*/
- (id)init;

/**
*  ランタイムライセンスを検証します。
*    @param appName       アプリ名
*    @param licenseData   ライセンスデータ
*    @param validCodes    validCodes
*    @param versionString バージョン文字列
*    @return チェックの結果
*/
- (int)VerifyRuntimeLicense:(NSString *)appName base64LicenseData:(NSString *)licenseData validCodes:(NSString *)validCodes versionString:(NSString *)versionString;

@end
