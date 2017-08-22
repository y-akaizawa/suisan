//
//  LoginViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2017/05/18.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "Login2ViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.verLabel.text =[NSString stringWithFormat:@"ver. %@",[[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"]];
    self.groupId1.delegate =self;
    self.groupId2.delegate =self;
    self.groupId3.delegate =self;
    self.groupId4.delegate =self;
    self.groupId1.tag = 101;
    self.groupId2.tag = 102;
    self.groupId3.tag = 103;
    self.groupId4.tag = 104;
//    self.groupId1.text = @"8RK9";
//    self.groupId2.text = @"EEVJ";
//    self.groupId3.text = @"HAT3";
//    self.groupId4.text = @"EEE8";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)okBtn:(id)sender {
    [Common showSVProgressHUD:@""];
    NSString *groupId = [NSString stringWithFormat:@"%@%@%@%@",self.groupId1.text,self.groupId2.text,self.groupId3.text,self.groupId4.text];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *loginDic = [PHPConnection login:groupId username:self.nameTextFiled.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"loginDic = %@",loginDic);
            NSString *status = @"1";
            if (loginDic.count == 0) {
                status = @"1";
            }else{
                status = [loginDic objectForKey:@"STATUS"];
            }
            if ([status  isEqual: @"0"]) {
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                NSMutableDictionary *userDataDic = [[ud objectForKey:@"UserData_Key"] mutableCopy];
                [userDataDic setObject:[loginDic objectForKey:@"USERID"] forKey:@"UserId"];
                [userDataDic setObject:[loginDic objectForKey:@"GROUPID"] forKey:@"GroupId"];
                [ud setObject:userDataDic forKey:@"UserData_Key"];
                [ud synchronize];
                NSLog(@"UserData_Key = %@",[ud objectForKey:@"UserData_Key"]);
                
                MainViewController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                mainViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self presentViewController:mainViewController animated:YES completion:nil];
            }else{
                NSLog(@"ERRORMESSAGE = %@",[loginDic objectForKey:@"ERRORMESSAGE"]);
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エラー" message:[NSString stringWithFormat:@"%@",[loginDic objectForKey:@"ERRORMESSAGE"]] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    // cancelボタンが押された時の処理
                }]];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
            [Common dismissSVProgressHUD];
        });
    });
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.groupId1 resignFirstResponder];
    [self.groupId2 resignFirstResponder];
    [self.groupId3 resignFirstResponder];
    [self.groupId4 resignFirstResponder];
    [self.nameTextFiled resignFirstResponder];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 最大入力文字数
    int maxInputLength = 4;
    
    // 入力済みのテキストを取得
    NSMutableString *str = [textField.text mutableCopy];
    // 入力済みのテキストと入力が行われたテキストを結合
    [str replaceCharactersInRange:range withString:string];
    NSInteger srtCount = [textField.text length] + [string length];
    if (srtCount > maxInputLength) {
        // ※ここに文字数制限を超えたことを通知する処理を追加
        if (textField.tag != 104) {
            UITextField *nextText = (UITextField *)[self.view viewWithTag:textField.tag+1];
            [nextText becomeFirstResponder];
        }
        return NO;
    }
    
    return YES;
}
- (IBAction)closeBtn:(id)sender {
    //強制終了はリジェクト対象のようだ
    exit(0);
}
- (IBAction)nextBtn:(id)sender {
    Login2ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Login2ViewController"];
    viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:viewController animated:YES completion:nil];
}
@end
