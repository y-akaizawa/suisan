//
//  GridDataMap.h
//  FlexGrid
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef XUNI_INTERNAL_DYNAMIC_BUILD

#ifndef XuniCoreKit_h
#import "XuniCore/CollectionView.h"
#endif

#else

#import <XuniCoreDynamicKit/XuniCoreDynamicKit.h>

#endif

/**
*  GridDataMap クラス
*/
@interface GridDataMap : NSObject

/**
*  配列を指定して GridDataMap オブジェクトを初期化します。
*    @param array 指定された配列
*    @return FlexDataMap オブジェクト
*/
- (id)initWithArray:(NSArray *)array;

/**
*  パラメータを指定して GridDataMap オブジェクトを初期化します。
*    @param array             配列
*    @param selectedValuePath 選択する値のパス
*    @param displayMemberPath 表示する名前のパス
*    @return GridDataMap オブジェクト
*/
- (id)initWithArray:(NSArray *)array selectedValuePath:(NSString *)selectedValuePath displayMemberPath:(NSString *)displayMemberPath;

/**
*  パラメータを指定して FlexDataMap オブジェクトを初期化します。
*    @param items             項目
*    @param selectedValuePath 選択する値のパス
*    @param displayMemberPath 表示する名前のパス
*    @return GridDataMap オブジェクト
*/
- (id)initWithCollectionView:(XuniCollectionView *)items selectedValuePath:(NSString *)selectedValuePath displayMemberPath:(NSString *)displayMemberPath;

/**
*  グリッドデータを保持する ICollectionView を取得します。
*/
@property (readonly) XuniCollectionView *collectionView;

/**
*  項目（データ値）のキーとして使用するプロパティ名を取得します。
*/
@property (readonly) NSString *selectedValuePath;

/**
*  項目の表示用の値として使用するプロパティ名を取得します。
*/
@property (readonly) NSString *displayMemberPath;

/**
*  指定された表示用の値に対応するキーを取得します。
*    @param displayValue 表示用の値
*    @return 表示用の値に対応するキー
*/
- (NSObject *)getKeyValue:(NSString *)displayValue;

/**
*  指定されたキーに対応する表示用の値を取得します。
*    @param key キー
*    @return キーに対応する表示用の値
*/
- (NSObject *)getDisplayValue:(NSObject *)key;

/**
*  このマップのすべての表示用の値を含む配列を取得します。
*    @return 配列
*/
- (NSArray *)getDisplayValues;

/**
*  このマップのすべてのキーを含む配列を取得します。
*    @return 配列
*/
- (NSArray *)getKeyValues;

/**
*  指定された表示用の値に対応する 0 から始まるインデックスを取得します。
*    @param displayValue 表示用の値
*    @return 表示用の値に対応する 0 からはじまるインデックス
*/
- (int)displayIndexOf:(NSString *)displayValue;

@end
