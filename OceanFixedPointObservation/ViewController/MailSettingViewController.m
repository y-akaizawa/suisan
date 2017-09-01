//
//  MailSettingViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/04/13.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import "MailSettingViewController.h"

@interface MailSettingViewController ()

@end

@implementation MailSettingViewController
{
    NSMutableArray *timeAry;
    NSMutableArray *timeAry2;
    NSMutableArray *timeAry3;
    NSMutableArray *timeAry4;
    NSString *userId;
    BOOL addrSetBOOL;//YES = アドレスすでに追加済み
    BOOL mailSwBOOL;//YES = 時間設定可能
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timeSetLabel.layer.borderWidth = 1.0f;
    self.timeSetLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.timeSetLabel.layer.cornerRadius = 5.0f;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDataDic = [ud objectForKey:@"UserData_Key"];
    if ([[userDataDic objectForKey:@"UserId"]  isEqual: @""]) {
    }else{
        userId = [userDataDic objectForKey:@"UserId"];
    }    self.emailTextField.placeholder = @"メールアドレスを入力してください。";
    if (self.mailaddrStr.length > 0) {
        addrSetBOOL = YES;
        self.emailTextField.text = self.mailaddrStr;
        if (self.timeStr1 == nil  || [self.timeStr1 isEqual: @"nu"]) {
            mailSwBOOL = NO;
            [self switchSet:mailSwBOOL];
            self.timeStr1 = @"00";
            self.timeStr2 = @"00";
            self.timeStr3 = @"00";
            self.timeStr4 = @"00";
        }else{
            mailSwBOOL = YES;
            [self switchSet:mailSwBOOL];
            self.timeSetLabel.text = [NSString stringWithFormat:@" %@ 時 %@ 分 〜 %@ 時 %@ 分",self.timeStr1,self.timeStr2,self.timeStr3,self.timeStr4];
        }
    }else{
        mailSwBOOL = NO;
        [self switchSet:mailSwBOOL];
        addrSetBOOL = NO;
        self.timeStr1 = @"00";
        self.timeStr2 = @"00";
        self.timeStr3 = @"00";
        self.timeStr4 = @"00";
    }
    self.emailLabel.text = @"アラーム機能のメール受信に使用致します。\n予め「suisaniot.net」ドメインからのメールを受信可能にしてください。";
    self.emailLabel2.text = @"アラーム条件を満たしても以下の時間帯は受信いたしません。\nなお、受信拒否時間中にアラーム条件を満たした場合は、受信拒否時間帯外でメールを受信します。";
    self.emailTextField.delegate = self;
    
    CGRect rect = [Common getScreenSize];
    self.pickerBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, rect.size.height, rect.size.width, 200)];
    self.pickerBaseView.layer.borderWidth = 2.0f;
    self.pickerBaseView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.pickerBaseView.backgroundColor = [UIColor whiteColor];
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, rect.size.width, 156)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.pickerBaseView addSubview:self.pickerView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(4,4,100, 40);
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [[UIColor blackColor] CGColor];
    button.layer.cornerRadius = 5.0f;
    [button setTitle:@"決定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(okBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerBaseView addSubview:button];
    
    self.pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 4, 250, 40)];
    //self.pickerLabel.text = [NSString stringWithFormat:@" 00 時 00 分 〜 00 時 00 分"];
    self.pickerLabel.text = [NSString stringWithFormat:@" %@ 時 %@ 分 〜 %@ 時 %@ 分",self.timeStr1,self.timeStr2,self.timeStr3,self.timeStr4];
    [self.pickerBaseView addSubview:self.pickerLabel];
    
    timeAry  = [[NSMutableArray alloc] initWithCapacity:0];
    timeAry2 = [[NSMutableArray alloc] initWithCapacity:0];
    timeAry3 = [[NSMutableArray alloc] initWithCapacity:0];
    timeAry4 = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self.view addSubview:self.pickerBaseView];
    
    for (int i = 0; i < 24; i++) {
        if (i < 10) {
            [timeAry addObject:[NSString stringWithFormat:@"0%d",i]];
            [timeAry3 addObject:[NSString stringWithFormat:@"0%d",i]];
        }else{
            [timeAry addObject:[NSString stringWithFormat:@"%d",i]];
            [timeAry3 addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    timeAry2 = [NSMutableArray arrayWithObjects:@"00",@"10",@"20",@"30",@"40",@"50", nil];
    timeAry4 = [NSMutableArray arrayWithObjects:@"00",@"10",@"20",@"30",@"40",@"50", nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (self.mailaddrStr.length > 0) {
    }else{
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:@"同意事項\n"
                                            message:@"受信メール情報を登録することで各種拡張機能が使用可能になります。\n\n・アラーム機能\n\n測定値が一定の条件を記録した場合に、指定メールアドレスにアラームメールを受信します。\n就寝中、仕事中など、メール受信したくない時間帯がある場合は、「メール拒否時間帯」を指定することができます。\n\n・積算値表示機能\n\nトップページに統計値の積算値を表示することができます。\n積算期間、基準値、目安値が設定可能で、グラフ表示されますので一目で積算状況が確認できます。"
                                     preferredStyle:UIAlertControllerStyleAlert];
        alertController.view.tag = 3;
        // addActionした順に左から右にボタンが配置されます
        [alertController addAction:[UIAlertAction actionWithTitle:@"同意する" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // otherボタンが押された時の処理
            [self other:alertController];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"同意しない" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // cancelボタンが押された時の処理
            [self cancel:alertController];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)switchSet:(BOOL)swOnOff{
    if (swOnOff == YES) {
        mailSwBOOL = YES;
        self.emailSwitch.on = YES;
        self.timeSetBtn.enabled = YES;
        self.timeSetLabel.alpha = 1.0;
    }else{
        mailSwBOOL = NO;
        self.emailSwitch.on = NO;
        self.timeSetBtn.enabled = NO;
        self.timeSetLabel.alpha = 0.5;
    }
}

// UITextFieldのキーボード上の「Return」ボタンが押された時に呼ばれる処理
- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    [sender resignFirstResponder];
    return true;
}

// ピッカービューのコンポーネント（行）の数を返す *必須
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 4;
}

// 行数を返す例　*必須
- (NSInteger) pickerView: (UIPickerView*)pView numberOfRowsInComponent:(NSInteger) component {
    if (component == 0) {
        return timeAry.count;
    }
    if (component == 1) {
        return timeAry2.count;
    }
    if (component == 2) {
        return timeAry3.count;
    }
    if (component == 3) {
        return timeAry4.count;
    }
    return 0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = (id)view;
    
    if (!label) {
        label= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    if (component == 0) {
        label.text =  [timeAry objectAtIndex:row];
    }
    if (component == 1) {
        label.text =  [timeAry2 objectAtIndex:row];
    }
    if (component == 2) {
        label.text =  [timeAry3 objectAtIndex:row];
    }
    if (component == 3) {
        label.text =  [timeAry4 objectAtIndex:row];
    }
    
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.backgroundColor = [UIColor blueColor]; // 追加
    
    return label;
}
// ピッカービューの行のタイトルを返す
- (NSString*)pickerView: (UIPickerView*) pView titleForRow:(NSInteger) row forComponent:(NSInteger)componet
{
    if (componet == 0) {
        return [timeAry objectAtIndex:row];
    }
    if (componet == 1) {
        return [timeAry2 objectAtIndex:row];
    }
    if (componet == 2) {
        return [timeAry3 objectAtIndex:row];
    }
    if (componet == 3) {
        return [timeAry4 objectAtIndex:row];
    }
    return 0;
}

//選択されたピッカービューを取得
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.timeStr1 = [timeAry objectAtIndex:row];
    }
    if (component == 1) {
        self.timeStr2 = [timeAry2 objectAtIndex:row];
    }
    if (component == 2) {
        self.timeStr3 = [timeAry3 objectAtIndex:row];
    }
    if (component == 3) {
        self.timeStr4 = [timeAry4 objectAtIndex:row];
    }
    self.pickerLabel.text = [NSString stringWithFormat:@" %@ 時 %@ 分 〜 %@ 時 %@ 分",
                             self.timeStr1,self.timeStr2,self.timeStr3,self.timeStr4];
    self.timeSetLabel.text = [NSString stringWithFormat:@" %@ 時 %@ 分 〜 %@ 時 %@ 分",
                              self.timeStr1,self.timeStr2,self.timeStr3,self.timeStr4];
}

-(void)okBtn{
    //ピッカーダイアログの内容を決定閉じるときの処理
    [UIView transitionWithView:self.pickerBaseView
                      duration:.3
                       options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        self.pickerBaseView.transform = CGAffineTransformIdentity;
                    }
                    completion:^(BOOL finished) {
                        
                    }];
}

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)emailSwitch:(UISwitch *)sender {
    if( sender.on ) {
        // onの時の処理
        mailSwBOOL = YES;
        self.timeSetBtn.enabled = YES;
        self.timeSetLabel.alpha = 1.0;
    }
    else {
        // offの時の処理
        mailSwBOOL = NO;
        self.timeSetBtn.enabled = NO;
        self.timeSetLabel.alpha = 0.5;
    }
}

