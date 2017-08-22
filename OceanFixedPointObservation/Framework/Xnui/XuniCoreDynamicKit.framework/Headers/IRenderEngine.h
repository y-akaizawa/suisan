//
//  IRenderEngine.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drawing.h"

/**
*  XuniRenderState.
*/
@interface XuniRenderState : NSObject

/**
*  塗りつぶし色を取得または設定します。
*/
@property UIColor *fill;

/**
*  ストローク色を取得または設定します。
*/
@property UIColor *stroke;

/**
*  ストロークの太さを取得または設定します。
*/
@property double strokeThickness;

/**
*  不透明度を取得または設定します。
*/
@property double opacity;

/**
*  境界線の破線を取得または設定します。
*/
@property NSArray *borderDashes;

/**
*  フォントを取得または設定します。
*/
@property UIFont *font;

@end

/**
*  描画に使用します。
*/
@protocol IXuniRenderEngine

/**
*  エンジンをクリアします。
*/
- (void)clear;

/**
*  テキストを塗りつぶす色を取得します。
*    @return 色
*/
- (UIColor *)getTextFill;

/**
*  ビューポートのサイズを設定します。
*    @param width  サイズの幅
*    @param height サイズの高さ
*/
- (void)setViewportSize:(double)width height:(double)height;

/**
*  四角形をクリップします。
*    @param x 四角形の左端
*    @param y 四角形の上端
*    @param w 四角形の幅
*    @param h 四角形の高さ
*/
- (void)setClipRect:(double)x y:(double)y w:(double)w h:(double)h;

/**
*  クリッピング四角形をクリアします。
*/
- (void)clearClipRect;

/**
*  塗りつぶし色を設定します。
*    @param color 色
*/
- (void)setFill:(UIColor *)color;

/**
*  塗りつぶし色を取得します。
*    @return 塗りつぶし色
*/
- (UIColor *)getFill;

/**
*  ストロークの色を設定します。
*    @param color 色
*/
- (void)setStroke:(UIColor *)color;

/**
*  ストロークの太さを設定します。
*    @param thickness 指定された太さ
*/
- (void)setStrokeThickness:(double)thickness;

/**
*  テキストの塗りつぶし色を設定します。
*    @param color 指定された色
*/
- (void)setTextFill:(UIColor *)color;

/**
*  フォントを設定します。
*    @param font 指定されたフォント
*/
- (void)setFont:(UIFont *)font;

/**
*  不透明度を設定します。
*    @param opacity 指定された不透明度
*/
- (void)setOpacity:(double)opacity;

/**
*  境界線の破線を設定します。
*    @param dashes 破線
*/
- (void)setBorderDashes:(NSArray *)dashes;

/**
*  選択された破線を設定します。
*    @param dashes 指定された破線
*/
- (void)setSelectedDashes:(NSArray *)dashes;

/**
*  スケールを設定します。
*    @param scalex スケール X
*    @param scaley スケール Y
*/
- (void)setScale:(float)scalex scaley:(float)scaley;

/**
*  パンを設定します。
*    @param panX パンの X 座標
*    @param panY パン Y 座標
*/
- (void)setPan:(float)panX y:(float)panY;

/**
*  楕円を描画します。
*    @param cx 楕円を囲む四角形の左端
*    @param cy 楕円を囲む四角形の上端
*    @param rx 楕円を囲む四角形の幅
*    @param ry 楕円を囲む四角形の高さ
*/
- (void)drawEllipse:(double)cx cy:(double)cy rx:(double)rx ry:(double)ry;

/**
*  四角形を描画します。
*    @param x 四角形の左端
*    @param y 四角形の右端
*    @param w 四角形の幅
*    @param h 四角形の高さ
*    @param selected 選択状態かどうか
*/
- (void)drawRect:(double)x y:(double)y w:(double)w h:(double)h isSelected:(BOOL)selected;

/**
*  四角形を描画します。
*    @param x        四角形の左端
*    @param y        四角形の右端
*    @param w        四角形の幅
*    @param h        四角形の高さ
*/
- (void)drawRect:(double)x y:(double)y w:(double)w h:(double)h;

/**
*  線を描画します。
*    @param x1 線の開始点の X 値
*    @param y1 線の開始点の Y 値
*    @param x2 線の終了点の X 値
*    @param y2 線の終了点の Y 値
*/
- (void)drawLine:(double)x1 y1:(double)y1 x2:(double)x2 y2:(double)y2;

/**
*  線を描画します。
*    @param xs ポイントの X 値
*    @param ys ポイントの Y 値
*/
- (void)drawLines:(NSArray *)xs ys:(NSArray *)ys;

/**
*  スプラインを描画します。
*    @param xs ポイントの X 値
*    @param ys ポイントの Y 値
*    @param isRotated チャートを回転するかどうか
*/
- (void)drawSplines:(NSArray *)xs ys:(NSArray *)ys isRotated:(BOOL)isRotated;

