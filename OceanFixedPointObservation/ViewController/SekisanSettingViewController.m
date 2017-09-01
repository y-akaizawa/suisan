//
//  SekisanSettingViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/04/18.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import "SekisanSettingViewController.h"
#import "GetArrayObject.h"
#import "XuniGaugeDynamicKit/XuniGaugeDynamicKit.h"
#import "DiaryData.h"

@import XuniCalendarDynamicKit;

@interface SekisanSettingViewController () <XuniCalendarDelegate>
@property (strong, nonatomic) XuniCalendar *calendar;

@end

@implementation SekisanSettingViewController
UITextField *activeField1;
NSMutableArray *pksPlaceDateAry;//場所表示データ
NSMutableArray *pksSelectPlaceDateAry;//場所表示内容データ

NSMutableArray *cdAry;
int pksCount;

int fromToCount;//どっちの日付ボタンかどうか
NSString *fromStr;
NSString *toStr;
NSString *dataSetStr;//選択されているデータセットコード格納


- (void)viewDidLoad {
    [super viewDidLoad];
    dataSetStr = @"0";
    pksPlaceDateAry = [GetArrayObject allAreaData];
    pksSelectPlaceDateAry = [GetArrayObject allAreaCDData];
    self.timeFromBtn.layer.borderWidth = 1.0f;
    self.timeFromBtn.layer.borderColor = [[UIColor blackColor] CGColor];
    self.timeToBtn.layer.borderWidth = 1.0f;
    self.timeToBtn.layer.borderColor = [[UIColor blackColor] CGColor];
    CGRect rect = [Common getScreenSize];
    self.panel_Base_View = [[UIView alloc] initWithFrame:rect];
    self.panel_Base_View.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.panel_Base_View.alpha = 0;
    
    CGRect rect2 = [Common getCenterFrameWithView:self.previewPanel parent:self.panel_Base_View];
    self.previewPanel.frame = rect2;
    [self.panel_Base_View addSubview:self.previewPanel];
    self.panel_Base_View.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [self.view addSubview:self.panel_Base_View];
    
    self.unitLabel1.adjustsFontSizeToFitWidth = YES;
    self.unitLabel1.minimumScaleFactor = 5.f/30.f;
    self.unitLabel2.adjustsFontSizeToFitWidth = YES;
    self.unitLabel2.minimumScaleFactor = 5.f/30.f;
    NSDictionary *sekisanDic = [self.sekisanAry objectAtIndex:0];
    if([sekisanDic objectForKey:[NSString stringWithFormat:@"INTEGVAL%@DATASETCD",self.sekisanCountStr]] == [NSNull null]){
        self.unitLabel1.text = @"";
        self.unitLabel2.text = @"";
    }else{
        self.unitLabel1.text = [NSString stringWithFormat:@"%@",[sekisanDic objectForKey:[NSString stringWithFormat:@"INTEGVAL%@UNIT",self.sekisanCountStr]]];
        self.unitLabel2.text = [NSString stringWithFormat:@"%@",[sekisanDic objectForKey:[NSString stringWithFormat:@"INTEGVAL%@UNIT",self.sekisanCountStr]]];
    }
    
    
    UITapGestureRecognizer *tapGesture1 =
    [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    tapGesture1.delegate = self;
    [self.view addGestureRecognizer:tapGesture1];
    
    self.areaNameLabel.layer.borderWidth = 1.0f;
    self.areaNameLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.areaNameLabel.layer.cornerRadius = 3.0f;
    
    self.referenceTextField.delegate = self;
    self.referenceTextField.tag = 201;
    self.criterionTextField.delegate = self;
    self.criterionTextField.tag = 202;
    
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
    [self sekisanSet];
    
    cdAry = [[NSMutableArray alloc] initWithCapacity:0];
    cdAry = [GetArrayObject allAreaCDData];
    [self setComboBox];
    [self setCalendarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // キーボード表示・非表示時のイベント登録
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    // キーボード表示・非表示時のイベント削除
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShown:(NSNotification *)notification
{
    // アニメーション
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.view.transform = CGAffineTransformMakeTranslation(0, -100);
                         
                     } completion:^(BOOL finished) {
                         // アニメーション終了時
                     }];
}

- (void)keyboardWillHidden:(NSNotification *)notification
{
    // アニメーション
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.view.transform = CGAffineTransformIdentity;
                         
                     } completion:^(BOOL finished) {
                         // アニメーション終了時
                     }];
}
-(void)setCalendarView{
    self.calendar = [[XuniCalendar alloc] initWithFrame:CGRectMake(0, 0, self.CalendarView.frame.size.width, self.CalendarView.frame.size.height)];
    self.calendar.delegate = self;
    self.calendar.borderColor = [UIColor blackColor];
    //self.calendar.borderWidth = 2.0;
    
    self.calendar.headerBackgroundColor = [UIColor colorWithRed:30 / 255.0 green:30 / 255.0 blue:200 / 255.0 alpha:1.0];
    self.calendar.headerTextColor = [UIColor whiteColor];
    self.calendar.headerFont = [UIFont boldSystemFontOfSize:28.0];
    
    self.calendar.dayOfWeekFormat = XuniDayOfWeekFormatD;
    self.calendar.dayOfWeekBackgroundColor = [UIColor colorWithRed:80 / 255.0 green:80 / 255.0 blue:200 / 255.0 alpha:1.0];
    self.calendar.dayOfWeekTextColor = [UIColor whiteColor];
    self.calendar.dayOfWeekFont = [UIFont boldSystemFontOfSize:20.0];
    
    self.calendar.dayBorderColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1.0];
    self.calendar.dayBorderWidth = 2;
    
    self.calendar.adjacentDayTextColor = [UIColor grayColor];
    self.calendar.calendarFont = [UIFont systemFontOfSize:14.0];
    self.calendar.todayFont = [UIFont italicSystemFontOfSize:16.0];
    
    self.calendar.selectedDate = [NSDate date];
    self.calendar.displayDate = [NSDate date];
    
    self.CalendarBaseView.hidden = YES;
    [self.CalendarView addSubview:self.calendar];
}
- (void)selectionChanged:(XuniCalendar *)sender selectedDates:(XuniCalendarRange*)selectedDates{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    NSDate *todey = [calendar dateByAddingComponents:components toDate:sender.selectedDate options:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"JST"]];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *outputDateStr = [formatter stringFromDate:todey];
    if (fromToCount == 1) {
        [self.timeFromBtn setTitle:[NSString stringWithFormat:@"%@年　%@月　%@日",[outputDateStr substringWithRange:NSMakeRange(0, 4)],[outputDateStr substringWithRange:NSMakeRange(4, 2)],[outputDateStr substringWithRange:NSMakeRange(6, 2)]] forState:UIControlStateNormal];
        fromStr = outputDateStr;
    }else{
        [self.timeToBtn setTitle:[NSString stringWithFormat:@"%@年　%@月　%@日",[outputDateStr substringWithRange:NSMakeRange(0, 4)],[outputDateStr substringWithRange:NSMakeRange(4, 2)],[outputDateStr substringWithRange:NSMakeRange(6, 2)]] forState:UIControlStateNormal];
        toStr = outputDateStr;
    }
    self.CalendarBaseView.hidden = YES;
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
    if (self.sekisanAry.count > 0) {
        NSDictionary *sekisanDic = [self.sekisanAry objectAtIndex:0];
        if ([sekisanDic objectForKey:[NSString stringWithFormat:@"INTEGVAL%@DATASETCD",self.sekisanCountStr]] == [NSNull null]) {
            self.comboBoxPlace.selectedIndex = 0;
            [self.timeFromBtn setTitle:[NSString stringWithFormat:@"%@年　%@月　%@日",[[Common getTimeString] substringWithRange:NSMakeRange(0, 4)],[[Common getTimeString] substringWithRange:NSMakeRange(4, 2)],[[Common getTimeString] substringWithRange:NSMakeRange(6, 2)]] forState:UIControlStateNormal];
            [self.timeToBtn setTitle:[NSString stringWithFormat:@"%@年　%@月　%@日",[[Common getTimeString] substringWithRange:NSMakeRange(0, 4)],[[Common getTimeString] substringWithRange:NSMakeRange(4, 2)],[[Common getTimeString] substringWithRange:NSMakeRange(6, 2)]] forState:UIControlStateNormal];
            fromStr = [Common getTimeString];
            toStr = [Common getTimeString];
        }else{
            self.comboBoxPlace.text = [NSString stringWithFormat:@"%@ %@ %@",[sekisanDic objectForKey:[NSString stringWithFormat:@"INTEGVAL%@AREANM",self.sekisanCountStr]],[sekisanDic objectForKey:[NSString stringWithFormat:@"INTEGVAL%@DATATYPE",self.sekisanCountStr]],[sekisanDic objectForKey:[NSString stringWithFormat:@"INTEGVAL%@POINT",self.sekisanCountStr]]];
            dataSetStr = [sekisanDic objectForKey:[NSString stringWithFormat:@"INTEGVAL%@DATASETCD",self.sekisanCountStr]];
            [self.timeFromBtn setTitle:[NSString stringWithFormat:@"%@年　%@月　%@日",[[sekisanDic objectForKey:[NSString stringWithFormat:@"INTEGVAL%@DATEFROM",self.sekisanCountStr]] substringWithRange:NSMakeRange(0, 4)],[[sekisanDic objectForKey:[NSString stringWithFormat:@"INTEGVAL%@DATEFROM",self.sekisanCountStr]] substringWithRange:NSMakeRange(4, 2)],[[sekisanDic objectForKey:[NSString stringWithFormat:@"INTEGVAL%@DATEFROM",self.sekisanCountStr]] substringWithRange:NSMakeRange(6, 2)]] forState:UIControlStateNormal];
            [self.timeToBtn setTitle:[NSString stringWithFormat:@"%@年　%@月　%@日",[[sekisanDic objectForKey:[NSString stringWithFormat:@"INTEGVAL%@DATETO",self.sekisanCountStr]] substringWithRange:NSMakeRange(0, 4)],[[sekisanDic objectForKey:[NSString stringWithFormat:@"INTEGVAL%@DATETO",self.sekisanCountStr]] substringWithRange:NSMakeRange(4, 2)],[[sekisanDic objectForKey:[NSString stringWithFormat:@"INTEGVAL%@DATETO",self.sekisanCountStr]] substringWithRange:NSMakeRange(6, 2)]] forState:UIControlStateNormal];
            fromStr = [sekisanDic objectForKey:[NSString stringWithFormat:@"INTEGVAL%@DATEFROM",self.sekisanCountStr]];
            toStr = [sekisanDic objectForKey:[NSString stringWithFormat:@"INTEGVAL%@DATETO",self.sekisanCountStr]];;
        }
    }
}

