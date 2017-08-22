//
//  XuniDropDown.h
//  DropDown
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "XuniDropDownEnums.h"
#import "DropDownDelegate.h"

/**
*/
@class XuniEvent;
/**
*/
@class XuniDropDownButton;
/**
*/
@class XuniDropDownHeaderView;
/**
*/
@class XuniDropDownButton;
/**
*/
@class XuniDropDownView;
/**
*/
@class XuniDropDownOpenChangedEventArgs;

/**
*/
IB_DESIGNABLE
/**
*/
@interface XuniDropDown : UIView

/**
*  通知（テキストコメント）を処理するためのデリゲートを取得または設定します。
*/
@property (nonatomic, weak) id<XuniDropDownDelegate> delegate;

/**
*  Xamarin.Forms かどうかを取得または設定します。
*/
@property(nonatomic) BOOL isXf;

/**
*  ドロップダウンの背景ビューを取得または設定します。
*/
@property(nonatomic) UIView *dropDownBackView;

/**
*  このコントロールのヘッダーを取得または設定します。
*/
@property(nonatomic) UIView *header;

/**
*  このコントロールのヘッダーテキストを取得または設定します。
*/
@property(nonatomic) IBInspectable NSString *headerText;

/**
*  このコントロールの幅を取得または設定します。
*/
@property(nonatomic) double width;

/**
*  このコントロールの高さを取得または設定します。
*/
@property(nonatomic) double height;

/**
*  ドロップダウンするときの動作を取得または設定します。
*/
@property(nonatomic) XuniDropDownBehavior dropDownBehavior;

/**
*  ヘッダーの背景色を取得または設定します。
*/
@property(nonatomic) IBInspectable UIColor *headerBackgroundColor;

/**
*  ヘッダーの境界線の色を取得または設定します。
*/
@property(nonatomic) IBInspectable UIColor *headerBorderColor;

/**
*  ヘッダーの境界線の太さを取得または設定します。
*/
@property(nonatomic) IBInspectable double headerBorderWidth;

/**
*  ドロップダウンが現在表示されているかどうかを示す値を取得または設定します。
*/
@property(nonatomic) UIView *dropDownView;

/**
*  ドロップダウンボックスの高さを取得または設定します。
*/
@property(nonatomic) IBInspectable double dropDownHeight;

/**
*  ドロップダウンボックスの幅を取得または設定します。
*/
@property(nonatomic) IBInspectable double dropDownWidth;

/**
*  ドロップダウンの色を取得または設定します。
*/
@property(nonatomic) IBInspectable UIColor *dropDownBackgroundColor;

/**
*  ドロップダウン境界線の色を取得または設定します。
*/
@property(nonatomic) IBInspectable UIColor *dropDownBorderColor;

/**
*  ドロップダウンの境界線の幅を取得または設定します。
*/
@property(nonatomic) IBInspectable double dropDownBorderWidth;

/**
*  ユーザーがドロップダウンの外部をタップしたときにドロップダウンを自動的に閉じるかどうかを取得または設定します。
*/
@property(nonatomic) IBInspectable BOOL autoClose;

/**
*  ドロップダウンが現在表示されているかどうかを示す値を取得または設定します。
*/
@property(nonatomic) BOOL isDropDownOpen;

/**
*  コントロールがアニメーション表示されるかどうかを取得または設定します。
*/
@property(nonatomic) IBInspectable BOOL isAnimated;

/**
*  アニメーション期間を取得または設定します。
*/
@property(nonatomic) IBInspectable double duration;

/**
*  コントロールのドロップダウンボックスの展開方向を取得または設定します。
*/
@property(nonatomic) XuniDropDownDirection dropDownDirection;

/**
*  ドロップダウンボックスの最大長の制約を取得または設定します。
*/
@property(nonatomic) IBInspectable double maxDropDownHeight;

/**
*  ドロップダウンボックスの最小高さの制約を取得または設定します。
*/
@property(nonatomic) IBInspectable double minDropDownHeight;

//@property(nonatomic) double maxDropDownWidth;

//@property(nonatomic) double minDropDownWidth;


/**
*  このコントロールのドロップダウンボタンを取得または設定します。
*/
@property(nonatomic) XuniDropDownButton *button;

/**
*  コントロールにドロップダウンボタンを表示するかどうかを示す値を取得または設定します。
*/
@property(nonatomic) IBInspectable BOOL showButton;

/**
*  ボタンコンテンツの色を取得または設定します。
*/
@property(nonatomic) IBInspectable UIColor *buttonColor;

/**
*  IsDropDownOpen プロパティが変化したときに発生するイベントを取得または設定します。
*/
@property(nonatomic) XuniEvent *isDropDownOpenChanged;

/**
*  IsDropDownOpen プロパティが変化する前に発生するイベントを取得または設定します。
*/
@property(nonatomic) XuniEvent *isDropDownOpenChanging;

/**
*  ドロップダウンをリフレッシュします。
*/
- (void)refresh;

// Internal methods
/**
*  XuniDropDown のいくつかのプロパティを初期化します。
*/
- (void)initInternals;

/**
*  新しく割り当てられた XuniDropDown オブジェクトを、指定されたフレーム四角形で初期化して返します。
*    @param frame XuniDropDown のフレーム四角形領域（ポイント単位）
*    @return 初期化された XuniDropDown オブジェクト。オブジェクトを作成できなかった場合は nil。
*/
- (instancetype)initWithFrame:(CGRect)frame;
@end
