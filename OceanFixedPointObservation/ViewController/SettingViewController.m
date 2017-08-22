//
//  SettingViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/18.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import "SettingViewController.h"
#import "MailSettingViewController.h"
#import "AlarmSettingViewController.h"
#import "SekisanSettingViewController.h"
#import "DiaryData.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
MailSettingViewController *mailSettingViewController;
AlarmSettingViewController *alarmSettingViewController;
SekisanSettingViewController *sekisanSettingViewController;

NSString *userId;
NSString *pageCount;

NSMutableArray *settingAry;//ユーザーIDに紐づくデータを格納
NSMutableDictionary *settingDic;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dialogBaseView.hidden = YES;
    self.comboBoxPageCount.delegate = self;
    self.comboBoxPageCount.backgroundColor = [UIColor whiteColor];
    self.comboBoxPageCount.displayMemberPath = @"name";
    self.comboBoxPageCount.itemsSource = [DiaryData page];
    self.comboBoxPageCount.isEditable = NO;
    self.comboBoxPageCount.isAnimated = YES;
    self.comboBoxPageCount.dropDownBehavior = XuniDropDownBehaviorButtonTap;
    self.comboBoxPageCount.dropDownHeight = 200;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.settingScrollView.contentSize = CGSizeMake(self.scrollBaseView.frame.size.width, self.scrollBaseView.frame.size.height);
    self.settingScrollView.delegate = self;
    [Common showSVProgressHUD:@""];
    //最新の情報を表示するため中身がある場合削除する
    if (settingAry.count > 0) {
        [settingAry removeAllObjects];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDataDic = [ud objectForKey:@"UserData_Key"];
    pageCount = [userDataDic objectForKey:@"PageCount"];
    self.pageCountLabel.text = pageCount;
    
    if ([[userDataDic objectForKey:@"UserId"]  isEqual: @"0"]) {
        self.mailAdLabel.text = @"未設定";
        self.timeLabel.text = @"未設定";
        self.alarmBaseView.hidden = YES;
        self.sekisanBaseView.hidden = YES;
        [Common dismissSVProgressHUD];
    }else{
        userId = [userDataDic objectForKey:@"UserId"];
        self.alarmBaseView.hidden = NO;
        self.sekisanBaseView.hidden = NO;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            settingAry = [PHPConnection getSettingTopData];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (settingAry.count > 0) {
                    settingDic = [settingAry objectAtIndex:0];
                    if([settingDic objectForKey:@"MAILADDR"] == [NSNull null] || [[settingDic objectForKey:@"MAILADDR"]  isEqual: @""]){
                        self.mailAdLabel.text = @"未設定";
                    }else{
                        self.mailAdLabel.text = [settingDic objectForKey:@"MAILADDR"];
                    }
                    if ([settingDic objectForKey:@"REFUSEMAILFROM"] == [NSNull null] || [[settingDic objectForKey:@"REFUSEMAILFROM"]  isEqual: @""]) {
                        self.timeLabel.text = @"未設定";
                    }else{
                        self.timeLabel.text = [NSString stringWithFormat:@"%@:%@ 〜 %@:%@",
                                               [[settingDic objectForKey:@"REFUSEMAILFROM"] substringWithRange:NSMakeRange(0, 2)],
                                               [[settingDic objectForKey:@"REFUSEMAILFROM"] substringWithRange:NSMakeRange(2, 2)],
                                               [[settingDic objectForKey:@"REFUSEMAILTO"] substringWithRange:NSMakeRange(0, 2)],
                                               [[settingDic objectForKey:@"REFUSEMAILTO"] substringWithRange:NSMakeRange(2, 2)]];
                    }
                }
//                NSLog(@"settingAry = %@",settingAry);
                //アラーム設定1
                if ([settingDic objectForKey:@"ARM1AREANM"] == [NSNull null] || settingAry.count == 0) {
                    self.alarmSwitch1.on = NO;
                    self.alarmSwitch1.enabled = NO;
                    self.pointLabel1.text = @"未設定";
                    self.tempLabel1.text = @"未設定";
                    self.countLabel1.text = @"未設定";
                }else{
                    if ([[settingDic objectForKey:@"ARM1SWITCH"]  isEqual: @"1"] ) {
                        self.alarmSwitch1.on = YES;
                        self.alarmSwitch1.enabled = YES;
                    }else{
                        self.alarmSwitch1.on = NO;
                    }
                    self.pointLabel1.text = [NSString stringWithFormat:@"%@ %@ %@",
                                             [settingDic objectForKey:@"ARM1AREANM"],
                                             [settingDic objectForKey:@"ARM1DATATYPE"],
                                             [settingDic objectForKey:@"ARM1POINT"]];
                    
                    self.tempLabel1.text = [NSString stringWithFormat:@"%@%@ 〜 %@%@",
                                            [settingDic objectForKey:@"ARM1VALFROM"],
                                            [settingDic objectForKey:@"ARM1UNIT"],
                                            [settingDic objectForKey:@"ARM1VALTO"],
                                            [settingDic objectForKey:@"ARM1UNIT"]];
                    
                    self.countLabel1.text = [NSString stringWithFormat:@"連続%@回記録した場合にメールを受信する",[settingDic objectForKey:@"ARM1TIMES"]];
                }
                
                //アラーム設定2
                if ([settingDic objectForKey:@"ARM2AREANM"] == [NSNull null] || settingAry.count == 0) {
                    self.alarmSwitch2.on = NO;
                    self.alarmSwitch2.enabled = NO;
                    self.pointLabel2.text = @"未設定";
                    self.tempLabel2.text = @"未設定";
                    self.countLabel2.text = @"未設定";
                }else{
                    if ([[settingDic objectForKey:@"ARM2SWITCH"]  isEqual: @"1"] ) {
                        self.alarmSwitch2.on = YES;
                        self.alarmSwitch2.enabled = YES;
                    }else{
                        self.alarmSwitch2.on = NO;
                    }
                    self.pointLabel2.text = [NSString stringWithFormat:@"%@ %@ %@",
                                             [settingDic objectForKey:@"ARM2AREANM"],
                                             [settingDic objectForKey:@"ARM2DATATYPE"],
                                             [settingDic objectForKey:@"ARM2POINT"]];
                    
                    self.tempLabel2.text = [NSString stringWithFormat:@"%@%@ 〜 %@%@",
                                            [settingDic objectForKey:@"ARM2VALFROM"],
                                            [settingDic objectForKey:@"ARM2UNIT"],
                                            [settingDic objectForKey:@"ARM2VALTO"],
                                            [settingDic objectForKey:@"ARM2UNIT"]];
                    
                    self.countLabel2.text = [NSString stringWithFormat:@"連続%@回記録した場合にメールを受信する",[settingDic objectForKey:@"ARM2TIMES"]];
                }
                
                //アラーム設定3
                if ([settingDic objectForKey:@"ARM3AREANM"] == [NSNull null] || settingAry.count == 0) {
                    self.alarmSwitch3.on = NO;
                    self.alarmSwitch3.enabled = NO;
                    self.pointLabel3.text = @"未設定";
                    self.tempLabel3.text = @"未設定";
                    self.countLabel3.text = @"未設定";
                }else{
                    if ([[settingDic objectForKey:@"ARM3SWITCH"]  isEqual: @"1"] ) {
                        self.alarmSwitch3.on = YES;
                        self.alarmSwitch3.enabled = YES;
                    }else{
                        self.alarmSwitch3.on = NO;
                    }
                    self.pointLabel3.text = [NSString stringWithFormat:@"%@ %@ %@",
                                             [settingDic objectForKey:@"ARM3AREANM"],
                                             [settingDic objectForKey:@"ARM3DATATYPE"],
                                             [settingDic objectForKey:@"ARM3POINT"]];
                    
                    self.tempLabel3.text = [NSString stringWithFormat:@"%@%@ 〜 %@%@",
                                            [settingDic objectForKey:@"ARM3VALFROM"],
                                            [settingDic objectForKey:@"ARM3UNIT"],
                                            [settingDic objectForKey:@"ARM3VALTO"],
                                            [settingDic objectForKey:@"ARM3UNIT"]];
                    
                    self.countLabel3.text = [NSString stringWithFormat:@"連続%@回記録した場合にメールを受信する",[settingDic objectForKey:@"ARM3TIMES"]];
                }
                
                
                //積算設定1
                if ([settingDic objectForKey:@"INTEGVAL1AREANM"] == [NSNull null] || settingAry.count == 0) {
                    self.sPointLabel1.text = @"未設定";
                    self.sTempLabel1.text = @"未設定";
                    self.sCountLabel1.text = @"未設定";
                }else{
                    self.sPointLabel1.text = [NSString stringWithFormat:@"%@ %@ %@",
                                              [settingDic objectForKey:@"INTEGVAL1AREANM"],
                                              [settingDic objectForKey:@"INTEGVAL1DATATYPE"],
                                              [settingDic objectForKey:@"INTEGVAL1POINT"]];
                    
                    self.sTempLabel1.text = [NSString stringWithFormat:@"積算期間\n%@年%@月%@日 〜\n%@年%@月%@日",
                                             [[settingDic objectForKey:@"INTEGVAL1DATEFROM"]substringWithRange:NSMakeRange(0, 4)],
                                             [[settingDic objectForKey:@"INTEGVAL1DATEFROM"]substringWithRange:NSMakeRange(4, 2)],
                                             [[settingDic objectForKey:@"INTEGVAL1DATEFROM"]substringWithRange:NSMakeRange(6, 2)],
                                             [[settingDic objectForKey:@"INTEGVAL1DATETO"]substringWithRange:NSMakeRange(0, 4)],
                                             [[settingDic objectForKey:@"INTEGVAL1DATETO"]substringWithRange:NSMakeRange(4, 2)],
                                             [[settingDic objectForKey:@"INTEGVAL1DATETO"]substringWithRange:NSMakeRange(6, 2)]];
                    
                    self.sCountLabel1.text = [NSString stringWithFormat:@"積算基準値 %@%@\n積算目安値 %@%@",[settingDic objectForKey:@"INTEGVAL1BASE"],[settingDic objectForKey:@"INTEGVAL1UNIT"],[settingDic objectForKey:@"INTEGVAL1STD"],[settingDic objectForKey:@"INTEGVAL1UNIT"]];
                }
                
                //積算設定2
                if ([settingDic objectForKey:@"INTEGVAL2AREANM"] == [NSNull null] || settingAry.count == 0) {
                    self.sPointLabel2.text = @"未設定";
                    self.sTempLabel2.text = @"未設定";
                    self.sCountLabel2.text = @"未設定";
                }else{
                    self.sPointLabel2.text = [NSString stringWithFormat:@"%@ %@ %@",
                                              [settingDic objectForKey:@"INTEGVAL2AREANM"],
                                              [settingDic objectForKey:@"INTEGVAL2DATATYPE"],
                                              [settingDic objectForKey:@"INTEGVAL2POINT"]];
                    
                    self.sTempLabel2.text = [NSString stringWithFormat:@"積算期間\n%@年%@月%@日 〜\n%@年%@月%@日",
                                             [[settingDic objectForKey:@"INTEGVAL2DATEFROM"]substringWithRange:NSMakeRange(0, 4)],
                                             [[settingDic objectForKey:@"INTEGVAL2DATEFROM"]substringWithRange:NSMakeRange(4, 2)],
                                             [[settingDic objectForKey:@"INTEGVAL2DATEFROM"]substringWithRange:NSMakeRange(6, 2)],
                                             [[settingDic objectForKey:@"INTEGVAL2DATETO"]substringWithRange:NSMakeRange(0, 4)],
                                             [[settingDic objectForKey:@"INTEGVAL2DATETO"]substringWithRange:NSMakeRange(4, 2)],
                                             [[settingDic objectForKey:@"INTEGVAL2DATETO"]substringWithRange:NSMakeRange(6, 2)]];
                    
                    self.sCountLabel2.text = [NSString stringWithFormat:@"積算基準値 %@%@\n積算目安値 %@%@",[settingDic objectForKey:@"INTEGVAL2BASE"],[settingDic objectForKey:@"INTEGVAL2UNIT"],[settingDic objectForKey:@"INTEGVAL2STD"],[settingDic objectForKey:@"INTEGVAL2UNIT"]];
                }
                
                //積算設定3
                if ([settingDic objectForKey:@"INTEGVAL3AREANM"] == [NSNull null] || settingAry.count == 0) {
                    self.sPointLabel3.text = @"未設定";
                    self.sTempLabel3.text = @"未設定";
                    self.sCountLabel3.text = @"未設定";
                }else{
                    self.sPointLabel3.text = [NSString stringWithFormat:@"%@ %@ %@",
                                              [settingDic objectForKey:@"INTEGVAL3AREANM"],
                                              [settingDic objectForKey:@"INTEGVAL3DATATYPE"],
                                              [settingDic objectForKey:@"INTEGVAL3POINT"]];
                    
                    self.sTempLabel3.text = [NSString stringWithFormat:@"積算期間\n%@年%@月%@日 〜\n%@年%@月%@日",
                                             [[settingDic objectForKey:@"INTEGVAL3DATEFROM"]substringWithRange:NSMakeRange(0, 4)],
                                             [[settingDic objectForKey:@"INTEGVAL3DATEFROM"]substringWithRange:NSMakeRange(4, 2)],
                                             [[settingDic objectForKey:@"INTEGVAL3DATEFROM"]substringWithRange:NSMakeRange(6, 2)],
                                             [[settingDic objectForKey:@"INTEGVAL3DATETO"]substringWithRange:NSMakeRange(0, 4)],
                                             [[settingDic objectForKey:@"INTEGVAL3DATETO"]substringWithRange:NSMakeRange(4, 2)],
                                             [[settingDic objectForKey:@"INTEGVAL3DATETO"]substringWithRange:NSMakeRange(6, 2)]];
                    
                    self.sCountLabel3.text = [NSString stringWithFormat:@"積算基準値 %@%@\n積算目安値 %@%@",
                                              [settingDic objectForKey:@"INTEGVAL3BASE"],
                                              [settingDic objectForKey:@"INTEGVAL3UNIT"],
                                              [settingDic objectForKey:@"INTEGVAL3STD"],
                                              [settingDic objectForKey:@"INTEGVAL3UNIT"]];
                }
                
                self.userNameLabel.text = [NSString stringWithFormat:@"%@",[settingDic objectForKey:@"USERNAME"]];
                self.userNameLabel.adjustsFontSizeToFitWidth = YES;
                self.userNameLabel.minimumScaleFactor = 5.f/30.f;
                self.userIdLabel.text = [NSString stringWithFormat:@"%@",[userDataDic objectForKey:@"UserId"]];
                self.groupIdLabel.text = [NSString stringWithFormat:@"%@",[userDataDic objectForKey:@"GroupId"]];
                self.groupNameLabel.text = [NSString stringWithFormat:@"%@",[settingDic objectForKey:@"GROUPNAME"]];
                
                
                self.appVerLabel.text = [NSString stringWithFormat:@"アプリバージョン　%@",[[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"]];
                [self.dlBtn setTitle:[NSString stringWithFormat:@"操作説明書Ver%@ダウンロード",[settingDic objectForKey:@"MANUALVER"]] forState:UIControlStateNormal];
                self.pdfSizeLabel.text = [NSString stringWithFormat:@"(PDFファイル ファイルサイズ%@)",[settingDic objectForKey:@"MANUALFILESIZE"]];
                
                [Common dismissSVProgressHUD];
            });
        });
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)mailSetBtn:(id)sender {
    mailSettingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MailSettingViewController"];
    mailSettingViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    if (settingAry.count == 0) {
    }else{
        NSMutableDictionary *settingDic = [settingAry objectAtIndex:0];
        //時間設定及びメールアドレスが設定済みならその情報を送る。
        if ([settingDic objectForKey:@"MAILADDR"] == [NSNull null]) {
        }else{
            mailSettingViewController.mailaddrStr = [settingDic objectForKey:@"MAILADDR"];
            if ([settingDic objectForKey:@"REFUSEMAILFROM"] == [NSNull null]) {
            }else{
                mailSettingViewController.timeStr1 = [NSString stringWithFormat:@"%@",[[settingDic objectForKey:@"REFUSEMAILFROM"] substringWithRange:NSMakeRange(0, 2)]];
                mailSettingViewController.timeStr2 = [NSString stringWithFormat:@"%@",[[settingDic objectForKey:@"REFUSEMAILFROM"] substringWithRange:NSMakeRange(2, 2)]];
                mailSettingViewController.timeStr3 = [NSString stringWithFormat:@"%@",[[settingDic objectForKey:@"REFUSEMAILTO"] substringWithRange:NSMakeRange(0, 2)]];
                mailSettingViewController.timeStr4 = [NSString stringWithFormat:@"%@",[[settingDic objectForKey:@"REFUSEMAILTO"] substringWithRange:NSMakeRange(2, 2)]];
            }
        }
    }
    [self presentViewController:mailSettingViewController animated:YES completion:nil];
}
//アラームボタン tagが上から 101 102 103
- (IBAction)alarmSettingBtnTap:(UIButton *)sender {
    if ([self.mailAdLabel.text  isEqual: @"未設定"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"確認" message:@"この機能にはメールアドレスの登録が必要となります。\n受信メール情報からメールアドレスを設定してください。" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // cancelボタンが押された時の処理
            [self cancelButtonPushed];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        alarmSettingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AlarmSettingViewController"];
        alarmSettingViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        if (sender.tag == 101) {
            alarmSettingViewController.alarmCountStr = @"1";
        }
        if (sender.tag == 102) {
            alarmSettingViewController.alarmCountStr = @"2";
        }
        if (sender.tag == 103) {
            alarmSettingViewController.alarmCountStr = @"3";
        }
        alarmSettingViewController.alarmAry = settingAry;
        [self presentViewController:alarmSettingViewController animated:YES completion:nil];
    }
}

//アラームONOFFボタン tagが上から 11 12 13
- (IBAction)alarmSwitchChanged:(UISwitch *)sender {
    NSString *alarmSwitchNo = @"";
    if (sender.tag == 11) {
        alarmSwitchNo = @"1";
    }
    if (sender.tag == 12) {
        alarmSwitchNo = @"2";
    }
    if (sender.tag == 13) {
        alarmSwitchNo = @"3";
    }
    NSString *alarmSwitchOn = @"";
    if (sender.on == YES) {
        alarmSwitchOn = @"1";
    }else{
        alarmSwitchOn = @"2";
    }
    NSDictionary *updAlarmSwitch = [PHPConnection updAlarmSwitch:alarmSwitchNo status:alarmSwitchOn];
    NSLog(@"updAlarmSwitch = %@",updAlarmSwitch);
}
//積算設定ボタン tagが上から21 22 23
- (IBAction)sekisanSettingBtn:(UIButton *)sender {
    sekisanSettingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SekisanSettingViewController"];
    sekisanSettingViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    if (sender.tag == 21) {
        sekisanSettingViewController.sekisanCountStr = @"1";
    }
    if (sender.tag == 22) {
        sekisanSettingViewController.sekisanCountStr = @"2";
    }
    if (sender.tag == 23) {
        sekisanSettingViewController.sekisanCountStr = @"3";
    }
    sekisanSettingViewController.sekisanAry = settingAry;
    [self presentViewController:sekisanSettingViewController animated:YES completion:nil];
}

- (void)cancelButtonPushed{
    
}
- (IBAction)pageBtn:(id)sender {
    self.comboBoxPageCount.text = pageCount;
    self.dialogBaseView.hidden = NO;
    self.diaLogTextField.hidden = YES;
    self.comboBoxPageCount.hidden = NO;
}
- (IBAction)deleteBtn:(id)sender {
    
}
- (IBAction)userNameBtn:(id)sender {
    self.diaLogTextField.text = self.userNameLabel.text;
    self.dialogBaseView.hidden = NO;
    self.diaLogTextField.hidden = NO;
    self.comboBoxPageCount.hidden = YES;
}
- (IBAction)dlBtn:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[settingDic objectForKey:@"MANUALURL"]]];
}
- (IBAction)infoBtn:(id)sender {
    //お問い合わせURLへ
    if ([settingDic objectForKey:@"INQUIRYURL"] == [NSNull null] || [[settingDic objectForKey:@"INQUIRYURL"]  isEqual: @""]) {
        //お問い合わせURLがない場合
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[settingDic objectForKey:@"INQUIRYURL"]]];
    }
    
}
//テキストフィールドデリゲート
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%@",textField.text);
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.diaLogTextField resignFirstResponder];
}
- (IBAction)okBtn:(id)sender {
    if (self.diaLogTextField.hidden == YES && self.comboBoxPageCount.hidden == NO) {
        pageCount = [NSString stringWithFormat:@"%@",self.comboBoxPageCount.text];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *userDataDic = [[ud objectForKey:@"UserData_Key"] mutableCopy];
        [userDataDic setObject:[NSString stringWithFormat:@"%@",pageCount] forKey:@"PageCount"];
        [ud setObject:userDataDic forKey:@"UserData_Key"];
        [ud synchronize];
        self.pageCountLabel.text = pageCount;
        self.dialogBaseView.hidden = YES;
    }
    if (self.diaLogTextField.hidden == NO && self.comboBoxPageCount.hidden == YES) {
        //ニックネーム変更
        NSDictionary *userNameDic = [PHPConnection updNickname:self.diaLogTextField.text];
        if ([Common checkErrorMessage:userNameDic] == YES) {
            NSLog(@"is_exists = %@",@"YES");
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エラー" message:[NSString stringWithFormat:@"%@",[userNameDic objectForKey:@"ERRORMESSAGE"]] preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                // cancelボタンが押された時の処理
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            NSLog(@"is_exists = %@",@"NO");
            self.userNameLabel.text = self.diaLogTextField.text;
            [self.diaLogTextField resignFirstResponder];
            self.dialogBaseView.hidden = YES;
        }
        
    }
    
}

- (IBAction)cancelBtn:(id)sender {
    [self.diaLogTextField resignFirstResponder];
    self.dialogBaseView.hidden = YES;
}
@end
