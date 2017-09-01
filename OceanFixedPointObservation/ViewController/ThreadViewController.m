//
//  ThreadvViewController.m
//  testChat
//
//  Created by Andex_MacBook14 on 2017/04/26.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import "ThreadViewController.h"
#import "ChatViewController.h"
#import "ThreadNotificationViewController.h"
#import "ThreadSettingViewController.h"

@interface ThreadViewController ()

@end

@implementation ThreadViewController
NSMutableDictionary *roomDic;
BOOL addThread;//スレッド作成したかどうか
NSString *threadName = @"";

- (void)viewDidLoad {
    [super viewDidLoad];
    addThread = NO;
    self.addBtn.layer.cornerRadius = 10;
    self.addBtn.clipsToBounds = true;
    self.RoomTableView.delegate = self;
    self.RoomTableView.dataSource = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [Common showSVProgressHUD:@""];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.threadListAry = [PHPConnection getThreadList:@""];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.self.RoomTableView reloadData];
            [Common dismissSVProgressHUD];
        });
    });
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
    return self.threadListAry.count;
}
//セル高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
//セル内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *roomTitleView = (UILabel *)[cell viewWithTag:1];
    UILabel *roomTitleLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *updateLabel = (UILabel *)[cell viewWithTag:3];
    UILabel *adminLabel = (UILabel *)[cell viewWithTag:4];
    UIButton *mailBtn = (UIButton *)[cell viewWithTag:5];
    UIButton *settingBtn = (UIButton *)[cell viewWithTag:6];
    
    roomTitleView.clipsToBounds = YES;
    roomTitleView.layer.cornerRadius = 10.0f;
    NSDictionary *tDic = [self.threadListAry objectAtIndex:indexPath.row];
    roomTitleLabel.text = [NSString stringWithFormat:@"%@",[tDic objectForKey:@"THREADNAME"]];
    updateLabel.text = [NSString stringWithFormat:@"最終更新：　%@",[tDic objectForKey:@"LASTUPD"]];
    if ([[tDic objectForKey:@"COUNT"] intValue] > 0) {
        updateLabel.textColor = [UIColor redColor];
    }
    
    mailBtn.hidden = NO;
    if ([[tDic objectForKey:@"MANAGEID"]  isEqual:[Common getUserID]]) {
        settingBtn.hidden = NO;
    }else{
        settingBtn.hidden = YES;
    }
    
    adminLabel.text = [NSString stringWithFormat:@"管理者：%@",[tDic objectForKey:@"MANAGENAME"]];
    if ([[tDic objectForKey:@"MANAGEID"]  isEqual: @"0"]) {
        adminLabel.hidden = YES;
    }
    BOOL is_exists = [Common checkErrorMessage:tDic];
    if (is_exists == YES) {
    }else{
    }
    
    [mailBtn addTarget:self action:@selector(mailSetting:event:) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn addTarget:self action:@selector(thSeting:event:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *roomTitle = @"";
    NSString *threadId = @"";
    NSString *manageId = @"";
    NSString *adminName = @"";
    NSMutableDictionary *tDic = [self.threadListAry objectAtIndex:indexPath.row];
    roomTitle = [tDic objectForKey:@"THREADNAME"];
    threadId = [tDic objectForKey:@"THREADID"];
    manageId = [tDic objectForKey:@"MANAGEID"];
    adminName = [tDic objectForKey:@"MANAGENAME"];
    ChatViewController *chatView = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
    chatView.roomName = roomTitle;
    chatView.threadId = threadId;
    chatView.manageId = manageId;
    chatView.adminName = adminName;
    chatView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:chatView animated:YES completion:nil];
}

- (IBAction)backBtn:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)addBtn:(id)sender{
    NSDictionary *checkThread = [PHPConnection chkThreadCount];
    if ([Common checkErrorMessage:checkThread] == YES) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エラー" message:[NSString stringWithFormat:@"%@",[checkThread objectForKey:@"ERRORMESSAGE"]] preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // cancelボタンが押された時の処理
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新しい掲示板の作成" message:@"掲示板の名称を入力して、作成ボタンを押してください。\n\n※注意事項\nこの掲示板の管理者はあなたとなります。\n管理者はこの掲示板を閲覧、書込できるユーザーの管理および、掲示板を削除することができます。\n１ユーザーにつき、２つまで掲示板を作成できます。\nすでに２つ掲示板を作成している場合は、作成してある掲示板を削除することで新たに作成することが可能です。" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"作成"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    [self addThread];
                                                }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"キャンセル"
                                                  style:UIAlertActionStyleCancel
                                                handler:^(UIAlertAction *action) {
                                                    
                                                }]];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"掲示板タイトル";
            textField.delegate = self;
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    threadName = textField.text;
    
}
-(void)addThread{
    NSDictionary *dic = [PHPConnection addThread:threadName];
    if ([Common checkErrorMessage:dic] == YES) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エラー" message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ERRORMESSAGE"]] preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // cancelボタンが押された時の処理
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        self.threadListAry = [PHPConnection getThreadList:@""];
        [self.RoomTableView reloadData];
    }
}

- (void)mailSetting:(id)sender event:(UIEvent *)event{
    // 押されたボタンのセルのインデックスを取得
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self.RoomTableView];
    NSIndexPath *indexPath = [self.RoomTableView indexPathForRowAtPoint:point];
    NSDictionary *tDic = [self.threadListAry objectAtIndex:indexPath.row];
    
    ThreadNotificationViewController *nextView = [self.storyboard instantiateViewControllerWithIdentifier:@"ThreadNotificationViewController"];
    nextView.threadid = [tDic objectForKey:@"THREADID"];
    nextView.threadName = [tDic objectForKey:@"THREADNAME"];
    nextView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:nextView animated:YES completion:nil];
}

- (void)thSeting:(id)sender event:(UIEvent *)event{
    // 押されたボタンのセルのインデックスを取得
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self.RoomTableView];
    NSIndexPath *indexPath = [self.RoomTableView indexPathForRowAtPoint:point];
    NSDictionary *tDic = [self.threadListAry objectAtIndex:indexPath.row];
    
    ThreadSettingViewController *nextView = [self.storyboard instantiateViewControllerWithIdentifier:@"ThreadSettingViewController"];
    nextView.threadid = [tDic objectForKey:@"THREADID"];
    nextView.threadName = [tDic objectForKey:@"THREADNAME"];
    nextView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:nextView animated:YES completion:nil];
}

@end