-(void)sekisanSet{
    NSMutableDictionary *armDic = [self.sekisanAry objectAtIndex:0];
    self.referenceTextField.text = @"0";
    self.criterionTextField.text = @"0";
    if ([self.sekisanCountStr  isEqual: @"1"]) {
        if ([armDic objectForKey:@"INTEGVAL1AREANM"] == [NSNull null]) {
            pksCount = 0;
            self.areaNameLabel.text = [NSString stringWithFormat:@"%@",[pksPlaceDateAry objectAtIndex:pksCount]];
            self.deleteBtn.enabled = NO;
            self.deleteBtn.alpha = 0.5;
        }else{
            self.areaNameLabel.text = [NSString stringWithFormat:@" %@ %@ %@",
                                       [armDic objectForKey:@"INTEGVAL1AREANM"],
                                       [armDic objectForKey:@"INTEGVAL1DATATYPE"],
                                       [armDic objectForKey:@"INTEGVAL1POINT"]];
            
            self.referenceTextField.text = [armDic objectForKey:@"INTEGVAL1BASE"];
            self.criterionTextField.text = [armDic objectForKey:@"INTEGVAL1STD"];
            
        }
    }
    if ([self.sekisanCountStr  isEqual: @"2"]) {
        if ([armDic objectForKey:@"INTEGVAL2AREANM"] == [NSNull null]) {
            pksCount = 0;
            self.areaNameLabel.text = [NSString stringWithFormat:@"%@",[pksPlaceDateAry objectAtIndex:pksCount]];
            self.deleteBtn.enabled = NO;
            self.deleteBtn.alpha = 0.5;
        }else{
            self.areaNameLabel.text = [NSString stringWithFormat:@" %@ %@ %@",
                                       [armDic objectForKey:@"INTEGVAL2AREANM"],
                                       [armDic objectForKey:@"INTEGVAL2DATATYPE"],
                                       [armDic objectForKey:@"INTEGVAL2POINT"]];
            
            self.referenceTextField.text = [armDic objectForKey:@"INTEGVAL2BASE"];
            self.criterionTextField.text = [armDic objectForKey:@"INTEGVAL2STD"];
        }
    }
    if ([self.sekisanCountStr  isEqual: @"3"]) {
        if ([armDic objectForKey:@"INTEGVAL3AREANM"] == [NSNull null]) {
            pksCount = 0;
            self.areaNameLabel.text = [NSString stringWithFormat:@"%@",[pksPlaceDateAry objectAtIndex:pksCount]];
            self.deleteBtn.enabled = NO;
            self.deleteBtn.alpha = 0.5;
        }else{
            self.areaNameLabel.text = [NSString stringWithFormat:@" %@ %@ %@",
                                       [armDic objectForKey:@"INTEGVAL3AREANM"],
                                       [armDic objectForKey:@"INTEGVAL3DATATYPE"],
                                       [armDic objectForKey:@"INTEGVAL3POINT"]];
            
            self.referenceTextField.text = [armDic objectForKey:@"INTEGVAL3BASE"];
            self.criterionTextField.text = [armDic objectForKey:@"INTEGVAL3STD"];
        }
    }
}

