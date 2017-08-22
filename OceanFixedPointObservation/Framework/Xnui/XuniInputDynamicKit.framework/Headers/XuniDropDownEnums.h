//
//  XuniDropDownEnums.h
//  DropDown
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef XuniDropDownEnums_h
#define XuniDropDownEnums_h

/**
*/
@class XuniDropDown;

/**
*  ドロップダウンの表示方向を指定します。
*/
typedef NS_ENUM(NSInteger, XuniDropDownDirection) {
/**
*  ドロップダウンをヘッダーの上に表示するように試みます。表示できない場合は、下に表示するように試みます。
*/
    XuniDropDownDirectionAboveOrBelow,
/**
*  ドロップダウンをヘッダーの下に表示するように試みます。表示できない場合は、上に表示するように試みます。(デフォルト値)
*/
    XuniDropDownDirectionBelowOrAbove, 
/**
*  ドロップダウンをヘッダーの上に強制的に表示します。
*/
    XuniDropDownDirectionForceAbove,
/**
*  ドロップダウンをヘッダーの下に強制的に表示します。
*/
    XuniDropDownDirectionForceBelow
};

/**
*  ドロップダウンの動作を指定します。
*/
typedef NS_ENUM(NSInteger, XuniDropDownBehavior) {
/**
*  ユーザーがボタンをタップするとドロップダウンが表示されます。
*/
    XuniDropDownBehaviorButtonTap,
/**
*  ユーザーがヘッダーの任意の部分をタップするとドロップダウンが表示されます。
*/
    XuniDropDownBehaviorHeaderTap
};

#endif /* XuniDropDownEnums_h */
