//
//  ThreadNotificationViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2017/05/25.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import "ThreadNotificationViewController.h"

@interface ThreadNotificationViewController ()

@end

@implementation ThreadNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.threadNameLabel.text = self.threadName;
    NSDictionary *getThreadMailDic = [PHPConnection getThreadMail:self.threadid];
    self.topSwitch.on = NO;
    if ([[getThreadMailDic objectForKey:@"NOTIFICATION"]  isEqual: @"0"]) {
        self.mailSwitch.on = NO;
    }else{
        self.mailSwitch.on = YES;
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [[ud objectForKey:@"NewNotification_Key"] mutableCopy];
    if ([ary containsObject:self.threadid]) {
        self.topSwitch.on = YES;
    }else{
        self.topSwitch.on = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)topSwitch:(id)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [[ud objectForKey:@"NewNotification_Key"] mutableCopy];
    if (self.topSwitch.on) {
        [ary addObject:self.threadid];
    }else{
        [ary removeObject:self.threadid];
    }
    [ud setObject:ary forKey:@"NewNotification_Key"];
    [ud synchronize];
}
- (IBAction)mailSwitch:(id)sender {
    if (self.mailSwitch.on) {
        NSDictionary *dic = [PHPConnection updThreadMail:self.threadid status:@"1"];
    }else{
        NSDictionary *dic = [PHPConnection updThreadMail:self.threadid status:@"2"];
    }
}
@end
