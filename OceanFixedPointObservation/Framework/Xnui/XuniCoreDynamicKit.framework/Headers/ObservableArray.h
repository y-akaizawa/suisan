//
//  ObservableArray.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "ICollectionView.h"

/**
*  XuniObservableArray クラス
*/
@interface XuniObservableArray<__covariant ObjectType> : NSObject <IXuniNotifyCollectionChanged>

/**
*  添字のインデックスでオブジェクトを取得します。
*    @param key キーになる添字
*    @return return 添字に対するオブジェクト
*/
- (ObjectType)objectAtIndexedSubscript:(int)key;


/**
*  添字のインデックスでオブジェクトを設定します。
*    @param obj オブジェクト
*    @param key キーになる添字
*/
- (void)setObject:(ObjectType)obj atIndexedSubscript:(int)key;

/**
*  ソースの配列を取得します。
*/
@property (readonly) NSArray<ObjectType> *sourceArray;

/**
*  配列の数を取得します。
*/
@property (readonly) NSUInteger count;

/**
*  配列のオブジェクトを取得します。
*    @param index オブジェクトのインデックス
*    @return オブジェクト
*/
- (ObjectType)objectAtIndex:(NSUInteger)index;

/**
*  オブジェクトのインデックスを取得します。
*    @param anObject オブジェクト
*    @return オブジェクトのインデックス
*/
- (NSUInteger)indexOfObject:(ObjectType)anObject;

// NSMutableArray methods
/**
*  配列にオブジェクトを追加します。
*    @param anObject オブジェクト
*/
- (void)addObject:(ObjectType)anObject;

/**
*  配列のオブジェクトを配列に追加します。
*    @param array 配列
*/
- (void)addObjectsFromArray:(NSArray<ObjectType>*)array;

/**
*  配列のインデックスの位置にオブジェクトを挿入します。
*    @param anObject オブジェクト
*    @param index    挿入インデックス
*/
- (void)insertObject:(ObjectType)anObject atIndex:(NSUInteger)index;

/**
*  配列からすべてのオブジェクトを削除します。
*/
- (void)removeAllObjects;

/**
*  配列からオブジェクトを削除します。
*    @param anObject オブジェクト
*/
- (void)removeObject:(ObjectType)anObject;

/**
*  配列からインデックスの位置にあるオブジェクトを削除します。
*    @param index インデックス
*/
- (void)removeObjectAtIndex:(NSUInteger)index;

/**
*  配列内のインデックスの位置にあるオブジェクトを別のオブジェクトに置き換えます。
*    @param index    インデックス
*    @param anObject オブジェクト
*/
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)anObject;

/**
*  XuniObservableArray のインスタンスを初期化します。
*    @return XuniObservableArray のインスタンス
*/
- (instancetype)init NS_DESIGNATED_INITIALIZER;

/**
*  容量を指定して XuniObservableArray のインスタンスを初期化します。
*    @param numItems 項目の数
*    @return XuniObservableArray のインスタンス
*/
- (instancetype)initWithCapacity:(NSUInteger)numItems NS_DESIGNATED_INITIALIZER;

/**
*  次に endUpdate が呼び出されるまで、通知を一時停止します。
*/
- (void)beginUpdate;

/**
*  beginUpdate の呼び出しにより、一時停止されている通知を再開します。
*/
- (void)endUpdate;

/**
*  通知が現在一時停止されているかどうかを示す値を取得します。
*    @return boolean 値
*/
- (BOOL)isUpdating;

/**
*  beginUpdate/endUpdate ブロック内で関数を実行します。
*    @param fn ブロック
*/
- (void)deferUpdate:(void (^)())fn;

/**
*  collectionChanged を取得または設定します。
*/
@property XuniEvent<XuniNotifyCollectionChangedEventArgs*> *collectionChanged;

/**
*  collectionChanged イベントを発生させます。
*    @param e XuniNotifyCollectionChangedEventArgs オブジェクト
*/
- (void)onCollectionChanged:(XuniNotifyCollectionChangedEventArgs *)e;

/**
*  collectionChanged イベントを発生させます。
*    @param action           コレクションがどのように変更されたか
*    @param items            項目
*    @param startingIndex    コレクション内の新しい項目の開始インデックス
*    @param oldItems         コレクションから削除された古い項目
*    @param oldStartingIndex コレクションから削除された古い項目の開始インデックス
*/
- (void)raiseCollectionChanged:(XuniNotifyCollectionChangedAction)action items:(NSMutableArray *)items startingIndex:(long)startingIndex oldItems:(NSMutableArray *)oldItems oldStartingIndex:(long)oldStartingIndex;

@end
