//
//  AlarmSettingViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/04/18.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import "AlarmSettingViewController.h"
#import "GetArrayObject.h"
#import "DiaryData.h"

@interface AlarmSettingViewController ()

@end

@implementation AlarmSettingViewController
UITextField *activeField;
NSMutableArray *pkPlaceDateAry;//場所表示データ
NSMutableArray *pkSelectPlaceDateAry;//場所表示内容データ
NSString *dataStr;
int pkCount;
NSDictionary *alarmDic;
NSMutableArray *dAry;

- (void)viewDidLoad {
    [super viewDidLoad];
    pkPlaceDateAry = [GetArrayObject allAreaData];
    pkSelectPlaceDateAry = [GetArrayObject allAreaCDData];
    dAry = [[NSMutableArray alloc] initWithCapacity:0];
    dAry = [GetArrayObject allAreaCDData];
    if (self.alarmAry.count > 0) {
        alarmDic = [self.alarmAry objectAtIndex:0];
    }
    self.rangeLabel1.adjustsFontSizeToFitWidth = YES;
    self.rangeLabel1.minimumScaleFactor = 5.f/30.f;
    self.rangeLabel2.adjustsFontSizeToFitWidth = YES;
    self.rangeLabel2.minimumScaleFactor = 5.f/30.f;
    if([alarmDic objectForKey:[NSString stringWithFormat:@"ARM%@DATASETCD",self.alarmCountStr]] == [NSNull null]){
        self.rangeLabel1.text = @"";
        self.rangeLabel2.text = @"";
    }else{
        self.rangeLabel1.text = [NSString stringWithFormat:@"%@(%@)",[alarmDic objectForKey:[NSString stringWithFormat:@"ARM%@DATATYPE",self.alarmCountStr]],[alarmDic objectForKey:[NSString stringWithFormat:@"ARM%@UNIT",self.alarmCountStr]]];
        self.rangeLabel2.text = [NSString stringWithFormat:@"%@(%@)",[alarmDic objectForKey:[NSString stringWithFormat:@"ARM%@DATATYPE",self.alarmCountStr]],[alarmDic objectForKey:[NSString stringWithFormat:@"ARM%@UNIT",self.alarmCountStr]]];
    }
    UITapGestureRecognizer *tapGesture1 =
    [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    tapGesture1.delegate = self;
    [self.view addGestureRecognizer:tapGesture1];
    
    self.areaNameLabel.layer.borderWidth = 1.0f;
    self.areaNameLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.areaNameLabel.layer.cornerRadius = 3.0f;
    
    self.rangeTextField1.delegate = self;
    self.rangeTextField2.delegate = self;
    self.countTextField.delegate = self;
    
    CGRect rect = [Common getScreenSize];
    self.pickerBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, rect.size.height, rect.size.width, 200)];
    self.pickerBaseView.layer.borderWidth = 2.0f;
    self.pickerBaseView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.pickerBaseView.backgroundColor = [UIColor redColor];
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, rect.size.width, 156)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerBaseView.backgroundColor = [UIColor whiteColor];
    [self.pickerBaseView addSubview:self.pickerView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(4,4,100, 40);
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [[UIColor blackColor] CGColor];
    button.layer.cornerRadius = 5.0f;
    [button setTitle:@"決定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pickerOKBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerBaseView addSubview:button];
    [self.view addSubview:self.pickerBaseView];
    
    
    
    [self armSet];
    [self setComboBox];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)setComboBox{
    self.comboBoxPlace.delegate = self;
    self.comboBoxPlace.backgroundColor = [UIColor whiteColor];
    self.comboBoxPlace.displayMemberPath = @"name";
    self.comboBoxPlace.itemsSource = [DiaryData place2];
    self.comboBoxPlace.isEditable = NO;
    self.comboBoxPlace.isAnimated = YES;
    self.comboBoxPlace.dropDownBehavior = XuniDropDownBehaviorButtonTap;
    self.comboBoxPlace.dropDownHeight = 200;
    
    if ([alarmDic objectForKey:[NSString stringWithFormat:@"ARM%@DATASETCD",self.alarmCountStr]] == [NSNull null]) {
        self.comboBoxPlace.selectedIndex = 0;
    }else{
        self.comboBoxPlace.text = [NSString stringWithFormat:@"%@ %@ %@",[alarmDic objectForKey:[NSString stringWithFormat:@"ARM%@AREANM",self.alarmCountStr]],[alarmDic objectForKey:[NSString stringWithFormat:@"ARM%@DATATYPE",self.alarmCountStr]],[alarmDic objectForKey:[NSString stringWithFormat:@"ARM%@POINT",self.alarmCountStr]]];
        dataStr = [alarmDic objectForKey:[NSString stringWithFormat:@"ARM%@DATASETCD",self.alarmCountStr]];
    }
}
//アラームの状態を反映させる
- (void)armSet{
    NSMutableDictionary *armDic = [self.alarmAry objectAtIndex:0];
    self.rangeTextField1.text = @"0";
    self.rangeTextField2.text = @"0";
    self.countTextField.text = @"1";
    if ([self.alarmCountStr  isEqual: @"1"]) {
        if ([armDic objectForKey:@"ARM1AREANM"] == [NSNull null]) {
            pkCount = 0;
            self.areaNameLabel.text = [NSString stringWithFormat:@"%@",[pkPlaceDateAry objectAtIndex:pkCount]];
            self.deleteBtn.enabled = NO;
            self.deleteBtn.alpha = 0.5;
        }else{
            self.areaNameLabel.text = [NSString stringWithFormat:@" %@ %@ %@",
                                       [armDic objectForKey:@"ARM1AREANM"],
                                       [armDic objectForKey:@"ARM1DATATYPE"],
                                       [armDic objectForKey:@"ARM1POINT"]];
            self.rangeTextField1.text = [NSString stringWithFormat:@"%@",
                                         [armDic objectForKey:@"ARM1VALFROM"]];
            self.rangeTextField2.text = [NSString stringWithFormat:@"%@",
                                         [armDic objectForKey:@"ARM1VALTO"]];
            self.countTextField.text = [NSString stringWithFormat:@"%@",
                                        [armDic objectForKey:@"ARM1TIMES"]];
        }
    }
    if ([self.alarmCountStr  isEqual: @"2"]) {
        if ([armDic objectForKey:@"ARM2AREANM"] == [NSNull null]) {
            pkCount = 0;
            self.areaNameLabel.text = [NSString stringWithFormat:@"%@",
                                       [pkPlaceDateAry objectAtIndex:pkCount]];
            self.deleteBtn.enabled = NO;
            self.deleteBtn.alpha = 0.5;
        }else{
            self.areaNameLabel.text = [NSString stringWithFormat:@" %@ %@ %@",
                                       [armDic objectForKey:@"ARM2AREANM"],
                                       [armDic objectForKey:@"ARM2DATATYPE"],
                                       [armDic objectForKey:@"ARM2POINT"]];
            self.rangeTextField1.text = [NSString stringWithFormat:@"%@",
                                         [armDic objectForKey:@"ARM2VALFROM"]];
            self.rangeTextField2.text = [NSString stringWithFormat:@"%@",
                                         [armDic objectForKey:@"ARM2VALTO"]];
            self.countTextField.text = [NSString stringWithFormat:@"%@",
                                        [armDic objectForKey:@"ARM2TIMES"]];
        }
    }
    if ([self.alarmCountStr  isEqual: @"3"]) {
        if ([armDic objectForKey:@"ARM3AREANM"] == [NSNull null]) {
            pkCount = 0;
            self.areaNameLabel.text = [NSString stringWithFormat:@"%@",[pkPlaceDateAry objectAtIndex:pkCount]];
            self.deleteBtn.enabled = NO;
            self.deleteBtn.alpha = 0.5;
        }else{
            self.areaNameLabel.text = [NSString stringWithFormat:@" %@ %@ %@",
                                       [armDic objectForKey:@"ARM3AREANM"],
                                       [armDic objectForKey:@"ARM3DATATYPE"],
                                       [armDic objectForKey:@"ARM3POINT"]];
            self.rangeTextField1.text = [NSString stringWithFormat:@"%@",
                                         [armDic objectForKey:@"ARM3VALFROM"]];
            self.rangeTextField2.text = [NSString stringWithFormat:@"%@",
                                         [armDic objectForKey:@"ARM3VALTO"]];
            self.countTextField.text = [NSString stringWithFormat:@"%@",
                                        [armDic objectForKey:@"ARM3TIMES"]];
        }
    }
}

- (void)tapped:(UITapGestureRecognizer *)sender{
    [activeField resignFirstResponder];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    activeField = textField;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 最大入力文字数
    int maxInputLength = 50;
    switch (textField.tag) {
        case 11:
            maxInputLength = 3;
            break;
        case 12:
            maxInputLength = 3;
            break;
        case 13:
            maxInputLength = 2;
            break;
            
        default:
            break;
    }
    NSMutableString *str = [textField.text mutableCopy];
    [str replaceCharactersInRange:range withString:string];
    if ([str length] > maxInputLength) {
        return NO;
    }
    return YES;
}


// 列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    return 1;
}

