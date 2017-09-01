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
    [self.closeBtn setTitle:@"お問い合わせ" forState:UIControlStateNormal];
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
                
                MainViewController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                mainViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self presentViewController:mainViewController animated:YES completion:nil];
            }else{
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
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([newString length] >= maxInputLength) {
        if (textField.tag != 104) {
            textField.text = newString;
            UITextField *nextText = (UITextField *)[self.view viewWithTag:textField.tag+1];
            [nextText becomeFirstResponder];
        }else{
            textField.text = newString;
            [textField resignFirstResponder];
        }
        return NO;
    }
    return YES;
}

- (IBAction)closeBtn:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"確認" message:@"外部お問い合わせページに移動します。\nよろしいですか？" preferredStyle:UIAlertControllerStyleAlert];
    
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
- (IBAction)nextBtn:(id)sender {
    Login2ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Login2ViewController"];
    viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:viewController animated:YES completion:nil];
}
- (void)cancelButtonPushed{
    
}
- (void)otherButtonPushed{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.and-ex.co.jp/mail.html"]];
}
@end
