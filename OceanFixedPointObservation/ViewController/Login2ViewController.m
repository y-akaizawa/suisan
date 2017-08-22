//
//  Login2ViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2017/07/12.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import "Login2ViewController.h"
#import "MainViewController.h"

@interface Login2ViewController ()

@end

@implementation Login2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userId1.delegate =self;
    self.userId2.delegate =self;
    self.userId3.delegate =self;
    self.userId4.delegate =self;
    self.userId5.delegate =self;
    self.groupId1.delegate =self;
    self.groupId2.delegate =self;
    self.groupId3.delegate =self;
    self.groupId4.delegate =self;
    
    self.userId1.tag =101;
    self.userId2.tag =102;
    self.userId3.tag =103;
    self.userId4.tag =104;
    self.userId5.tag =105;
    self.groupId1.tag =106;
    self.groupId2.tag =107;
    self.groupId3.tag =108;
    self.groupId4.tag =109;
    
    self.userId1.text = @"44S1";
    self.userId2.text = @"BAaO";
    self.userId3.text = @"L6uh";
    self.userId4.text = @"Psmb";
    self.userId5.text = @"zLHX";
    
    self.groupId1.text = @"0H5Y";
    self.groupId2.text = @"XDH3";
    self.groupId3.text = @"1U0A";
    self.groupId4.text = @"YB77";
    //ユーザー１
//    self.userId1.text = @"g5Uf";
//    self.userId2.text = @"9Glu";
//    self.userId3.text = @"N2ZP";
//    self.userId4.text = @"TV0C";
//    self.userId5.text = @"mdmE";
    //ユーザー2
//    self.userId1.text = @"fxnI";
//    self.userId2.text = @"0MDm";
//    self.userId3.text = @"f896";
//    self.userId4.text = @"jXjQ";
//    self.userId5.text = @"pIXx";
    
//    self.groupId1.text = @"8RK9";
//    self.groupId2.text = @"EEVJ";
//    self.groupId3.text = @"HAT3";
//    self.groupId4.text = @"EEE8";
    
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
    // キーボードの top を取得する
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"aaaaaaaaaaaaaaaaaa %f,%f,%f,%f",keyboardRect.origin.x,keyboardRect.origin.y,keyboardRect.size.height,keyboardRect.size.width);
    // アニメーション
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.view.transform = CGAffineTransformMakeTranslation(0, -70);
                         
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
- (IBAction)okBtn:(id)sender {
    [Common showSVProgressHUD:@""];
    NSString *userId = [NSString stringWithFormat:@"%@%@%@%@%@",self.userId1.text,self.userId2.text,self.userId3.text,self.userId4.text,self.userId5.text];
    NSString *groupId = [NSString stringWithFormat:@"%@%@%@%@",self.groupId1.text,self.groupId2.text,self.groupId3.text,self.groupId4.text];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *loginDic = [PHPConnection inheritance:groupId userId:userId];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",loginDic);
            if ([Common checkErrorMessage:loginDic] == YES) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エラー" message:[NSString stringWithFormat:@"%@",[loginDic objectForKey:@"ERRORMESSAGE"]] preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    // cancelボタンが押された時の処理
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }else{
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                NSMutableDictionary *userDataDic = [[ud objectForKey:@"UserData_Key"] mutableCopy];
                [userDataDic setObject:[loginDic objectForKey:@"USERID"] forKey:@"UserId"];
                [userDataDic setObject:[loginDic objectForKey:@"GROUPID"] forKey:@"GroupId"];
                [ud setObject:userDataDic forKey:@"UserData_Key"];
                [ud synchronize];
                MainViewController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                mainViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self presentViewController:mainViewController animated:YES completion:nil];
            }
            [Common dismissSVProgressHUD];
        });
    });
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.userId1 resignFirstResponder];
    [self.userId2 resignFirstResponder];
    [self.userId3 resignFirstResponder];
    [self.userId4 resignFirstResponder];
    [self.userId5 resignFirstResponder];
    [self.groupId1 resignFirstResponder];
    [self.groupId2 resignFirstResponder];
    [self.groupId3 resignFirstResponder];
    [self.groupId4 resignFirstResponder];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 最大入力文字数
    int maxInputLength = 4;
    
    // 入力済みのテキストを取得
    NSMutableString *str = [textField.text mutableCopy];
    
    // 入力済みのテキストと入力が行われたテキストを結合
    [str replaceCharactersInRange:range withString:string];
    
    NSLog(@"text2=%lu",(unsigned long)[textField.text length]);
    NSLog(@"text2=%lu",(unsigned long)[string length]);
    NSInteger srtCount = [textField.text length] + [string length];
    NSLog(@"srtCount=%lu",(unsigned long)srtCount);
    if (srtCount > maxInputLength) {
        // ※ここに文字数制限を超えたことを通知する処理を追加
        if (textField.tag != 109) {
            UITextField *nextText = (UITextField *)[self.view viewWithTag:textField.tag+1];
            [nextText becomeFirstResponder];
        }
        return NO;
    }
    
    return YES;
}
- (IBAction)closeBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
