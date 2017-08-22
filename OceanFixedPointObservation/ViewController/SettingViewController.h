//
//  SettingViewController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/18.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>
@import XuniInputDynamicKit;

@interface SettingViewController : UIViewController
<UIScrollViewDelegate,UITextFieldDelegate,XuniComboBoxDelegate, XuniDropDownDelegate>
- (IBAction)backBtn:(id)sender;
//スクロール関連
@property (weak, nonatomic) IBOutlet UIScrollView *settingScrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollBaseView;

//受信メール情報
@property (weak, nonatomic) IBOutlet UIView *mailView;
@property (weak, nonatomic) IBOutlet UILabel *mailAdLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *mailSetBtn;
- (IBAction)mailSetBtn:(id)sender;

//アラーム関連
@property (weak, nonatomic) IBOutlet UIView *alarmBaseView;
@property (weak, nonatomic) IBOutlet UIView *alarmView1;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel1;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel1;
@property (weak, nonatomic) IBOutlet UILabel *countLabel1;
@property (weak, nonatomic) IBOutlet UISwitch *alarmSwitch1;
@property (weak, nonatomic) IBOutlet UIButton *alarmSettingBtn1;

@property (weak, nonatomic) IBOutlet UIView *alarmView2;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel2;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel2;
@property (weak, nonatomic) IBOutlet UILabel *countLabel2;
@property (weak, nonatomic) IBOutlet UISwitch *alarmSwitch2;
@property (weak, nonatomic) IBOutlet UIButton *alarmSettingBtn2;

@property (weak, nonatomic) IBOutlet UIView *alarmView3;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel3;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel3;
@property (weak, nonatomic) IBOutlet UILabel *countLabel3;
@property (weak, nonatomic) IBOutlet UISwitch *alarmSwitch3;
@property (weak, nonatomic) IBOutlet UIButton *alarmSettingBtn3;

//アラームボタン tagが上から 101 102 103
- (IBAction)alarmSettingBtnTap:(UIButton *)sender;
//アラームONOFFボタン tagが上から 11 12 13
- (IBAction)alarmSwitchChanged:(UISwitch *)sender;

//積算関連
@property (weak, nonatomic) IBOutlet UIView *sekisanBaseView;
@property (weak, nonatomic) IBOutlet UIView *sekisanView1;
@property (weak, nonatomic) IBOutlet UILabel *sPointLabel1;
@property (weak, nonatomic) IBOutlet UILabel *sTempLabel1;
@property (weak, nonatomic) IBOutlet UILabel *sCountLabel1;

@property (weak, nonatomic) IBOutlet UILabel *sPointLabel2;
@property (weak, nonatomic) IBOutlet UILabel *sTempLabel2;
@property (weak, nonatomic) IBOutlet UILabel *sCountLabel2;

@property (weak, nonatomic) IBOutlet UILabel *sPointLabel3;
@property (weak, nonatomic) IBOutlet UILabel *sTempLabel3;
@property (weak, nonatomic) IBOutlet UILabel *sCountLabel3;



//積算設定ボタン tagが上から21 22 23
- (IBAction)sekisanSettingBtn:(UIButton *)sender;

//ページ数変更
@property (weak, nonatomic) IBOutlet UILabel *pageCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *pageBtn;
- (IBAction)pageBtn:(id)sender;
//初期化ボタン
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
- (IBAction)deleteBtn:(id)sender;
//ニックネーム変更
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *userNameBtn;
- (IBAction)userNameBtn:(id)sender;
//ユーザー情報
@property (weak, nonatomic) IBOutlet UILabel *userIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;
//アプリ情報
@property (weak, nonatomic) IBOutlet UILabel *appVerLabel;
@property (weak, nonatomic) IBOutlet UIButton *dlBtn;
- (IBAction)dlBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *pdfSizeLabel;

//お問い合わせ
@property (weak, nonatomic) IBOutlet UIButton *infoBtn;
- (IBAction)infoBtn:(id)sender;

//ダイアログ
@property (weak, nonatomic) IBOutlet UIView *dialogBaseView;

@property (weak, nonatomic) IBOutlet UIView *dialogMainView;
@property (weak, nonatomic) IBOutlet UILabel *diaLogTitleLabel;
- (IBAction)okBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;

@property (weak, nonatomic) IBOutlet XuniComboBox *comboBoxPageCount;
@property (weak, nonatomic) IBOutlet UITextField *diaLogTextField;
@end
