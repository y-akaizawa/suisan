//
//  DropDownView.h
//  DropDown
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "XuniDropDownEnums.h"

/**
*/
@interface XuniDropDownView : UIView

/**
*  ドロップダウンを取得または設定します。
*/
@property (nonatomic) XuniDropDown *xuniDropDown;

/**
*  ドロップダウンボックスの幅を取得または設定します。
*/
@property(nonatomic) double width;

/**
*  ユーザーがドロップダウンの外部をタップしたときにドロップダウンを自動的に閉じるかどうかを取得または設定します。
*/
@property(nonatomic) BOOL autoClose;

/**
*  ドロップダウンが現在表示されているかどうかを示す値を取得または設定します。
*/
@property(nonatomic) BOOL isDropDownOpen;

/**
*  コントロールのドロップダウンボックスの展開方向を取得または設定します。
*/
@property(nonatomic) XuniDropDownDirection dropDownDirection;

/**
*  ドロップダウンボックスの最大長の制約を取得または設定します。
*/
@property(nonatomic) double maxHeight;

/**
*  ドロップダウンボックスの最小高さの制約を取得または設定します。
*/
@property(nonatomic) double minHeight;

/**
*  ドロップダウンボックスの最大幅の制約を取得または設定します。
*/
@property(nonatomic) double maxWidth;

/**
*  ドロップダウンボックスの最小幅の制約を取得または設定します。
*/
@property(nonatomic) double minWidth;

/**
*  ドロップダウンビューの高さを設定します。
*    @param height ドロップダウンの高さ。
*/
- (void)setDropDownHeight:(double)height;

/**
*  ドロップダウンビューの幅を設定します。
*    @param height ドロップダウンの幅
*/
- (void)setDropDownWidth:(double)width;

/**
*  ドロップダウンビューをリフレッシュします。
*/
- (void)refresh;

@end
