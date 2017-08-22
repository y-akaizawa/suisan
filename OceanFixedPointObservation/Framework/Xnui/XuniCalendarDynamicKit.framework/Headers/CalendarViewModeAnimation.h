//
//  CalendarViewModeAnimation.h
//  XuniCalendar
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XuniCoreKit_h
#import "XuniCore/Animation.h"
#endif

/**
*  カレンダーのビューモードアニメーションに関する情報を保持するクラス
*/
@interface XuniCalendarViewModeAnimation : XuniAnimation

/**
*  カレンダービューモード変更時のアニメーションの種類を取得または設定します。
*/
@property (nonatomic) XuniCalendarViewAnimationMode animationMode;

/**
*  アニメーションで使用するスケールを取得または設定します。
*/
@property (nonatomic) double scaleFactor;

/**
*  新しく割り当てられた XuniCalendarViewModeAnimation オブジェクトを初期化して返します。
*    @return 初期化された XuniCalendarViewModeAnimation オブジェクト。オブジェクトを作成できなかった場合は nil
*/
- (instancetype)init;

@end
