//
//  GridCellFactory.h
//  FlexGrid
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GridPanel.h"
#import "GridCellRange.h"

/**
*  GridCellFactory クラス
*/
@interface GridCellFactory : NSObject

/**
*  パラメータを指定してセルを更新します。
*    @param panel   グリッドパネル
*    @param r       行
*    @param c       列
*    @param context コンテキスト
*    @param rng     範囲
*/
- (void)updateCell:(GridPanel *)panel row:(int)r column:(int)c context:(CGContextRef)context range:(GridCellRange *)rng;

/**
*  カスタムセルエディタを作成します。
*    @param panel   グリッドパネル
*    @param rng     範囲
*/
- (UIView *)createCellEditor:(GridPanel *)panel range:(GridCellRange *)rng;

@end
