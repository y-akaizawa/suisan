//
//  ICollectionView.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "Event.h"

/**
*/
@class XuniObservableArray;


/**
*  collectionChanged アクションタイプを識別します。
*/
typedef NS_ENUM (NSInteger, XuniNotifyCollectionChangedAction){
/**
*  コレクションに追加された場合の変更通知
*/
    XuniNotifyCollectionChangedActionAdd,
/**
*  コレクションから削除された場合の変更通知
*/
    XuniNotifyCollectionChangedActionRemove,
/**
*  コレクションの項目が置換された場合の変更通知
*/
    XuniNotifyCollectionChangedActionReplace,
/**
*  コレクションがリセットされた場合の変更通知
*/
    XuniNotifyCollectionChangedActionReset
};

/**
*  collectionChanged イベントのデータを提供します。
*/
@interface XuniNotifyCollectionChangedEventArgs : XuniEventArgs

/**
*  引数をリセットします。
*    @return リセットされたオブジェクト
*/
+ (XuniNotifyCollectionChangedEventArgs *)reset;

/**
*  イベントの原因になったアクションを取得します。
*/
@property XuniNotifyCollectionChangedAction action;

/**
*  コレクションに追加された新しい項目
*/
@property NSMutableArray *items;

/**
*  コレクション内の新しい項目の開始インデックス
*/
@property long startingIndex;

/**
*  コレクションから削除された古い項目
*/
@property NSMutableArray *oldItems;

/**
*  コレクションから削除された古い項目の開始インデックス
*/
@property long oldStartingIndex;

/**
*  XuniNotifyCollectionChangedEventArgs オブジェクトを初期化します。
*    @param action 指定されたアクション
*    @return XuniNotifyCollectionChangedEventArgs オブジェクト
*/
- (id)initWithAction:(XuniNotifyCollectionChangedAction)action;

/**
*  引数を指定して XuniNotifyCollectionChangedEventArgs オブジェクトを初期化します。
*    @param action           指定されたアクション
*    @param items            項目
*    @param startingIndex    開始位置のインデックス
*    @param oldItems         変更前の項目
*    @param oldStartingIndex 変更前の開始位置のインデックス
*    @return XuniNotifyCollectionChangedEventArgs オブジェクト
*/
- (id)initWithAction:(XuniNotifyCollectionChangedAction)action forItems:(NSMutableArray *)items atStartingIndex:(long)startingIndex forOldItems:(NSMutableArray *)oldItems atOldStartingIndex:(long)oldStartingIndex;
@end

/**
*  任意のタイプの項目を受け取り、そのオブジェクトが一連の基準を満たすかどうかを示す boolean を返すメソッドを表します。
*    @param item 項目
*    @return オブジェクトが一連の基準を満たすかどうかを示す boolean
*/
typedef BOOL (^IXuniPredicate)(NSObject *item);

/**
*  2 つのオブジェクトを比較するメソッドを表します。
*    @param x オブジェクト X
*    @param y オブジェクト Y
*    @return boolean 値
*/
typedef int (^IXuniComparer)(NSObject *x, NSObject *y);

/**
*  ソート基準を記述します。
*/
@interface XuniSortDescription : NSObject

/**
*  ソートに使用されるプロパティの名前を取得します。
*/
@property NSString *property;

/**
*  値を昇順にソートするかどうかを決定する値を取得します。
*/
@property BOOL ascending;

/**
*  ソートの対象になる接続名を取得します。
*/
@property NSString *binding;

/**
*  XuniSortDescription オブジェクトを初期化します。
*    @param property  指定されたプロパティ
*    @param ascending 昇順の指定
*    @return XuniSortDescription オブジェクト
*/
- (id)initWithProperty:(NSString *)property ascending:(BOOL)ascending;
@end


/**
*  リスナーに動的変更を通知します。
*/
@protocol IXuniNotifyCollectionChanged

/**
*  変更されたコレクションのイベントを取得します。
*/
@property XuniEvent<XuniNotifyCollectionChangedEventArgs*> *collectionChanged;
@end

/**
*  ソート時の値の変換に使用される関数を表します。
*    @param sd    ソートの説明
*    @param item  項目
*    @param value 未加工の値
*    @return ソートに使用する値
*/
typedef NSObject * (^IXuniSortConverter)(XuniSortDescription *sd, NSObject *item, NSObject *value);

/**
*  コレクションに現在のレコードの管理、カスタムソート、フィルタ処理、およびグループ化の機能を提供します。
*/
@protocol IXuniCollectionView<IXuniNotifyCollectionChanged>

