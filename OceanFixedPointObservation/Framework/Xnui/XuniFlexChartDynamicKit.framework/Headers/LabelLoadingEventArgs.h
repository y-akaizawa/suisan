//
//  LabelLoadingEventArgs.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XuniCoreKit_h
#import "XuniCore/Event.h"
#endif

/**
*/
@protocol IXuniRenderEngine;

/**
*  LabelLoading イベントの引数
*/
@interface XuniLabelLoadingEventArgs : XuniEventArgs

/**
*  レンダリングエンジンを取得または設定します。
*/
@property (nonatomic) NSObject<IXuniRenderEngine> *renderEngine;

/**
*  オリジナルのラベルの値を取得または設定します。
*/
@property (nonatomic) double value;

/**
*  ラベルの文字列を取得または設定します。
*/
@property (nonatomic) NSString *label;

/**
*  ラベルの領域を取得または設定します。
*/
@property (nonatomic) XuniRect *region;

/**
*  XuniLabelLoadingEventArgs のインスタンスを初期化します。
*    @param renderEngine レンダリングエンジン
*    @param value        オリジナルのラベルの値
*    @param label        ラベルの文字列
*    @param region       ラベルの領域
*    @return XuniLabelLoadingEventArgs インスタンス
*/
- (id)initWithEngine:(NSObject<IXuniRenderEngine> *)renderEngine value:(double)value label:(NSString *)label region:(XuniRect *)region;

@end
