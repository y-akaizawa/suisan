//
//  RuntimeLicenseMessages.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
*  RuntimeLicenseMessages クラス
*/
@interface RuntimeLicenseMessages : NSObject

/**
*  ライセンスメッセージの配列を取得します。
*    @return ライセンスメッセージの配列
*/
+ (NSArray *)getMessages;
@end
