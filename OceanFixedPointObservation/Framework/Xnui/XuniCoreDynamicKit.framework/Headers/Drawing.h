//
//  Drawing.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
*  水平位置の配置方法を指定する列挙型
*/
typedef NS_ENUM (NSInteger, XuniHorizontalAlignment){
/**
*  水平位置は左側に配置
*/
    XuniHorizontalAlignmentLeft,
/**
*  水平位置は中央に配置
*/
    XuniHorizontalAlignmentCenter,
/**
*  水平位置は右側に配置
*/
    XuniHorizontalAlignmentRight
};

/**
*  垂直位置の配置方法を指定する列挙型
*/
typedef NS_ENUM (NSInteger, XuniVerticalAlignment){
/**
*  垂直位置は上部に配置
*/
    XuniVerticalAlignmentTop,
/**
*  垂直位置は中央に配置
*/
    XuniVerticalAlignmentCenter,
/**
*  垂直位置は下部に配置
*/
    XuniVerticalAlignmentBottom
};

/**
*  XuniPoint クラス
*/
@interface XuniPoint : NSObject

/**
*  XuniPoint の X 値を取得または設定します。
*/
@property double x;
/**
*  XuniPoint の Y 値を取得または設定します。
*/
@property double y;

/**
*  XuniRect オブジェクトを初期化します。
*    @return XuniRect オブジェクト
*/
- (id)init;

/**
*  X 値と Y 値を指定して XuniPoint オブジェクトを初期化します。
*    @param x X 座標
*    @param y Y 座標
*    @return XuniPoint オブジェクト
*/
- (id)initX:(double)x Y:(double)y;

/**
*  XuniRect オブジェクトのクローンを作成します。
*    @return XuniRect オブジェクト
*/
- (id)clone;

/**
*  2 つのポイントが等しいかどうかを判定します。
*    @param other 比較するもう一方のポイント
*    @return boolean 値
*/
- (BOOL)isEqual:(XuniPoint *)other;
@end

/**
*  XuniSize オブジェクト
*/
@interface XuniSize : NSObject
/**
*  XuniRect の幅を取得または設定します。
*/
@property double width;
/**
*  XuniRect の高さを取得または設定します。
*/
@property double height;

/**
*  XuniRect オブジェクトを初期化します。
*    @return XuniRect オブジェクト
*/
- (id)init;

/**
*  width と height を指定して XuniSize オブジェクトを初期化します。
*    @param width  幅
*    @param height 高さ
*    @return XuniSize オブジェクト
*/
- (id)initWidth:(double)width height:(double)height;

/**
*  XuniRect オブジェクトのクローンを作成します。
*    @return XuniRect オブジェクト
*/
- (id)clone;

/**
*  2 つのサイズが等しいかどうかを判定します。
*    @param other 比較するもう一方のサイズ
*    @return boolean 値
*/
- (BOOL)isEqual:(XuniSize *)other;
@end

/**
*  XuniRect クラス
*/
@interface XuniRect : NSObject
/**
*  XuniRect の左端を取得または設定します。
*/
@property double left;
/**
*  XuniRect の上端を取得または設定します。
*/
@property double top;
/**
*  XuniRect の幅を取得または設定します。
*/
@property double width;
/**
*  XuniRect の高さを取得または設定します。
*/
@property double height;
/**
*  XuniRect の右端を取得または設定します。
*/
@property (readonly) double right;
/**
*  XuniRect の下端を取得または設定します。
*/
@property (readonly) double bottom;

/**
*  XuniRect オブジェクトを初期化します。
*    @return XuniRect オブジェクト
*/
- (id)init;

/**
*  左端、上端、幅、高さ（left、top、width、height）を指定して XuniRect オブジェクトを初期化します。
*    @param left   XuniRect の左端
*    @param top    XuniRect の上端
*    @param width  XuniRect の幅
*    @param height XuniRect の高さ
*    @return XuniRect オブジェクト
*/
- (id)initLeft:(double)left top:(double)top width:(double)width height:(double)height;

/**
*  XuniRect オブジェクトのクローンを作成します。
*    @return XuniRect オブジェクト
*/
- (id)clone;

/**
*  2 つの四角形領域が等しいかどうかを判定します。
*    @param other 比較するもう一方の四角形領域
*    @return boolean 値
*/
- (BOOL)isEqual:(XuniRect *)other;

/**
*  四角形領域にポイントが含まれるかどうかを判定します。
*    @param point この HitTestInfo が参照するコントロール座標内のポイント
*    @return boolean 値
*/
- (BOOL)containsPoint:(XuniPoint *)point;

/**
*  四角形領域を指定された量だけ拡大または縮小して別の四角形を作成します。
*    @param dx 横に拡大する大きさ
*    @param dy 縦に拡大する大きさ
*    @return 拡大された四角形領域
*/
- (XuniRect *)inflate:(double)dx dy:(double)dy;
@end
