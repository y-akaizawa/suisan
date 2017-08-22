//
//  MailSettingViewController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/04/13.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MailSettingViewController : UIViewController
<
UITextFieldDelegate,
UIPickerViewDelegate,
UIPickerViewDataSource
>
- (IBAction)backBtn:(id)sender;

@property (strong, nonatomic) NSString *mailaddrStr;
@property (strong, nonatomic) NSString *timeStr1;
@property (strong, nonatomic) NSString *timeStr2;
@property (strong, nonatomic) NSString *timeStr3;
@property (strong, nonatomic) NSString *timeStr4;

@property (nonatomic, strong) UIView *pickerBaseView;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UILabel *pickerLabel;

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel2;
@property (weak, nonatomic) IBOutlet UISwitch *emailSwitch;
- (IBAction)emailSwitch:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UIButton *timeSetBtn;
- (IBAction)timeSetBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *timeSetLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

- (IBAction)okBtn:(id)sender;
- (IBAction)deleteBtn:(id)sender;

@end