/**
*  このビューがフィルタ処理をサポートしているかどうかを示す値を取得します。
*/
@property (readonly) BOOL canFilter;

/**
*  このビューがグループ化をサポートしているかどうかを示す値を取得します。
*/
@property (readonly) BOOL canGroup;

/**
*  このビューがソートをサポートしているかどうかを示す値を取得します。
*/
@property (readonly) BOOL canSort;

/**
*  ビュー内の現在の項目を取得します。
*/
@property (readonly) NSObject *currentItem;

/**
*  ビュー内の現在の項目の順序位置を取得します。
*/
@property (readonly) int currentPosition;

/**
*  項目をビューに入れるかどうかを判断するために使用されるコールバックを取得または設定します。
*/
@property (nonatomic, copy) IXuniPredicate filter;

/**
*  ビューでコレクション内の項目をグループ化する方法を表すオブジェクトのコレクションを取得します。
*/
@property (readonly) XuniObservableArray *groupDescriptions;

/**
*  最上位グループを取得します。
*/
@property (readonly) NSArray *groups;

/**
*  このビューに項目が何も含まれていないかどうかを示す値を取得します。
*/
@property (readonly) BOOL isEmpty;

/**
*  ビューでコレクション内の項目をソートする方法を表す @see:SortDescription オブジェクトのコレクションを取得します。
*/
@property (readonly) XuniObservableArray *sortDescriptions;

/**
*  このビューの作成元のコレクションオブジェクトを取得または設定します。
*/
@property NSMutableArray *sourceCollection;

/**
*  指定された項目がこのビューに属するかどうかを示す値を返します。
*    @param item 項目
*    @return 指定された項目がこのビューに属するかどうかを示す boolean 値
*/
- (BOOL)contains:(NSObject *)item;

/**
*  指定された項目をビュー内の現在の項目に設定します。
*    @param item 項目
*    @return boolean 値
*/
- (BOOL)moveCurrentTo:(NSObject *)item;

/**
*  ビュー内の最初の項目を現在の項目として設定します。
*    @return boolean 値
*/
- (BOOL)moveCurrentToFirst;

/**
*  ビュー内の最後の項目を現在の項目として設定します。
*    @return boolean 値
*/
- (BOOL)moveCurrentToLast;

/**
*  ビュー内の現在の項目の後の項目を現在の項目として設定します。
*    @return boolean 値
*/
- (BOOL)moveCurrentToNext;

/**
*  ビュー内の指定されたインデックスにある項目を現在の項目として設定します。
*    @param index インデックス
*    @return boolean 値
*/
- (BOOL)moveCurrentToPosition:(int)index;

/**
*  ビュー内の現在の項目の前の項目を現在の項目として設定します。
*    @return boolean 値
*/
- (BOOL)moveCurrentToPrevious;

/**
*  現在のソート、フィルタ、およびグループパラメータを使用してビューを再作成します。
*/
- (void)refresh;

/**
*  現在のソート、フィルタ、およびグループパラメータを使用してビューを再作成します。
*    @param isNotifyCollectionChanged YES は collectionChanged イベントをトリガすることを意味し、NO はトリガしないことを意味します。
*/
- (void)refresh:(BOOL)isNotifyCollectionChanged;

/**
*  現在の項目が変更された後に発生します。
*/
@property XuniEvent *currentChanged;

/**
*  現在の項目が変更される前に発生します。
*/
@property XuniEvent *currentChanging;

/**
*  次に endUpdate が呼び出されるまで、リフレッシュを一時停止します。
*/
- (void)beginUpdate;

/**
*  beginUpdate を呼び出して一時停止されたリフレッシュを再開します。
*/
- (void)endUpdate;

/**
*  beginUpdate/endUpdate ブロック内で関数を実行します。
*    @param fn ブロック
*/
- (void)deferUpdate:(void (^)())fn;

/**
*  ビュー内のフィルタ処理された項目、ソートされた項目、グループ化された項目を取得します。
*/
@property (readonly) NSArray *items;

@end // IXuniCollectionView

/**
*  ICollectionView を拡張して、編集機能を提供するメソッドおよびプロパティを定義します。
*/
@protocol IXuniEditableCollectionView <IXuniCollectionView>

/**
*  新しい項目をコレクションに追加できるかどうかを示す値を取得します。
*/
@property (readonly) BOOL canAddNew;

