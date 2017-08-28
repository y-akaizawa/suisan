//
//  LoginCheckViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2017/07/06.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import "LoginCheckViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"

@interface LoginCheckViewController ()

@end

@implementation LoginCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataGet];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)alert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エラー" message:[NSString stringWithFormat:@"通信に失敗しました。ネットワークの接続状態をご確認ください。"] preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"再試行" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // cancelボタンが押された時の処理
        [self dataGet];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)dataGet{
    [Common showSVProgressHUD:@""];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *loginCheckDic = [PHPConnection loginCheck];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (loginCheckDic == nil) {
                [self alert];
            }
            NSString *status = @"1";
            if (loginCheckDic.count == 0) {
                status = @"1";
            }else{
                status = [loginCheckDic objectForKey:@"STATUS"];
            }
            if ([status  isEqual: @"0"]) {
                MainViewController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                mainViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self presentViewController:mainViewController animated:YES completion:nil];
            }else{
                LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                loginViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self presentViewController:loginViewController animated:YES completion:nil];
            }
            [Common dismissSVProgressHUD];
        });
    });
}
@end
