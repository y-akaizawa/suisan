//
//  CollectionView.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "ICollectionView.h"
#import "Aggregate.h"
#import "Util.h"

/**
*/
@class XuniCollectionViewGroup <__covariant ObjectType> ;
/**
*/
@class XuniObservableArray <__covariant ObjectType>;

/**
*  XuniCollectionView クラス
*/
@interface XuniCollectionView <__covariant ObjectType> : NSObject <IXuniEditableCollectionView>


/**
*  コレクションビュー（ XuniCollectionView ）に関する機能を実行します。
*    @return NSObject オブジェクト
*/
typedef NSObject * (^XuniFunction)();



/**
*  通知が現在一時停止されているかどうかを示す値を取得します。
*/
@property (readonly) BOOL isUpdating;

/**
*  XuniCollectionView オブジェクトを初期化します。
*    @return XuniCollectionView オブジェクト
*/
- (id)init;

/**
*  sourceCollection を指定して XuniCollectionView オブジェクトを初期化します。
*    @param sourceCollection コレクションのソース
*    @return sourceCollectionを伴うXuniCollectionView オブジェクト
*/
- (id)initWithSource:(NSArray<ObjectType> *)sourceCollection;

/**
*  インタフェースを実装します。
*    @param interfaceName インタフェース名文字列
*    @return boolean 値
*/
- (BOOL)implementsInterface:(NSString *)interfaceName;

/**
*  コレクションに新しい項目を作成する関数を取得または設定します。
*/
@property (nonatomic, copy) XuniFunction newItemCreator;

/**
*  ソート時の値の変換に使用される関数を取得または設定します。
*/
@property (nonatomic, copy) IXuniSortConverter sortConverter;

/**
*  現在のページのグループ化ビューを作成します。
*    @param items 項目
*    @return 変更可能な配列を返します。
*/
- (NSMutableArray *)createGroups:(NSArray *)items;

/**
*  配列のソートに使用される比較関数。
*    @return 比較の結果
*/
- (NSComparator)compareItems;

/**
*  グループのリストから、そのすべての子を含む配列を取得します。
*    @param groups グループ
*    @return 配列
*/
- (NSArray *)mergeGroupItems:(NSArray *)groups;

/**
*  グループを検索または作成します。
*    @param gd            グループの説明
*    @param groups        グループ配列
*    @param name          名前
*    @param level         レベル
*    @param isBottomLevel 最下位レベルかどうか
*    @return collectionView グループ
*/
- (XuniCollectionViewGroup<ObjectType> *)getGroup:(XuniGroupDescription *)gd groups:(NSArray *)groups name:(NSString *)name level:(NSUInteger)level isBottomLevel:(BOOL)isBottomLevel;

// IXuniCollectionView properties
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
@property (readonly) ObjectType currentItem;

/**
*  ビュー内の現在の項目の順序位置を取得します。
*/
@property (readonly) int currentPosition;

/**
*  項目をビューに入れるかどうかを判断するために使用されるコールバック関数を取得または設定します。
*/
@property (nonatomic, copy) IXuniPredicate filter;

/**
*  ビューでコレクション内の項目をグループ化する方法を表すオブジェクトのコレクションを取得します。
*/
@property (readonly) XuniObservableArray<XuniGroupDescription*> *groupDescriptions;

/**
*  このグループのサブグループを含む配列を取得します。
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
@property NSMutableArray<ObjectType> *sourceCollection;

/**
*  ビューにあるソート、フィルタ処理、グループ化した項目を取得します。
*/
@property (readonly) NSArray<ObjectType> *items;

/**
*  現在の項目が変更された後に発生します。
*/
@property XuniEvent<XuniEventArgs *> *currentChanged;

/**
*  現在の項目が変更される前に発生します。
*/
@property XuniEvent<XuniCancelEventArgs*> *currentChanging;

/**
*  currentChanged イベントを発生させます。
*    @param e イベントの引数
*/
- (void)onCurrentChanged:(XuniEventArgs *)e;

/**
*  currentChanging イベントを発生させます。
*    @param e イベントの引数
*    @return boolean 値
*/
- (BOOL)onCurrentChanging:(XuniCancelEventArgs *)e;

// IXuniEditableCollectionView properties

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
@property (readonly) ObjectType currentAddItem;

/**
*  現在の編集トランザクションの間に編集される項目を取得します。
*/
@property (readonly) ObjectType currentEditItem;

/**
*  追加トランザクションが進行中であるかどうかを示す値を取得します。
*/
@property (readonly) BOOL isAddingNew;

