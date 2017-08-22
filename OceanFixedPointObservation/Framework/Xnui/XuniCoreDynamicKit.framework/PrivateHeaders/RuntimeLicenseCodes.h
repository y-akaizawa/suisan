//
//  RuntimeLicenseCodes.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
*  RuntimeLicenseCodes クラス
*/
@interface RuntimeLicenseCodes : NSObject

/**
*  ライセンスコードの文字列を取得します。
*    @return ライセンスコードの文字列
*/
+ (NSString *)getCodes;

/**
*  ライセンスコードの文字列を取得します。
*    @param isXamarinLicense Xamarin用ライセンスかどうか
*    @return ライセンスコードの文字列
*/
+ (NSString *)getCodes:(BOOL)isXamarinLicense;

@end