- (void)tapped:(UITapGestureRecognizer *)sender{
    [activeField1 resignFirstResponder];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    activeField1 = textField;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 最大入力文字数
    int maxInputLength = 50;
    switch (textField.tag) {
        case 101:
            maxInputLength = 4;
            break;
        case 102:
            maxInputLength = 2;
            break;
        case 103:
            maxInputLength = 2;
            break;
        case 104:
            maxInputLength = 4;
            break;
        case 105:
            maxInputLength = 2;
            break;
        case 106:
            maxInputLength = 2;
            break;
        case 201:
            maxInputLength = 4;
            break;
        case 202:
            maxInputLength = 4;
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
    return pksPlaceDateAry.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = (id)view;
    
    if (!label) {
        label= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    label.text = [NSString stringWithFormat:@"%@",[pksPlaceDateAry objectAtIndex:row]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.backgroundColor = [UIColor blueColor]; // 追加
    
    return label;
}

- (void)isDropDownOpenChanging:(XuniDropDown *)sender args:(XuniDropDownOpenChangingEventArgs *)args{
    NSMutableArray *ary = [PHPConnection getPanelDetail:[cdAry objectAtIndex:self.comboBoxPlace.selectedIndex]];
    NSDictionary *dic = [ary objectAtIndex:0];
    NSString *unitStr = [dic objectForKey:@"UNIT"];
    self.unitLabel1.text = unitStr;
    self.unitLabel2.text = unitStr;
}

//選択されたピッカービューを取得
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger selectedRow = [pickerView selectedRowInComponent:0];
    pksCount = (int)selectedRow;
}
- (void)pickerOKBtn{
    [UIView transitionWithView:self.pickerBaseView
                      duration:.3
                       options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        self.pickerBaseView.transform = CGAffineTransformIdentity;
                    }
                    completion:^(BOOL finished) {
                        self.areaNameLabel.text = [NSString stringWithFormat:@"%@",[pksPlaceDateAry objectAtIndex:pksCount]];
                    }];
}

- (IBAction)areaNameSelectBtn:(id)sender {
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
    if (self.referenceTextField.text.length == 0 || self.criterionTextField.text.length == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"入力エラー" message:@"未入力の項目があります。" preferredStyle:UIAlertControllerStyleAlert];
        // addActionした順に左から右にボタンが配置されます
        [alertController addAction:[UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // otherボタンが押された時の処理
            [self cancel:alertController];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        NSString *datasetcd = @"";
        if ((dataSetStr = @"0")) {
            datasetcd = [cdAry objectAtIndex:self.comboBoxPlace.selectedIndex];
        }else{
            datasetcd = dataSetStr;
        }
        NSDictionary *sekisanDic = [PHPConnection updSekisanSetting:self.sekisanCountStr datasetcd:datasetcd from:[fromStr substringWithRange:NSMakeRange(0, 8)] to:[toStr substringWithRange:NSMakeRange(0, 8)] base:self.referenceTextField.text std:self.criterionTextField.text];
        if ([Common checkErrorMessage:sekisanDic] == YES) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エラー" message:[NSString stringWithFormat:@"%@",[sekisanDic objectForKey:@"ERRORMESSAGE"]] preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                // cancelボタンが押された時の処理
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (IBAction)previewBtn:(id)sender {
    if (self.referenceTextField.text.length == 0 || self.criterionTextField.text.length == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"入力エラー" message:@"未入力の項目があります。" preferredStyle:UIAlertControllerStyleAlert];
        // addActionした順に左から右にボタンが配置されます
        [alertController addAction:[UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // otherボタンが押された時の処理
            [self cancel:alertController];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        NSString *datasetcd = @"";
        if ((dataSetStr = @"0")) {
            datasetcd = [cdAry objectAtIndex:self.comboBoxPlace.selectedIndex];
        }else{
            datasetcd = dataSetStr;
        }
        NSDictionary *sekisanDic = [PHPConnection updSekisanSetting:self.sekisanCountStr datasetcd:datasetcd from:[fromStr substringWithRange:NSMakeRange(0, 8)] to:[toStr substringWithRange:NSMakeRange(0, 8)] base:self.referenceTextField.text std:self.criterionTextField.text];
        
        NSMutableArray *previewDataAry = [[NSMutableArray alloc] initWithCapacity:0];
        previewDataAry = [PHPConnection getSekisanPreviewData:datasetcd targetdate:[Common getTimeString] datefrom:fromStr dateto:toStr base:self.referenceTextField.text std:self.criterionTextField.text];
        for( NSDictionary *previewDataDic in previewDataAry) {
            self.panel_AreaNameLabel.text = [previewDataDic objectForKey:@"AREANM"];
            self.panel_DataTypeLabel.text = [previewDataDic objectForKey:@"DATATYPE"];
            self.panel_PointLabel.text = [previewDataDic objectForKey:@"POINT"];
            
            self.panel_UnitLabel1.text = [previewDataDic objectForKey:@"UNIT"];
            if ([previewDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                self.panel_AssayVal1.text = @"--";
                self.panel_AssayVal2.text = @"";
            }else{
                NSArray *AssayValAry = [[previewDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                self.panel_AssayVal1.text = [AssayValAry objectAtIndex:0];
                self.panel_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
            }
            if ([previewDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                self.panel_MaxValLabel.text = @"--";
            }else{
                self.panel_MaxValLabel.text = [previewDataDic objectForKey:@"MAXVAL"];
            }
            if ([previewDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                self.panel_MinValLabel.text = @"--";
            }else{
                self.panel_MinValLabel.text = [previewDataDic objectForKey:@"MINVAL"];
            }
            if ([previewDataDic objectForKey:@"VAL"] == [NSNull null]) {
                
            }else{
                self.panel_UnitLabel2.text = [previewDataDic objectForKey:@"UNIT"];
                [self sekisanChrck:[previewDataDic objectForKey:@"VAL"] std:[previewDataDic objectForKey:@"STD"]];
            }
        }
        
        self.panel_Base_View.transform = CGAffineTransformMakeScale(1.1, 1.1);
        [UIView transitionWithView:self.panel_Base_View duration:.2 options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut animations:^{
            self.panel_Base_View.alpha = 1.0;
            self.panel_Base_View.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}
#pragma mark-積算ゲージ処理
-(void)sekisanChrck:(NSString *)val std:(NSString *)std{
    int sekisaiVal = [val intValue];
    int sekisaiStd = [std intValue];
    XuniRadialGauge *radialGauge;
    radialGauge = [[XuniRadialGauge alloc] initWithFrame:CGRectMake(3, 3, 94, 94)];
    radialGauge.tag = 1001;
    radialGauge.backgroundColor = [UIColor clearColor];
    radialGauge.showText = XuniShowTextValue;
    radialGauge.valueFontColor = RGB(30, 144, 255);
    radialGauge.valueFont = [UIFont boldSystemFontOfSize:100.0f];
    radialGauge.thickness = 0.10;
    radialGauge.min = 0;
    if (sekisaiVal >= 9999) {
        radialGauge.max = 9999;
        radialGauge.value = sekisaiVal;
    }else{
        if (sekisaiVal < sekisaiStd) {
            radialGauge.max = sekisaiStd;
            radialGauge.value = sekisaiVal;
        }else{
            radialGauge.max = sekisaiVal;
            radialGauge.value = sekisaiVal;
        }
    }
    
    
    radialGauge.showRanges = false;
    radialGauge.pointerColor = RGB(30, 144, 255);
    radialGauge.startAngle = 90;
    radialGauge.sweepAngle = 360;
    radialGauge.loadAnimation.duration = 2;
    radialGauge.updateAnimation.duration = 2;
    
    // 範囲を作成してカスタマイズします。
    XuniGaugeRange* lower = [[XuniGaugeRange alloc] initWithGauge:radialGauge];
    lower.min = 0;
    lower.max = 100;
    lower.color = RGB(0, 191, 255);;
    
    // 範囲を追加します
    [radialGauge.ranges addObject:lower];
    
    self.panel_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
    [self.panel_View3 addSubview:radialGauge];
}
- (IBAction)deleteBtn:(id)sender {
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@"積算値設定解除"
                                        message:@"積算値設定情報を削除します。\nよろしいですか？"
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
//削除処理
- (void)other:(UIAlertController *)alertview{
    NSDictionary *delDic = [PHPConnection delSekisanSetting:self.sekisanCountStr];
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
- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)panelCloseBtn:(id)sender {
    [UIView transitionWithView:self.panel_Base_View
                      duration:.3
                       options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        self.panel_Base_View.transform = CGAffineTransformMakeScale(0.8, 0.8);
                        self.panel_Base_View.alpha = 0;
                    }
                    completion:^(BOOL finished) {
                        UIView *xuniView = [self.panel_View3 viewWithTag:1001];
                        [xuniView removeFromSuperview];
                    }];
}
- (IBAction)CalendarSegment:(id)sender {
    if (self.CalendarSegment.selectedSegmentIndex == 0) {
        [self.calendar changeViewModeAsync:XuniCalendarViewModeMonth date:nil];
    }
    else if (self.CalendarSegment.selectedSegmentIndex == 1) {
        [self.calendar changeViewModeAsync:XuniCalendarViewModeYear date:nil];
    }
}
- (IBAction)today:(id)sender {
    self.calendar.selectedDate = [NSDate date];
    self.calendar.displayDate = [NSDate date];
}
- (IBAction)close:(id)sender {
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.CalendarBaseView.alpha = 0.0f;
                     } completion:^(BOOL finished){
                         self.CalendarBaseView.hidden = YES;
                     }];
    
}
- (IBAction)timeFromBtn:(id)sender {
    [self.view bringSubviewToFront:self.CalendarBaseView];
    self.calendar.selectedDate = [NSDate date];
    self.calendar.displayDate = [NSDate date];
    fromToCount = 1;
    self.CalendarSegment.selectedSegmentIndex = 0;
    [self.calendar changeViewModeAsync:XuniCalendarViewModeMonth date:nil];
    self.CalendarBaseView.hidden = NO;
    self.CalendarBaseView.alpha = 0.0f;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.CalendarBaseView.alpha = 1.0f;
                     } completion:^(BOOL finished){
                         
                     }];
}
- (IBAction)timeToBtn:(id)sender {
    [self.view bringSubviewToFront:self.CalendarBaseView];
    self.calendar.selectedDate = [NSDate date];
    self.calendar.displayDate = [NSDate date];
    fromToCount = 2;
    self.CalendarSegment.selectedSegmentIndex = 0;
    [self.calendar changeViewModeAsync:XuniCalendarViewModeMonth date:nil];
    self.CalendarBaseView.hidden = NO;
    self.CalendarBaseView.alpha = 0.0f;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.CalendarBaseView.alpha = 1.0f;
                     } completion:^(BOOL finished){
                         
                     }];
}
@end
