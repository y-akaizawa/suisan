//
//  BaseDataLabel.h
//  XuniChartCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef XuniChartCoreKit_h
#import "FlexChartBase.h"
#endif

/**
*  データラベルの基本クラスです。
*/
@interface XuniBaseDataLabel : NSObject
{
/**
*/
    FlexChartBase* _chart;
}

/**
*  データラベルのコンテンツを取得または設定します。
*/
@property(nonatomic) NSString* content;

/**
*  データラベルの背景色を取得または設定します。
*/
@property(nonatomic) UIColor* dataLabelBackgroundColor;

/**
*  データラベルの境界線の色を取得または設定します。
*/
@property(nonatomic) UIColor* dataLabelBorderColor;

/**
*  データラベルの境界線の幅を取得または設定します。
*/
@property(nonatomic) double dataLabelBorderWidth;

/**
*  データラベルのフォントを取得または設定します。
*/
@property(nonatomic) UIFont* dataLabelFont;

/**
*  データラベルのフォント色を取得または設定します。
*/
@property(nonatomic) UIColor* dataLabelFontColor;

/**
*  データラベルの数値書式文字列を取得または設定します。
*/
@property(nonatomic) NSString* dataLabelFormat;

@end

