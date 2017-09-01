//
//  ThreadSettingViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2017/05/25.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import "ThreadSettingViewController.h"

@interface ThreadSettingViewController ()

@end

@implementation ThreadSettingViewController
NSMutableArray *tAry;//招待できるユーザー一覧と招待状態
- (void)viewDidLoad {
    [super viewDidLoad];
    self.threadDeleteBtn.layer.cornerRadius = 10;
    self.threadDeleteBtn.clipsToBounds = true;
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
    self.threadNameLabel.text = self.threadName;
    tAry = [PHPConnection getThreadSetting:self.threadid];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-テーブルビューデリゲート
//セッション
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//セル数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tAry.count;
}
//セル高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
//セル内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *userNameView = (UILabel *)[cell viewWithTag:1];
    UISwitch *userOnOff = (UISwitch *)[cell viewWithTag:2];
    NSDictionary *tDic = [tAry objectAtIndex:indexPath.row];
    userNameView.text = [NSString stringWithFormat:@"%@",[tDic objectForKey:@"USERNAME"]];
    if ([[tDic objectForKey:@"STATUS"]  isEqual: @"0"]) {
        userOnOff.on = NO;
    }else{
        userOnOff.on = YES;
    }
    [userOnOff addTarget:self action:@selector(onChangeSwitch:) forControlEvents:UIControlEventValueChanged ];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)onChangeSwitch:(UISwitch *)sender{
    [Common showSVProgressHUD:@""];
    // 押されたボタンのセルのインデックスを取得
    UISwitch *sw = sender;
    UITableViewCell *cell = (UITableViewCell *)[[sw superview] superview];
    int row = (int)[self.userTableView indexPathForCell:cell].row;
    NSDictionary *tDic = [tAry objectAtIndex:row];
    if (!sender.on) {
        NSDictionary *dic = [PHPConnection updThreadMember:[tDic objectForKey:@"USERID"] threadid:self.threadid status:@"2"];
    }else{
        NSDictionary *dic = [PHPConnection updThreadMember:[tDic objectForKey:@"USERID"] threadid:self.threadid status:@"1"];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        tAry = [PHPConnection getThreadSetting:self.threadid];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.userTableView reloadData];
            [Common dismissSVProgressHUD];
        });
    });

}
- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)threadDeleteBtn:(id)sender {
    //アラート
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"確認" message:[NSString stringWithFormat:@"掲示板「%@」を削除します。\nよろしいですか？",self.threadName] preferredStyle:UIAlertControllerStyleAlert];
    
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
    NSDictionary *delDic = [PHPConnection delThread:self.threadid];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
