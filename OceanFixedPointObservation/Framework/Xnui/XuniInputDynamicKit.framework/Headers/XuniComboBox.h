//
//  XuniComboBox.h
//  XuniInput
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "XuniDropDown.h"

/**
*/
@protocol XuniComboBoxDelegate;
/**
*/
@class XuniCollectionView;

/**
*  XuniComboBox クラス
*/
IB_DESIGNABLE
/**
*/
@interface XuniComboBox : XuniDropDown

///**
// *  Gets or sets the delegate for handling notifications.
// */
//@property (nonatomic, weak) id<XuniComboBoxDelegate> delegate;

/**
*  選択する項目を含むソースコレクションを取得または設定します。
*/
@property (nonatomic) NSMutableArray *itemsSource;

/**
*  項目ソースとして使用する XuniCollectionView オブジェクトを取得または設定します。
*/
@property (nonatomic) XuniCollectionView *collectionView;

/**
*  コントロールが項目のリストを使用して自動的にエントリを補完するかどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL autoComplete;

/**
*  項目のビジュアル表現として使用するプロパティ名を取得または設定します。
*/
@property (nonatomic) IBInspectable NSString *displayMemberPath;

/**
*  コントロールのテキストの編集を有効にするか無効にするかを示す値を取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL isEditable;

/**
*  コントロールが空のときにヒントとして表示される文字列を取得または設定します。
*/
@property (nonatomic) IBInspectable NSString *placeholder;

/**
*  選択された背景色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *selectedBackgroundColor;

/**
*  選択項目のインデックスを取得または設定します。
*    選択項目がない場合、または選択項目がソースコレクションの項目と一致しない場合は、-1 を返します。
*/
@property (nonatomic) NSUInteger selectedIndex;

/**
*  現在の選択項目を取得または設定します。
*/
@property (nonatomic) NSObject *selectedItem;

/**
*  SelectedValuePath を使用して、現在の選択項目の値を取得または設定します。
*/
@property (nonatomic) NSObject *selectedValue;

/**
*  選択項目から値を取得するために使用されるパスを取得または設定します。
*/
@property (nonatomic) IBInspectable NSString *selectedValuePath;

/**
*  コントロールのテキストを取得または設定します。
*/
@property (nonatomic) IBInspectable NSString *text;

/**
*  ドロップダウンテーブルビューを取得または設定します。
*/
@property (nonatomic, readonly) UITableView *tableView;

@property (nonatomic) UIColor *textColor;

@property (nonatomic) UIFont *textFont;

@property(nonatomic) NSTextAlignment textAlignment;

/**
*  selectedIndex の値が変化すると発生します。
*/
@property XuniEvent *selectedIndexChanged;

/**
*  テキスト値が変更されたときに発生します。
*/
@property XuniEvent *textChanged;

/**
*  ドロップダウン項目がロードされるときに発生します。
*/
@property XuniEvent *dropDownItemLoading;

/**
*  指定されたインデックスにある項目の表示テキストを取得します。
*    @param index 項目のインデックス
*    @return 表示テキスト
*/
- (NSString *)getDisplayText:(NSUInteger)index;

/**
*  指定された文字列と一致する最初の項目のインデックスを取得します。
*    @param text      指定された文字列
*    @param fullMatch 検索時に完全一致が必要かどうか
*/
- (NSUInteger)indexOf:(NSString *)text fullMatch:(BOOL)fullMatch;

/**
*  コントロールにフォーカスを設定し、そのすべてのコンテンツを選択します。
*/
- (void)selectAll;

- (UIFontDescriptor*)getDescriptor:(NSMutableDictionary*)attributes;

@end