- (IBAction)timeSetBtn:(id)sender {
    [UIView transitionWithView:self.pickerBaseView
                      duration:.3
                       options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        self.pickerBaseView.transform = CGAffineTransformMakeTranslation(0, -200);
                    }
                    completion:^(BOOL finished) {
                    }];
}

- (IBAction)okBtn:(id)sender {
    if (self.emailTextField.text.length == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"入力エラー" message:@"メールアドレスを入力してください。" preferredStyle:UIAlertControllerStyleAlert];
        alertController.view.tag = 1;
        // addActionした順に左から右にボタンが配置されます
        [alertController addAction:[UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // otherボタンが押された時の処理
            [self cancel:alertController];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        NSDictionary *mailDic;
        if (mailSwBOOL == NO) {
            //新規メールアドレス登録と更新
            mailDic = [PHPConnection addMailAddress:self.emailTextField.text from:[NSString stringWithFormat:@""] to:[NSString stringWithFormat:@""]];
        }else{
            //新規メールアドレス登録と更新
            mailDic = [PHPConnection addMailAddress:self.emailTextField.text from:[NSString stringWithFormat:@"%@%@",self.timeStr1,self.timeStr2] to:[NSString stringWithFormat:@"%@%@",self.timeStr3,self.timeStr4]];
        }
        if ([[mailDic objectForKey:@"STATUS"]  isEqual: @"0"]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エラー" message:[NSString stringWithFormat:@"%@",[mailDic objectForKey:@"ERRORMESSAGE"]] preferredStyle:UIAlertControllerStyleAlert];
            alertController.view.tag = 1;
            // addActionした順に左から右にボタンが配置されます
            [alertController addAction:[UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                // otherボタンが押された時の処理
                [self cancel:alertController];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}
- (void)other:(UIAlertController *)alertview{
    if (alertview.view.tag == 2) {
        [PHPConnection mailDelete:userId];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *userDataDic = [[ud objectForKey:@"UserData_Key"] mutableCopy];
        [userDataDic setObject:@"0" forKey:@"UserId"];
        [ud setObject:userDataDic forKey:@"UserData_Key"];
        BOOL successful = [ud synchronize];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)cancel:(UIAlertController *)alertview{
    if (alertview.view.tag == 3) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
