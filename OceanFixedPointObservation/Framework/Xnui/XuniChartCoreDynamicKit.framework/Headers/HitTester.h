//
//  HitTester.h
//  XuniChartCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

/**
*  IXuniHitArea プロトコル
*/
@protocol IXuniHitArea

/**
*  この領域のタグを取得または設定します。
*/
@property NSObject *tag;

/**
*  円グラフのスライスの開始角度を取得または設定します。
*/
@property double startAngle;

/**
*  円グラフのスライスの中心角度を取得または設定します。
*/
@property double sweep;

/**
*  ポイントが領域内にあるかどうかを判定します。
*    @param point この HitTestInfo が参照するコントロール座標内のポイント
*    @return boolean 値
*/
- (BOOL)contains:(XuniPoint*)point;

/**
*  距離を計算します。
*    @param point  この HitTestInfo が参照するコントロール座標内のポイント
*    @return 距離
*/
- (double)distance:(XuniPoint*)point;
@end

/**
*  XuniRectArea クラス
*/
@interface XuniRectArea : NSObject<IXuniHitArea>

/**
*  この領域のタグを取得または設定します。
*/
@property NSObject *tag;

/**
*  領域を構成する四角形領域を取得します。
*/
@property (readonly) XuniRect* rect;

/**
*  XuniRectArea オブジェクトを初期化します。
*    @param rect 四角形領域
*    @return XuniRectArea オブジェクト
*/
- (id)init:(XuniRect*)rect;

/**
*  2 ポイント間の距離を計算します。
*    @param pt1    1 つのポイント
*    @param pt2    測定対象となる別のポイント
*    @param option 測定オプション
*    @return 2 ポイント間の距離
*/
- (double)distanceFromPoint:(XuniPoint*)pt1 toPoint:(XuniPoint*)pt2 option:(XuniMeasureOption)option;
@end

/**
*  XuniCircleArea クラス
*/
@interface XuniCircleArea : NSObject<IXuniHitArea>

/**
*  この領域のタグを取得または設定します。
*/
@property NSObject *tag;

/**
*  円領域の中心を取得します。
*/
@property (readonly) XuniPoint* center;

/**
*  XuniCircleArea オブジェクトを初期化します。
*    @param center 領域の中心
*    @param radius 領域の半径
*    @return XuniCircleArea オブジェクト
*/
- (id)init:(XuniPoint*)center radius:(double)radius;
@end

/**
*  XuniHitResult クラス
*/
@interface XuniHitResult : NSObject

/**
*  チャートの領域を取得または設定します。
*/
@property NSObject<IXuniHitArea> *area;

/**
*  最も近いデータポイントからの距離を取得または設定します。
*/
@property double distance;
@end

/**
*  XuniHitTester
*/
@interface XuniHitTester : NSObject

/**
*  領域と系列のインデックスをまとめて格納します。
*    @param area        チャートの領域
*    @param seriesIndex 系列のインデックス
*/
- (void)add:(NSObject<IXuniHitArea>*)area seriesIndex:(int)seriesIndex;

/**
*  オブジェクトをクリアします。
*/
- (void)clear;

/**
*  領域にヒットした後の結果を取得します。
*    @param point  この HitTestInfo が参照するコントロール座標内のポイント。
*    @return 領域にヒットした後の結果
*/
- (XuniHitResult*) hitTest:(XuniPoint*)point;

/**
*  系列にヒットした後の結果を取得します。
*    @param point       この HitTestInfo が参照するコントロール座標内のポイント
*    @param seriesIndex 系列のインデックス
*    @return 系列にヒットした後の結果
*/
- (XuniHitResult*) hitTestSeries:(XuniPoint*)point seriesIndex:(int)seriesIndex;

/**
*  @exclude.
*/
- (NSMutableDictionary *) getHitTesterMap;

@end
