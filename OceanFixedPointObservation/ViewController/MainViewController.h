//
//  MainViewController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/17.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
<UIGestureRecognizerDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView *bgBaseImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

//ページコントロール
@property (weak, nonatomic) IBOutlet UIView *pageView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
- (IBAction)pageControl:(id)sender;



//リンク
@property (weak, nonatomic) IBOutlet UIButton *linkBtn;
- (IBAction)linkBtn:(id)sender;

//設定画面ボタン
- (IBAction)settingBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;
//グラフ画面ボタン
- (IBAction)chartBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *chartBtn;
//表画面ボタン
- (IBAction)tableBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *tableBtn;
//日誌画面ボタン
- (IBAction)diaryBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *diaryBtn;
//チャット画面ボタン
- (IBAction)chatBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *chatBtn;



//現在時刻表示
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

-(void)goList:(int)pageCn;
@end
