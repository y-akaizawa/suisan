//
//  Login2ViewController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2017/07/12.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login2ViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userId1;
@property (weak, nonatomic) IBOutlet UITextField *userId2;
@property (weak, nonatomic) IBOutlet UITextField *userId3;
@property (weak, nonatomic) IBOutlet UITextField *userId4;
@property (weak, nonatomic) IBOutlet UITextField *userId5;

@property (weak, nonatomic) IBOutlet UITextField *groupId1;
@property (weak, nonatomic) IBOutlet UITextField *groupId2;
@property (weak, nonatomic) IBOutlet UITextField *groupId3;
@property (weak, nonatomic) IBOutlet UITextField *groupId4;

@property (weak, nonatomic) IBOutlet UIButton *okBtn;
- (IBAction)okBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
- (IBAction)closeBtn:(id)sender;

@end
