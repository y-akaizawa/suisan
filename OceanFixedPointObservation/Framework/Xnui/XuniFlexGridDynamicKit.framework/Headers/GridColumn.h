//
//  GridColumn.h
//  FlexGrid
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridRowCol.h"
#import "GridDataMap.h"

#ifndef XUNI_INTERNAL_DYNAMIC_BUILD

#ifndef XuniCoreKit_h
#import "XuniCore/Aggregate.h"
#import "XuniCore/Util.h"
#endif

#else

#import <XuniCoreDynamicKit/XuniCoreDynamicKit.h>

#endif

/**
*  列幅（ width ）の指定方法の列挙型
*/
typedef NS_ENUM (NSInteger, GridColumnWidth){
/**
*  列幅を自動的に指定
*/
    GridColumnWidthAuto,
/**
*  列幅をピクセルで指定
*/
    GridColumnWidthPixel,
/**
*  列幅をスターサイズ指定
*/
    GridColumnWidthStar
};

/**
*  GridColumn クラス
*/
@interface GridColumn : GridRowCol

/**
*  GridColumn オブジェクトを初期化します。
*    @return GridColumn オブジェクト
*/
- (id)init;


/**
*  テキストの表示位置を取得または設定します。
*/
@property (nonatomic) NSTextAlignment horizontalAlignment;

/**
*  ヘッダーテキストの水平位置を取得または設定します。
*/
@property (nonatomic) NSTextAlignment headerHorizontalAlignment;

/**
*  この列の名前を取得または設定します。
*/
@property (nonatomic) NSString *name;

/**
*  この列に格納される値のタイプを取得または設定します。
*/
@property (nonatomic) XuniDataType dataType;

/**
*  この列の値が必須であるかどうかを取得または設定します。
*/
@property (nonatomic) BOOL required;

/**
*  この列内の値の編集に使用されるキーボードのタイプを取得または設定します。
*/
@property (nonatomic) UIKeyboardType inputType;

/**
*  この列の値を編集する際に使用されるマスクを取得または設定します。
*/
@property (nonatomic) NSString *mask;

/**
*  この列が連結されているプロパティの名前を取得または設定します。
*/
@property (nonatomic) NSString *binding;

/**
*  この列の幅を取得または設定します。
*/
@property (nonatomic) double width;

/**
*  この列の width プロパティがどのような形式で指定されるかを取得または設定します。
*/
@property (nonatomic) GridColumnWidth widthType;

/**
*  この列の最小幅を取得または設定します。
*/
@property (nonatomic) int minWidth;

/**
*  この列の最大幅を取得または設定します。
*/
@property (nonatomic) int maxWidth;

/**
*  この列のレンダリング幅を取得します。
*/
@property (readonly) int renderWidth;

/**
*  列ヘッダーに表示されるテキストを取得または設定します。
*/
@property (nonatomic) NSString *header;

/**
*  未加工の値をこの列の表示値に変換するために使用されるデータマップを取得または設定します。
*/
@property (nonatomic) GridDataMap *dataMap;

/**
*  未加工の値をこの列の表示値に変換するために使用される書式文字列を取得または設定します。
*/
@property (nonatomic) NSString *format;

/**
*  未加工の値をこの列の表示値に変換するために使用される NSFormatter オブジェクトを取得または設定します。
*/
@property (nonatomic) NSFormatter *formatter;

/**
*  ユーザーがこの列のヘッダーをクリックしてソートできるかどうかを取得または設定します。
*/
@property (nonatomic) BOOL allowSorting;

/**
*  この列の現在のソート方向を取得します。
*/
@property (readonly) NSComparisonResult sortDirection;

/**
*  この列のグループヘッダー行に表示する集計を取得または設定します。
*/
@property (nonatomic) XuniAggregate aggregate;

/**
*  この列をソートする基準となるプロパティ名を取得または設定します。
*/
@property (nonatomic) NSString *sortMemberPath;

/**
*  この列のソート処理に使用するプロパティ名を取得または設定します。
*/
- (NSString *)getSortMemberPath;

/**
*  連結データ型を取得します。
*    @param target ターゲット
*    @return 連結のデータ型
*/
- (XuniDataType)getBoundDataType:(NSObject *)target;

/**
*  連結値を取得します。
*    @param target ターゲット
*    @return 連結値
*/
- (NSObject *)getBoundValue:(NSObject *)target;

/**
*  ターゲットに連結値を設定します。
*    @param value  指定された値
*    @param target ターゲット
*/
- (void)setBoundValue:(NSObject *)value forTarget:(NSObject *)target;

/**
*  書式設定された値を取得します。
*    @param value 値
*    @return 書式設定された値
*/
- (NSObject *)getFormattedValue:(NSObject *)value;

/**
*  書式設定されたヘッダーを取得します。
*    @return 書式設定されたヘッダーオブジェクト
*/
- (NSObject *)getFormattedHeader;

/**
*  この列のソート方向を設定する内部メソッドです。
*    @param direction ソート方向
*/
- (void)setSortDirection:(NSComparisonResult)direction;

@end
