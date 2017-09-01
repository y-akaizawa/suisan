//
//  DiaryInputViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2017/05/23.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import "DiaryInputViewController.h"
#import "DiaryData.h"
#import "GetArrayObject.h"

@interface DiaryInputViewController ()

@end

@implementation DiaryInputViewController
NSString *targetdate;
NSMutableArray *datasetcdAry;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.diaryTextView.layer.cornerRadius = 10;
    self.diaryTextView.clipsToBounds = true;
    self.diaryTextView.inputAccessoryView = [self createAccessoryView];
    self.addBtn.layer.cornerRadius = 10;
    self.addBtn.clipsToBounds = true;
    self.deleteBtn.layer.cornerRadius = 10;
    self.deleteBtn.clipsToBounds = true;
    datasetcdAry = [[NSMutableArray alloc] initWithCapacity:0];
    datasetcdAry = [GetArrayObject allAreaCDData];
    [datasetcdAry insertObject:@"0" atIndex:0];

    if (self.diaryFlag == 0) {
        targetdate = [Common getTimeString];
        self.deleteBtn.hidden = YES;
    }else{
        targetdate = [self.eventDic objectForKey:@"ASSAYDATE"];
        [self.addBtn setTitle:@"更新" forState:UIControlStateNormal];
        self.titleLabel.text = @"日誌編集";
    }
    [self setComboBox];
    
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
                         self.inputScrollView.contentOffset = CGPointMake(self.inputScrollView.frame.origin.x, self.inputScrollView.frame.origin.y+50);
                         
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
                         self.inputScrollView.contentOffset = CGPointMake(self.inputScrollView.frame.origin.x, self.inputScrollView.frame.origin.y-65);
                         
                     } completion:^(BOOL finished) {
                         // アニメーション終了時
                     }];
}
// UITextView のキーボードを隠す
- (void)closeKeyboardForTextView
{
    [self.diaryTextView resignFirstResponder];
}
// 閉じるボタンを配置したアクセサリビュー作成
- (UIView *)createAccessoryView
{
    UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    accessoryView.backgroundColor = [UIColor darkGrayColor];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeBtn.backgroundColor = [UIColor lightGrayColor];
    closeBtn.frame = CGRectMake(self.view.bounds.size.width - 85, 5, 80, 30);
    [closeBtn setTitle:@"閉じる" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeKeyboardForTextView) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView addSubview:closeBtn];
    return accessoryView;
}
-(void)setComboBox{
    self.comboBoxYear.delegate = self;
    self.comboBoxYear.backgroundColor = [UIColor whiteColor];
    self.comboBoxYear.text = [targetdate substringWithRange:NSMakeRange(0, 4)];
    self.comboBoxYear.displayMemberPath = @"name";
    self.comboBoxYear.itemsSource = [DiaryData year];
    self.comboBoxYear.isEditable = NO;
    self.comboBoxYear.isAnimated = YES;
    self.comboBoxYear.dropDownBehavior = XuniDropDownBehaviorButtonTap;
    self.comboBoxYear.dropDownHeight = 200;
    
    self.comboBoxMonth.delegate = self;
    self.comboBoxMonth.backgroundColor = [UIColor whiteColor];
    self.comboBoxMonth.text = [targetdate substringWithRange:NSMakeRange(4, 2)];
    self.comboBoxMonth.displayMemberPath = @"name";
    self.comboBoxMonth.itemsSource = [DiaryData month];
    self.comboBoxMonth.isEditable = NO;
    self.comboBoxMonth.isAnimated = YES;
    self.comboBoxMonth.dropDownBehavior = XuniDropDownBehaviorButtonTap;
    self.comboBoxMonth.dropDownHeight = 200;
    
    self.comboBoxDay.delegate = self;
    self.comboBoxDay.backgroundColor = [UIColor whiteColor];
    self.comboBoxDay.text = [targetdate substringWithRange:NSMakeRange(6, 2)];
    self.comboBoxDay.displayMemberPath = @"name";
    self.comboBoxDay.itemsSource = [DiaryData day];
    self.comboBoxDay.isEditable = NO;
    self.comboBoxDay.isAnimated = YES;
    self.comboBoxDay.dropDownBehavior = XuniDropDownBehaviorButtonTap;
    self.comboBoxDay.dropDownHeight = 200;
    
    self.comboBoxTime.delegate = self;
    self.comboBoxTime.backgroundColor = [UIColor whiteColor];
    self.comboBoxTime.text = [targetdate substringWithRange:NSMakeRange(8, 2)];
    self.comboBoxTime.displayMemberPath = @"name";
    self.comboBoxTime.itemsSource = [DiaryData time];
    self.comboBoxTime.isEditable = NO;
    self.comboBoxTime.isAnimated = YES;
    self.comboBoxTime.dropDownBehavior = XuniDropDownBehaviorButtonTap;
    self.comboBoxTime.dropDownHeight = 200;
    
    self.comboBoxPlace.delegate = self;
    self.comboBoxPlace.backgroundColor = [UIColor whiteColor];
    self.comboBoxPlace.displayMemberPath = @"name";
    self.comboBoxPlace.itemsSource = [DiaryData place];
    self.comboBoxPlace.isEditable = NO;
    self.comboBoxPlace.isAnimated = YES;
    self.comboBoxPlace.dropDownBehavior = XuniDropDownBehaviorButtonTap;
    self.comboBoxPlace.dropDownHeight = 200;
    
    if (self.diaryFlag == 0) {
        self.comboBoxPlace.selectedIndex = 0;
    }else{
        if ([[self.eventDic objectForKey:@"DATASETCD"]  isEqual: @"0"]) {
            self.comboBoxPlace.selectedIndex = 0;
        }else{
            self.comboBoxPlace.text = [NSString stringWithFormat:@"%@ %@ %@",[self.eventDic objectForKey:@"AREANM"],[self.eventDic objectForKey:@"DATATYPE"],[self.eventDic objectForKey:@"POINT"]];
        }
        self.diaryTextView.text = [NSString stringWithFormat:@"%@",[self.eventDic objectForKey:@"MEMO"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.diaryTextView resignFirstResponder];
}

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)addBtn:(id)sender {
    NSString *date = [NSString stringWithFormat:@"%@%@%@%@",self.comboBoxYear.text,self.comboBoxMonth.text,self.comboBoxDay.text,self.comboBoxTime.text];
    NSDictionary *diaryDic = nil;
    if (self.diaryFlag == 0) {
        diaryDic = [PHPConnection addDiaryData:[datasetcdAry objectAtIndex:self.comboBoxPlace.selectedIndex] memo:self.diaryTextView.text date:date writekind:@"0"];
        
    }else{
        diaryDic = [PHPConnection updDiaryData:self.eventId datasetcd:[datasetcdAry objectAtIndex:self.comboBoxPlace.selectedIndex] memo:self.diaryTextView.text date:date writekind:@"0"];
    }
    if ([Common checkErrorMessage:diaryDic] == YES) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エラー" message:[NSString stringWithFormat:@"%@",[diaryDic objectForKey:@"ERRORMESSAGE"]] preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // cancelボタンが押された時の処理
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (IBAction)deleteBtn:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"確認" message:@"日誌データを削除します。\nよろしいですか？" preferredStyle:UIAlertControllerStyleAlert];
    
    // addActionした順に左から右にボタンが配置されます
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // otherボタンが押された時の処理
        [self otherButtonPushed];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"キャンセル" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // cancelボタンが押された時の処理
        [self cancelButtonPushed];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)cancelButtonPushed{
    
}
- (void)otherButtonPushed{
    NSString *date = [NSString stringWithFormat:@"%@%@%@%@",self.comboBoxYear.text,self.comboBoxMonth.text,self.comboBoxDay.text,self.comboBoxTime.text];
    NSDictionary *diaryDic = nil;
    diaryDic = [PHPConnection delDiaryData:self.eventId datasetcd:[datasetcdAry objectAtIndex:self.comboBoxPlace.selectedIndex] memo:self.diaryTextView.text date:date writekind:@"0"];
    if ([Common checkErrorMessage:diaryDic] == YES) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エラー" message:[NSString stringWithFormat:@"%@",[diaryDic objectForKey:@"ERRORMESSAGE"]] preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // cancelボタンが押された時の処理
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
