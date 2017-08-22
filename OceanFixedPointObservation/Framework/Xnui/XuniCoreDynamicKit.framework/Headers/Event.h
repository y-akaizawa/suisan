//
//  Event.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
*/
@class XuniPoint;

/**
*  任意の数のオブジェクトを持ち、1 つのオブジェクトを返す汎用の関数
*/
@protocol IXuniFunction

/**
*  関数を実行します。
*    @param args パラメータの配列
*    @return 汎用のオブジェクト
*/
- (NSObject *)execute:(NSArray *)args;

@end

/**
*  イベント引数の基本クラス
*/
@interface XuniEventArgs : NSObject

/**
*  イベントデータを持たないイベントで使用する値を提供します。
*    @return イベント引数を返します。
*/
+ (XuniEventArgs *)empty;
@end

/**
*  キャンセル可能なイベントの引数を提供します。
*/
@interface XuniCancelEventArgs : XuniEventArgs

/**
*  イベントをキャンセルするかどうかを示す値を取得または設定します。
*/
@property BOOL cancel;
@end

/**
*  キャンセル可能なイベントの引数を提供します。
*/
@interface XuniPointEventArgs : XuniCancelEventArgs

/**
*  イベントをキャンセルするかどうかを示す値を取得または設定します。
*/
@property XuniPoint *point;

/**
*  ポイントを指定して新しい XuniPointEventArgs を初期化します。
*    @param point イベントの XuniPoint
*/
- (id)initWithPoint:(XuniPoint *)point;

@end

/**
*  反変性/共変性をもつイベントハンドラブロックのパラメータをサポートするためのジェネリッククラス
*/
@interface XuniEventContainer<__covariant EventArgsType:XuniEventArgs *> : NSObject

/**
*  送信元のオブジェクトを取得します。
*/
@property (readonly, weak) NSObject* sender;

/**
*  イベント引数を取得します。
*/
@property (readonly) EventArgsType eventArgs;

/**
*  送信元のオブジェクトとイベント引数を指定して新しい XuniEventContainer を初期化します。
*    @param sender 送信元のオブジェクト
*    @param args イベント引数
*/
-(id) initWithSender:(NSObject*)sender andArgs:(EventArgsType)args;
@end

/**
*  イベントハンドラの基本クラス
*/
@interface XuniEventHandler<__covariant EventArgsType:XuniEventArgs *> : NSObject

/**
*  イベントハンドラを表します。
*    @param eventContainer イベントの送信元
*    @param eventContainer   引数
*/
typedef void(^IXuniEventHandler )(XuniEventContainer<EventArgsType>* eventContainer);

/**
*  イベントハンドラを取得または設定します。
*/
@property (nonatomic, copy) IXuniEventHandler handler;
/**
*  オブジェクト自身を取得または設定します。
*/
@property (weak) NSObject *this;
/**
*  XuniEventHandler オブジェクトを初期化します。
*    @param handler ハンドラ
*    @param this    this オブジェクト
*    @return XuniEventHandler オブジェクト
*/
- (id)initWithHandler:(IXuniEventHandler)handler forObject:(NSObject *)this;
@end

/**
*  イベントの基本クラス
*/
@interface XuniEvent<__covariant EventArgsType:XuniEventArgs *> : NSObject

/**
*  ハンドラの変更可能な配列を取得または設定します。
*/
@property NSMutableArray<XuniEventHandler<EventArgsType>* > *handlers;

/**
*  オブジェクトを指定してハンドラを追加します。
*    @param handler ハンドラ
*    @param this    this オブジェクト
*/
- (void)addHandler:(IXuniEventHandler)handler forObject:(NSObject *)this;

/**
*  オブジェクトを指定してハンドラを削除します。
*    @param handler ハンドラ
*    @param this    this オブジェクト
*/
- (void)removeHandler:(IXuniEventHandler)handler forObject:(NSObject *)this;

/**
*  オブジェクトを指定してハンドラを削除します。
*    @param this    this オブジェクト
*/
- (void)removeHandlersForObject:(NSObject *)this;

/**
*  すべてのハンドラを削除します。
*/
- (void)removeAllHandlers;

/**
*  引数を指定して送信元からイベントを発生させます
*    @param sender 送信元のオブジェクト
*    @param args   引数
*/
- (void)raise:(NSObject *)sender withArgs:(EventArgsType)args;
@end
