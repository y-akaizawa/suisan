//
//  LoginViewController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2017/05/18.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *verLabel;
@property (weak, nonatomic) IBOutlet UITextField *groupId1;
@property (weak, nonatomic) IBOutlet UITextField *groupId2;
@property (weak, nonatomic) IBOutlet UITextField *groupId3;
@property (weak, nonatomic) IBOutlet UITextField *groupId4;
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
- (IBAction)okBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
- (IBAction)closeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)nextBtn:(id)sender;

@end