/**
*  コレクションビューが保留中の変更を破棄し、編集されたオブジェクトの元の値を復元できるかどうかを示す値を取得します。
*/
@property (readonly) BOOL canCancelEdit;

/**
*  コレクションから項目を削除できるかどうかを示す値を取得します。
*/
@property (readonly) BOOL canRemove;

/**
*  現在の追加トランザクションの間に追加される項目を取得します。
*/
@property (readonly) NSObject *currentAddItem;

/**
*  現在の編集トランザクションの間に編集される項目を取得します。
*/
@property (readonly) NSObject *currentEditItem;

/**
*  追加トランザクションが進行中であるかどうかを示す値を取得します。
*/
@property (readonly) BOOL isAddingNew;

/**
*  編集トランザクションが進行中であるかどうかを示す値を取得します。
*/
@property (readonly) BOOL isEditingItem;

/**
*  コレクションに新しい項目を追加します。
*    @return オブジェクト
*/
- (NSObject *)addNew;

/**
*  現在の編集トランザクションを終了し、可能であれば、項目に元の値を復元します。
*/
- (void)cancelEdit;

/**
*  現在の追加トランザクションを終了し、保留中の新しい項目を破棄します。
*/
- (void)cancelNew;

/**
*  現在の編集トランザクションを終了し、保留中の変更を保存します。
*/
- (void)commitEdit;

/**
*  現在の追加トランザクションを終了し、保留中の新しい項目を保存します。
*/
- (void)commitNew;

/**
*  指定された項目の編集トランザクションを開始します。
*    @param item 項目
*/
- (void)editItem:(NSObject *)item;

/**
*  指定された項目をコレクションから削除します。
*    @param item 項目
*/
- (void)remove:(NSObject *)item;

/**
*  指定されたインデックスにある項目をコレクションから削除します。
*    @param index インデックス
*/
- (void)removeAt:(int)index;

/**
*  コレクションの最後に新しいオブジェクトを追加します。
*    @param anObject 追加するオブジェクト
*/
- (void)addObject:(NSObject *)anObject;


/**
*  コレクションの最後にオブジェクト配列を追加します。
*    @param objects 追加するオブジェクト
*/
- (void)addObjects:(NSArray *)objects;

/**
*  指定された位置に新しいオブジェクトを挿入します。
*    @param anObject 追加するオブジェクト
*    @param index    オブジェクトの位置
*/
- (void)insertObject:(NSObject *)anObject atIndex:(NSUInteger)index;

/**
*  コレクションからすべてのオブジェクトを削除します。
*/
- (void)removeAllObjects;

/**
*  現在の位置にあるオブジェクトを新しいオブジェクトに置き換えます
*    @param index    置き換えを行う位置
*    @param anObject 新しいオブジェクト
*/
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(NSObject *)anObject;

@end // IXuniEditableCollectionView

/**
*  グループ化条件を定義するタイプの基本クラスを表します。
*/
@interface XuniGroupDescription : NSObject

/**
*  指定された項目のグループ名を返します。
*    @param item  項目
*    @param level レベル
*    @return オブジェクト
*/
- (NSString *)groupNameFromItem:(NSObject *)item atLevel:(NSUInteger)level;

/**
*  グループ名と項目名が一致するかどうかを示す値を返します。
*    @param groupName グループ名
*    @param itemName  項目名
*    @return boolean 値
*/
- (BOOL)namesMatch:(NSString *)groupName itemName:(NSString *)itemName;
@end

/**
*  グループ名を生成するコールバック関数を表します。
*    @param item         項目
*    @param propertyName プロパティ名
*    @return グループ名
*/
typedef NSString * (^IXuniPropertyGroupConverter)(NSObject *item, NSString *propertyName);

/**
*  基準としてプロパティ名を使用して、項目のグループ化を記述します。
*/
@interface XuniPropertyGroupDescription : XuniGroupDescription

/**
*  項目が属するグループの特定に使用されるプロパティの名前を取得します。
*/
@property (readonly) NSString *property;

/**
*  XuniPropertyGroupDescription オブジェクトを初期化します。
*    @param property 指定されたプロパティ
*    @return XuniPropertyGroupDescription オブジェクト
*/
- (id)initWithProperty:(NSString *)property;

/**
*  XuniPropertyGroupDescription オブジェクトを初期化します。
*    @param property  指定されたプロパティ
*    @param converter グループ名を生成するコールバック関数
*    @return XuniPropertyGroupDescription オブジェクト
*/
- (id)initWithProperty:(NSString *)property converter:(IXuniPropertyGroupConverter)converter;
@end