/**
*  スプラインによって生成される領域を描画します。
*    @param xs      ポイントの X 値
*    @param ys      ポイントの Y 値
*    @param stacked 積層するかどうか
*    @param isRotated チャートを回転するかどうか
*/
- (void)drawSplineAreas:(NSArray *)xs ys:(NSArray *)ys stacked:(BOOL)stacked isRotated:(BOOL)isRotated;

/**
*  多角形を描画します。
*    @param xs ポイントの X 値
*    @param ys ポイントの Y 値
*/
- (void)drawPolygon:(NSArray *)xs ys:(NSArray *)ys;

/**
*  描画モードを指定して多角形を描画します。
*    @param points 多角形の頂点を設定した XuniPoint オブジェクトの配列
*    @param mode   描画モード（ CGPathDrawingMode ）
*/
- (void)drawPolygonWithMode:(NSArray *)points mode:(CGPathDrawingMode)mode;

/**
*  円形ゲージを描画します。
*    @param x          X
*    @param y          Y
*    @param startX     開始点の X 値
*    @param startY     開始点の Y 値
*    @param radiusOut  外側半径
*    @param radiusIn   内側半径
*    @param startAngle 開始角度
*    @param endAngle   終了角度
*/
- (void)drawRadialGauge:(double)x y:(double)y startX:(double)startX startY:(double)startY radiusOut:(double)radiusOut radiusIn:(double)radiusIn startAngle:(double)startAngle endAngle:(double)endAngle;

/**
*  円グラフのセグメントを描画します。
*    @param cx         円の中心点の X 値
*    @param cy         円の中心点の Y 値
*    @param radius     円の半径
*    @param startAngle 開始角度
*    @param sweepAngle 移動角度
*    @param selected   選択されているかどうか
*    @return 円グラフのセグメントのパスを返します。
*/
- (CGMutablePathRef)drawPieSegment:(double)cx cy:(double)cy radius:(double)radius startAngle:(double)startAngle sweepAngle:(double)sweepAngle selected:(BOOL)selected;

/**
*  円グラフのドーナツを描画します。
*    @param cx          円の中心点の X 値
*    @param cy          円の中心点の Y 値
*    @param radius      円の半径
*    @param innerRadius 円の内側半径
*    @param startAngle  開始角度
*    @param sweepAngle  移動角度
*    @param selected    選択されているかどうか
*    @return 円グラフのドーナツのパス
*/
- (CGMutablePathRef)drawDonutSegment:(double)cx cy:(double)cy radius:(double)radius innerRadius:(double)innerRadius startAngle:(double)startAngle sweepAngle:(double)sweepAngle selected:(BOOL)selected;

/**
*  文字列を描画します。
*    @param s  指定された文字列
*    @param pt 文字列の描画位置を指定するポイント
*/
- (void)drawString:(NSString *)s pt:(XuniPoint *)pt;

/**
*  四角形領域の内部に文字列を描画します。
*    @param s  指定する文字列
*    @param rect 文字列を描画する四角形領域
*/
- (void)drawStringInRect:(NSString *)s rect:(CGRect)rect;

/**
*  回転した文字列を描画します。
*    @param label  文字列
*    @param pt     文字列の描画位置を指定するポイント
*    @param center 文字列の回転の中心を指定するポイント
*    @param angle  角度
*/
- (void)drawStringRotated:(NSString *)label pt:(XuniPoint *)pt center:(XuniPoint *)center angle:(double)angle;

/**
*  イメージを描画します。
*    @param image  イメージ
*    @param rect   イメージの描画位置を指定する四角形領域
*/
- (void)drawImage:(CGImageRef)image rect:(CGRect)rect;

/**
*  回転した文字列のサイズを測定します。
*    @param s     指定された文字列
*    @return 回転した文字列のサイズ
*/
- (XuniSize *)measureString:(NSString *)s;

/**
*  回転した文字列のサイズを測定します。
*    @param s     指定する文字列
*    @param angle 文字列の回転角度
*    @return 回転した文字列のサイズ
*/
- (XuniSize *)measureString:(NSString *)s rotated:(double)angle;

/**
*  グループを開始します。
*    @param groupName グループ名
*/
- (void)startGroup:(NSString *)groupName;
/**
*  グループを終了します。
*/
- (void)endGroup;

/**
*  レンダリングの状態を保存します。
*    @return レンダリングの状態を返します。
*/
- (XuniRenderState *)saveState;

/**
*  レンダリングの状態を復元します。
*    @param state レンダリングの状態
*/
- (void)restoreState:(XuniRenderState *)state;

/**
*  ストロークの色を取得します。
*    @return ストロークの色
*/
- (UIColor *)getStroke;

/**
*  ストロークの太さを取得します。
*    @return ストロークの太さ
*/
- (double)getStrokeThickness;
@end
