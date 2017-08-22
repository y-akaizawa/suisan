//
//  XuniTooltip.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
*  XuniBaseTooltipView クラス
*/
@interface XuniBaseTooltipView : UIView

/**
*  ツールチップが完全に表示されるまでの時間を取得または設定します。
*/
@property (nonatomic, assign) double appearDuration;

/**
*  ツールチップの表示が始まるまでの遅延を取得または設定します。
*/
@property (nonatomic, assign) double appearDelay;

/**
*  ツールチップが完全に消えるまでの時間を取得または設定します。
*/
@property (nonatomic, assign) double disappearDuration;

/**
*  ツールチップが消え始めるまでの遅延を取得または設定します。
*/
@property (nonatomic, assign) double disappearDelay;

/**
*  ツールチップに影が含まれるかどうかを取得または設定します。
*/
@property (nonatomic, assign) BOOL hasShadow;

/**
*  ツールチップを表示するかどうかを取得または設定します。
*/
@property (nonatomic, assign) BOOL isVisible;

/**
*  ツールチップ上のテキストを取得または設定します。
*/
@property (strong, nonatomic) NSString *text;

/**
*  テキストの色を取得または設定します。
*/
@property (strong, nonatomic) UIColor *textColor;

/**
*  テキストのフォントを取得または設定します。
*/
@property (strong, nonatomic) UIFont *textFont;

/**
*  テキストのフォントサイズを取得または設定します。
*/
@property (nonatomic) double textFontSize;

/**
*  ツールチップの角の丸みを取得または設定します。
*/
@property (nonatomic, assign) int cornerRadius;

/**
*  ツールチップが表示されるポイントを取得または設定します。
*/
@property (nonatomic, assign) CGPoint senderPoint;

/**
*  ツールチップの背景色を取得または設定します。
*/
@property (nonatomic, strong) UIColor *backColor;

/**
*  ツールチップの不透明度を取得または設定します。
*/
@property (nonatomic) double opacity;

/**
*  ツールチップとタッチポイントの間のギャップを取得または設定します。
*/
@property (nonatomic) double gap;

/**
*  ターゲット要素からの最大距離を取得または設定します。
*/
@property (nonatomic) double threshold;

/**
*  カスタマイズするかどうかを取得または設定します。
*/
@property (nonatomic) BOOL isCustomized;

/**
*  XuniTooltip のインスタンスを初期化します。
*    @return XuniTooltip のインスタンス
*/
- (id)init;

/**
*  必要に応じて、ツールチップをリフレッシュします。
*/
- (void)invalidate;

/**
*  ツールチップを非表示にします。
*/
- (void)hide;

/**
*  ツールチップを表示します。
*/
- (void)show;

@end
