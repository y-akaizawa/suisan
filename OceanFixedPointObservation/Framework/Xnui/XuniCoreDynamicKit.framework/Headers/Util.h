//
//  Util.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
*  データ型を定義する列挙型
*/
typedef NS_ENUM (NSInteger, XuniDataType){
/**
*  null 型
*/
    XuniDataTypeNull,
/**
*  オブジェクト型
*/
    XuniDataTypeObject,
/**
*  文字列型
*/
    XuniDataTypeString,
/**
*  数値型
*/
    XuniDataTypeNumber,
/**
*  Boolean型
*/
    XuniDataTypeBoolean,
/**
*  日付型
*/
    XuniDataTypeDate,
/**
*  配列型
*/
    XuniDataTypeArray
};

/**
*  IXuniQueryInterface プロトコル
*/
@protocol IXuniQueryInterface

/**
*  インタフェースを実装します。
*    @param interfaceName インタフェース名文字列
*    @return boolean 値
*/
- (BOOL)implementsInterface:(NSString *)interfaceName;
@end

/**
*  XuniPropertyInfo クラス
*/
@interface XuniPropertyInfo : NSObject
/**
*  @exclude
*/
@property (nonatomic) bool isReadOnly;
/**
*  @exclude
*/
@property (nonatomic) NSString *name;
/**
*  @exclude
*/
@property (nonatomic) XuniDataType dataType;

/**
*  XuniPropertyInfo オブジェクトを初期化します。
*    @param name 名前
*    @return XuniPropertyInfo オブジェクト
*/
- (id)initWithName:(NSString *)name;

/**
*  XuniPropertyInfo オブジェクトを初期化します。
*    @param name     名前
*    @param dataType データ型
*    @return XuniPropertyInfo オブジェクト
*/
- (id)initWithName:(NSString *)name dataType:(XuniDataType)dataType;

/**
*  XuniPropertyInfo オブジェクトを初期会します。
*    @param name     名称
*    @param dataType データ型
*    @param readOnly 読み込み専用の場合はtrue
*    @return XuniPropertyInfo オブジェクト
*/
- (id)initWithName:(NSString *)name dataType:(XuniDataType)dataType andReadOnly:(bool)readOnly;

/**
*  文字列の属性を解析します。
*    @param attr 解析する文字列
*/
- (void)parseAttributes:(NSString *)attr;
@end

/**
*  XuniReflector クラス
*/
@interface XuniReflector : NSObject

/**
*  キーを指定して値を取得します。
*    @param object オブジェクト
*    @param name   キー名
*    @return オブジェクト
*/
+ (NSObject *)getValue:(NSObject *)object forKey:(NSString *)name;

/**
*  データ型を取得します。
*    @param object オブジェクト
*    @return データ型
*/
+ (XuniDataType)getDataType:(NSObject *)object;

/**
*  プロパティを取得します。
*    @param object  オブジェクト
*    @return プロパティの配列
*/
+ (NSArray *)getProperties:(NSObject *)object;

/**
*  プロパティを取得します。
*    @param object  オブジェクト
*    @param name    キー名
*    @return XuniPropertyInfo オブジェクト
*/
+ (XuniPropertyInfo *)getProperty:(NSObject *)object name:(NSString *)name;

/**
*  値を書式設定します。
*    @param value 値
*    @return 書式設定された値の文字列
*/
+ (NSString *)formatValue:(NSObject *)value;

/**
*  シャローコピーを実行します。
*    @param target   ターゲットオブジェクト
*    @param value    ソースオブジェクト
*/
+ (void)shallowCopyTo:(NSObject *)target from:(NSObject *)value;
@end

/**
*  XuniBinding クラス
*/
@interface XuniBinding : NSObject

/**
*  パスを取得または設定します。
*/
@property (nonatomic) NSString *path;

/**
*  XuniBinding オブジェクトを初期化します。
*    @param path パス
*    @return XuniBinding オブジェクト
*/
- (id)initWithString:(NSString *)path;

/**
*  ターゲットのデータ型を取得します。
*    @param target ターゲット
*    @return データ型
*/
- (XuniDataType)getDataTypeForTarget:(NSObject *)target;

/**
*  ターゲットの値を取得します。
*    @param target ターゲット
*    @return ターゲットを返します。
*/
- (NSObject *)getValueForTarget:(NSObject *)target;

/**
*  ターゲットに値を設定します。
*    @param value  値
*    @param target ターゲット値
*/
- (void)setValue:(NSObject *)value forTarget:(NSObject *)target;
@end

/**
*  IXamarinXuniObject プロトコル
*/
@protocol IXamarinXuniObject <NSObject>

/**
*  プロパティ名を取得します。
*    @return プロパティ名の配列
*/
- (NSArray *)getPropertyNames;


/**
*  プロパティ値を取得します。
*    @param name   プロパティ名
*    @return オブジェクト
*/
- (NSObject *)getPropertyValue:(NSString *)name;

/**
*  プロパティ値を設定します。
*    @param name   プロパティ名
*    @param value  プロパティの新しい値
*/
- (void)setPropertyValue:(NSString *)name to:(NSObject *)value;


/**
*/
@optional

/**
*  プロパティのディスクリプトを取得します。
*    @return ディスクリプトの配列
*/
- (NSArray *)getPropertyDescriptors;


@end
