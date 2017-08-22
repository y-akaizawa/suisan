//
//  Common.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/22.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject
//戻れる最大
extern NSString *const maxBackCount;
//画面サイズ取得
+(CGRect)getScreenSize;
//1 = 5s,SE  2=6s,7s 3=6Plus,7Plus
+(int)getScreenSizeInt;
//ビューの中央座標取得　argView=中央に置きたいビュー argParentView=元になるビュー
+(CGRect)getCenterFrameWithView:(UIView*)argView parent:(UIView*)argParentView;
//現在の時間取得yyyyMMddHHmmss
+(NSString *)getTimeStringS;
//現在の時間取得yyyyMMddHH
+(NSString *)getTimeString;
//現在の13日前時間取得yyyyMMddHH
+(NSString *)getMinus14TimeString:(NSString *)dateStr;
//現在の13日後時間取得yyyyMMddHH
+(NSString *)getPlus14TimeString:(NSString *)dateStr;
//渡した日付に＋1日する※グラフに追加データを入れる際のずれの対策
+(NSString *)getPlus1TimeString:(NSString *)dateStr;
//カレンダーの最小値取得
+(NSDate *)minTimeString;
//
-(BOOL)getMaxBackCountFlag:(NSString *)dateStr;


/**
 *  ラベルの高さを取得と文字サイズに合わせる
 *  @param UILabel,合わせたい文字,表示したい幅,余白
 *  @return　UILabel
 */
//ラベル高さ計算用(ラベルと表示させるテキスト、ラベルの幅を渡す)
+ (UILabel *)getLabelSize:(UILabel *)label
                     text:(NSString *)text
               labelWidth:(float)labelWidth
                   margin:(float)margin;

+ (UILabel *)getMoziSizeSetting:(UILabel *)label;

//ロード画面表示
/**
 *  インジケーター表示
 *  @param message 空白の場合デフォルトの文章となる
 */
+ (void)showSVProgressHUD:(NSString *)message;
//インジケーター削除
+ (void)dismissSVProgressHUD;

//ユーザーID生成
+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length;

// 正規表現を利用、メールアドレスのフォーマットチェック
+(BOOL)isValidateEmail:(NSString *)email;

//チャート軸
+(double)chartMax:(double)max min:(double)min;
+(double)chartMin:(double)max min:(double)min;

//一部角丸 direction 1=上 2=下 3=上下 4=解除
+(UIView *)viewRoundedRect:(UIView *)view direction:(int)direction;

//ユーザー情報取得
+(NSString *)getUserID;
+(NSString *)getGroupID;

//エラーメッセージがあるかどうかのチェック
+(BOOL)checkErrorMessage:(NSDictionary *)dic;


@end