// 行数
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return pkPlaceDateAry.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = (id)view;
    
    if (!label) {
        label= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    label.text = [NSString stringWithFormat:@"%@",[pkPlaceDateAry objectAtIndex:row]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.backgroundColor = [UIColor blueColor]; // 追加
    
    return label;
}

- (void)isDropDownOpenChanging:(XuniDropDown *)sender args:(XuniDropDownOpenChangingEventArgs *)args{
    NSMutableArray *ary = [PHPConnection getPanelDetail:[dAry objectAtIndex:self.comboBoxPlace.selectedIndex]];
    NSDictionary *dic = [ary objectAtIndex:0];
    NSString *unitStr = @"";
    if ([[dic objectForKey:@"UNIT"]  isEqual: @""]) {
        unitStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"DATATYPE"]];
    }else{
        unitStr = [NSString stringWithFormat:@"%@(%@)",[dic objectForKey:@"DATATYPE"],[dic objectForKey:@"UNIT"]];
    }
    self.rangeLabel1.text = unitStr;
    self.rangeLabel2.text = unitStr;
}
//選択されたピッカービューを取得
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger selectedRow = [pickerView selectedRowInComponent:0];
    pkCount = (int)selectedRow;
}
- (void)pickerOKBtn{
    [UIView transitionWithView:self.pickerBaseView
                      duration:.3
                       options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        self.pickerBaseView.transform = CGAffineTransformIdentity;
                    }
                    completion:^(BOOL finished) {
                        self.areaNameLabel.text = [NSString stringWithFormat:@"%@",[pkPlaceDateAry objectAtIndex:pkCount]];
                    }];
}


- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)areaSelectBtn:(id)sender {
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
    if (self.rangeTextField1.text.length == 0 || self.rangeTextField2.text.length == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"入力エラー" message:@"未入力の項目があります。" preferredStyle:UIAlertControllerStyleAlert];
        // addActionした順に左から右にボタンが配置されます
        [alertController addAction:[UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // otherボタンが押された時の処理
            [self cancel:alertController];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        NSString *datasetcd = @"";
        if ((dataStr = @"0")) {
            datasetcd = [dAry objectAtIndex:self.comboBoxPlace.selectedIndex];
        }else{
            datasetcd = dataStr;
        }
        NSDictionary *dic = [PHPConnection updAlarmSetting:self.alarmCountStr datasetcd:datasetcd from:self.rangeTextField1.text to:self.rangeTextField2.text];
        if ([Common checkErrorMessage:dic] == YES) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エラー" message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ERRORMESSAGE"]] preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                // cancelボタンが押された時の処理
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (IBAction)deleteBtn:(id)sender {
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@"アラーム設定削除"
                                        message:@"アラーム設定情報を削除します。\nよろしいですか？"
                                 preferredStyle:UIAlertControllerStyleAlert];
    alertController.view.tag = 1;
    // addActionした順に左から右にボタンが配置されます
    [alertController addAction:[UIAlertAction actionWithTitle:@"削除" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // otherボタンが押された時の処理
        [self other:alertController];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"キャンセル" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // cancelボタンが押された時の処理
        [self cancel:alertController];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)other:(UIAlertController *)alertview{
    NSDictionary *delDic = [PHPConnection delAlarmSetting:self.alarmCountStr];
    if ([Common checkErrorMessage:delDic] == YES) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エラー" message:[NSString stringWithFormat:@"%@",[delDic objectForKey:@"ERRORMESSAGE"]] preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // cancelボタンが押された時の処理
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)cancel:(UIAlertController *)alertview{
    
}
@end
