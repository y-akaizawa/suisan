//
//  GridDetailProvider.h
//  FlexGrid
//
//  Copyright © 2016 C1Marketing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlexGrid.h"
#import "GridRow.h"

/**
*  FlexGrid 詳細セルの生成を処理するデリゲートクラス
*/
@protocol FlexGridDetailProviderDelegate<NSObject>
/**
*/
@optional

/**
*  詳細セルを作成する必要があるときに発生します。
*    @param sender 送信元 FlexGridDetailProvider オブジェクト
*    @param row 詳細ビューの作成対象として指定された行
*    @return セルの詳細を表す UIView。詳細がない場合は null
*/
- (UIView *)detailCellCreating:(FlexGridDetailProvider *)sender row:(GridRow *)row;

/**
*  詳細展開ボタンを作成する必要があるときに発生します。
*    @param sender 送信元 FlexGridDetailProvider オブジェクト
*    @param row 詳細展開ボタンの作成対象として指定された行
*    @param defaultButton デフォルトの詳細展開ボタン
*    @return グリッド行詳細展開ボタンを表す UIButton。ボタンがない場合は null
*/
- (UIButton *)gridRowHeaderLoading:(FlexGridDetailProvider *)sender row:(GridRow *)row defaultButton:(UIButton *)defaultButton;
@end


/**
*  FlexGridDetailProvider クラス
*/
@interface FlexGridDetailProvider : NSObject
/**
*  FlexGridDetailProvider に関連付けられた FlexGrid を取得します。
*/
@property (readonly) FlexGrid *grid;

/**
*  詳細プロバイダに関連付けられた FlexGridDetailProviderDelegate を取得または設定します。
*/
@property (nonatomic, weak) NSObject<FlexGridDetailProviderDelegate> *delegate;

/**
*  FlexGrid 詳細行の高さを取得または設定します。
*/
@property (nonatomic) CGFloat detailHeight;

/**
*  展開ボタンの動作を定義します。
*/
@property (nonatomic) bool showExpandButton;

/**
*  詳細の表示/非表示モードを取得または設定します。
*/
@property (nonatomic) GridDetailVisibilityMode detailVisibilityMode;

/**
*  詳細セルを作成する必要があるときに発生します。
*/
@property XuniEvent<GridDetailCellCreatingEventArgs*> *detailCellCreating;

/**
*  詳細展開ボタンを作成する必要があるときに発生します。
*/
@property XuniEvent<GridRowHeaderLoadingEventArgs*> *gridRowHeaderLoading;

/**
*  FlexGridDetailProvider オブジェクトを初期化します。
*    @param grid   指定された FlexGrid
*    @return FlexGridDetailProvider オブジェクト
*/
- (id)initWithGrid:(FlexGrid *)grid;

/**
*  行の詳細を表示します。
*    @param row 詳細を表示する行
*/
- (void)showDetail:(GridRow*)row;

/**
*  行の詳細を表示し、他のすべての行の詳細を非表示にします。
*    @param row 詳細を表示する行
*    @param hideOthers 他の行の詳細を非表示にするかどうか
*/
- (void)showDetail:(GridRow*)row hideOthers:(bool)hideOthers;

/**
*  行の詳細を非表示にします。
*    @param row 詳細を非表示にする行
*/
- (void)hideDetail:(GridRow*)row;
@end
