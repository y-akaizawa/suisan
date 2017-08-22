//
//  XuniAutoComplete.h
//  XuniInput
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "XuniComboBox.h"
#import "XuniAutoCompleteEnums.h"

/**
*/
@class XuniCollectionView;
/**
*/
@class XuniAutoCompleteDropdownView;
/**
*/
@class XuniAutoCompleteFilteringEventArgs;
/**
*/
@protocol XuniAutoCompleteDelegate;

/**
*/
@interface XuniAutoComplete : XuniComboBox

//@property (nonatomic, weak) id<XuniAutoCompleteDelegate> delegate;

/**
*/
@property (nonatomic) XuniAutoCompleteFilteringEventArgs *filteringArgs;

/**
*  tableView のカスタマイズしたセルを取得または設定します。
*/
@property (nonatomic) NSArray<UIView*> *customViews;

/**
*  一致したテキストの強調表示された背景色を取得または設定します。
*/
@property (nonatomic) IBInspectable UIColor *highlightedColor;

/**
*  テキストフィールド内の filterString を取得または設定します。
*/
@property (nonatomic) IBInspectable NSString *filterString;

/**
*  選択する項目を含む一時ソースコレクションを取得または設定します。
*/
@property (nonatomic) NSMutableArray *temporaryItemSource;

/**
*  リストのフィルタを取得または設定します。
*/
@property (nonatomic) XuniAutoCompleteOperator operatorType;

/**
*  入力が発生してから検索が実行されるまでの遅延時間（ミリ秒単位）を取得または設定します。
*/
@property (nonatomic) IBInspectable double delay;

/**
*  ドロップダウンリストに表示される項目の最大数を取得または設定します。
*/
@property (nonatomic) IBInspectable int maxItems;

/**
*  オートコンプリート候補を検索するために必要な入力の最小長さを取得または設定します。
*/
@property (nonatomic) IBInspectable int minLength;

/**
*  カスタムフィルタ処理かどうかを取得または設定します。
*/
@property (nonatomic) IBInspectable BOOL isCustomFiltering;

/**
*  tableView の itemSource をリフレッシュします。
*/
- (void)refreshTableViewItemSource;

/**
*  セルのテキストを正規化します。
*    @param textLabel テキストラベル
*    @param subString テキストラベルテキストの部分文字列
*/
-(void)normalizeCellText:(UILabel *)textLabel WithSubstring:(NSString *)subString;

/**
*  部分文字列を強調表示します。
*    @param subString テキストラベルテキストの部分文字列
*    @param textLabel テキストラベル
*/
- (void)highlightedSubstring:(NSString*)substring inFilterCellText:(UILabel *)textLabel;

@end
