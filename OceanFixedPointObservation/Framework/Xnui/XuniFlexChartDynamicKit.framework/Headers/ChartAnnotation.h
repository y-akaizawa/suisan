//
//  ChartAnnotation.h
//  FlexChart
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

/**
*/
@class FlexChart;
/**
*  FlexChart の注釈（アノテーション）クラス
*/
@interface XuniChartAnnotation : NSObject

/**
*  注釈の添付方法を取得または設定します。
*/
@property (nonatomic) XuniChartAnnotationAttachment attachment;

/**
*  注釈の幅を取得または設定します。
*/
@property (nonatomic) double width;

/**
*  注釈の高さを取得または設定します。
*/
@property (nonatomic) double height;

/**
*  注釈が表示されているかどうかを取得または設定します。
*/
@property (nonatomic) BOOL isVisible;

/**
*  ポイントからの注釈のオフセットを取得または設定します。
*/
@property (nonatomic) XuniPoint *offset;

/**
*  プロットエリアに対する軸の位置を取得または設定します。
*/
@property (nonatomic) XuniChartAnnotationPosition position;

/**
*  注釈のポイントを取得または設定します。
*    ポイント座標は Attachment プロパティに依存します。
*/
@property (nonatomic) XuniPoint *point;

/**
*  注釈のポイントインデックスを取得または設定します。
*    Attachment プロパティが PointIndex に設定されている場合にのみ適用されます。
*/
@property (nonatomic) int pointIndex;

/**
*  注釈の系列インデックスを取得または設定します。
*    Attachment プロパティが DataIndex に設定されている場合にのみ適用されます。
*/
@property (nonatomic) int seriesIndex;

/**
*  注釈のツールチップテキストを取得または設定します。
*/
@property (nonatomic) NSString *tooltipText;

/**
*  XuniChartAnnotation クラスのインスタンスを初期化します。
*    @param chart 初期化に使用する FlexChart
*    @return XuniChartAnnotation クラスのインスタンス
*/
- (instancetype)initWithChart:(FlexChart *)chart;

@end