/**
*  編集トランザクションが進行中であるかどうかを示す値を取得します。
*/
@property (readonly) BOOL isEditingItem;

/**
*  ビュー内の項目の数を取得します。
*/
@property (readonly) int itemCount;

// IXuniNotifyCollectionChanged properties

/**
*  コレクションが変更された後に発生します。
*/
@property XuniEvent<XuniNotifyCollectionChangedEventArgs*> *collectionChanged;

/**
*  collectionChanged イベントを発生させます。
*    @param e イベントの引数
*/
- (void)onCollectionChanged:(XuniNotifyCollectionChangedEventArgs *)e;

/**
*  イベント引数を作成し、onCollectionChanged を呼び出します。
*/
- (void)raiseCollectionChanged;

/**
*  リスナーに必要な通知をプッシュするために、コレクションが変更されたときに呼び出されます。
*    @param action           コレクション変更のタイプ
*    @param items            追加された新しい項目のリスト
*    @param startingIndex    更新されたコレクション内の新しい項目のインデックス
*    @param oldItems         削除または変更された項目のリスト
*    @param oldStartingIndex コレクションから削除された古い項目の開始インデックス
*/
- (void)raiseCollectionChangedParams:(XuniNotifyCollectionChangedAction)action items:(NSMutableArray<ObjectType> *)items startingIndex:(long)startingIndex oldItems:(NSMutableArray<ObjectType> *)oldItems oldStartingIndex:(long)oldStartingIndex;

@end


/**
*  XuniCollectionView オブジェクトの groupDescriptions プロパティに基づいて作成されたグループを表します。
*/
@interface XuniCollectionViewGroup<__covariant ObjectType> : NSObject {
/**
*/
    @private
/**
*/
    NSString             *_name;
/**
*/
    NSUInteger           _level;
/**
*/
    BOOL                 _isBottomLevel;
/**
*/
    NSMutableArray       *_items;
/**
*/
    NSArray              *_groups;
/**
*/
    XuniGroupDescription *_groupDescription;
/**
*/
    NSArray              *_agg;
}

@property (nonatomic, readonly) NSUInteger totalItemCount;

/**
*  このグループの名前を取得します。
*/
@property (readonly) NSString *name;
/**
*  このグループのレベルを取得します。
*/
@property (readonly) NSUInteger level;
/**
*  このグループがサブグループを持つかどうかを示す値を取得します。
*/
@property (readonly) BOOL isBottomLevel;
/**
*  このグループ（すべてのサブグループを含む）に含まれる項目を含む配列を取得します。
*/
@property (readonly) NSMutableArray *items;
/**
*  このグループのサブグループを含む配列を取得します。
*/
@property (readonly) NSArray<XuniCollectionViewGroup<ObjectType>*> *groups;
/**
*  このグループを所有する GroupDescription を取得します。
*/
@property (readonly) XuniGroupDescription *groupDescription;

/**
*  XuniCollectionViewGroup オブジェクトを初期化します。
*    @param groupDescription groupDescription
*    @param name             名前
*    @param level            レベル
*    @param isBottomLevel    最下位レベルかどうか
*    @return XuniCollectionViewGroup オブジェクト
*/
- (id)initWithGroup:(XuniGroupDescription *)groupDescription name:(NSString *)name level:(NSUInteger)level isBottomLevel:(BOOL)isBottomLevel;

/**
*  このグループ内の項目の集計値を計算します。
*    @param aggType 集計タイプ
*    @param binding 連結
*    @return NSObject オブジェクト
*/
- (NSObject *)getAggregate:(XuniAggregate)aggType binding:(NSString *)binding;

@end

/**
*  データを増分読み込みが可能なロードオンデマンド機能を提供する コレクションビュー（ XuniCollectionView ）です。
*/
@interface XuniCursorCollectionView<__covariant ObjectType> : XuniCollectionView<ObjectType>

/**
*  増分読み込み可能なデータを保持しているかどうか
*    @return boolean 値
*/
- (bool)hasMoreItems;

/**
*  項目を読み込みます。
*    @param desiredNumber ロードする件数
*    @return 読み込んだ項目の配列
*/
- (NSMutableArray<ObjectType> *)itemGetter:(NSNumber *)desiredNumber;

/**
*  項目の増分を読み込みます。
*    @param desiredNumber ロードする件数
*    @param completion 読み込みが完了した際に実行する処理
*/
- (void)loadMoreItems:(NSNumber *)desiredNumber completion:(void (^)())completion;

@end
