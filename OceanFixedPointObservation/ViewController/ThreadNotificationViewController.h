//
//  ThreadNotificationViewController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2017/05/25.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreadNotificationViewController : UIViewController

@property (strong, nonatomic) NSString *threadid;
@property (strong, nonatomic) NSString *threadName;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *threadNameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *topSwitch;
- (IBAction)topSwitch:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *mailSwitch;
- (IBAction)mailSwitch:(id)sender;

@end
