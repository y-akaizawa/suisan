//
//  XuniView.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
*/
@class XuniView;
/**
*/
@class XuniPoint;

/**
*  XuniCalendarDelegate プロトコル
*/
@protocol XuniViewDelegate <NSObject>
/**
*/
@optional

/**
*  コントロールが描画されているときに呼び出されます。
*    @param sender 描画対象のコントロール
*/
- (void)rendering:(XuniView *)sender;

/**
*  コントロールの描画が完了したときに呼び出されます。
*    @param sender 描画対象のコントロール
*/
- (void)rendered:(XuniView *)sender;

/**
*  コントロールがタップされたときに呼び出されます。
*    @param sender タップされたコントロール
*    @param point  タップされた位置のPointデータ 
*    @return boolean 値
*/
- (BOOL)tapped:(XuniView *)sender point:(XuniPoint *)point;

@end


/**
*  XuniCalendar クラス
*/
@interface XuniView : UIView

/**
*  コンテンツサイズの設定が変更されたときに応答します。
*/
- (void)respondToSizeChanged;

/**
*  デバイスの向きが変更されたときに応答します。
*/
- (void)respondToOrientationChanged;

/**
*  対象のコントロールを画像として取得します。
*    @return 画像データ
*/
- (NSData *)getImage;

@end
