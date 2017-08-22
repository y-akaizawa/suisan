//
//  Range.h
//  FlexGauge
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
*/
@class XuniGauge;

/**
*  XuniGaugeRange オブジェクト
*/
@interface XuniGaugeRange : NSObject

/**
*  範囲の背景色を取得または設定します。
*/
@property (nonatomic) UIColor* color;

/**
*  範囲の太さを取得または設定します。
*/
@property (nonatomic) double thickness;

/**
*  範囲の境界線の色を取得または設定します。
*/
@property (nonatomic) UIColor* borderColor;

/**
*  範囲の境界線の幅を取得または設定します。
*/
@property (nonatomic) double borderWidth;

@property (nonatomic) NSArray<NSNumber*>* borderDashes;

/**
*  この範囲の最小値を取得または設定します。
*/
@property (nonatomic) double min;

/**
*  この範囲の最大値を取得または設定します。
*/
@property (nonatomic) double max;

/**
*  範囲の名前値を取得または設定します。
*/
@property (nonatomic) NSString *name;

/**
*  XuniGaugeRange のインスタンスを初期化します。
*    @param gauge XuniGauge オブジェクト
*    @return XuniGaugeRange のインスタンス
*/
- (id)initWithGauge:(XuniGauge*)gauge;

@end
