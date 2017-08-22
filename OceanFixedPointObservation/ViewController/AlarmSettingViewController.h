//
//  AlarmSettingViewController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/04/18.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>
@import XuniInputDynamicKit;


@interface AlarmSettingViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate,XuniComboBoxDelegate, XuniDropDownDelegate>
- (IBAction)backBtn:(id)sender;

@property (nonatomic, strong)UIView *pickerBaseView;
@property (nonatomic, strong)UIPickerView *pickerView;

@property (strong, nonatomic)NSString *alarmCountStr;
@property (strong, nonatomic)NSMutableArray *alarmAry;

@property (weak, nonatomic) IBOutlet XuniComboBox *comboBoxPlace;

@property (weak, nonatomic) IBOutlet UILabel *areaNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *areaSelectBtn;
- (IBAction)areaSelectBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *rangeTextField1;
@property (weak, nonatomic) IBOutlet UITextField *rangeTextField2;
@property (weak, nonatomic) IBOutlet UILabel *rangeLabel1;
@property (weak, nonatomic) IBOutlet UILabel *rangeLabel2;
@property (weak, nonatomic) IBOutlet UITextField *countTextField;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

- (IBAction)okBtn:(id)sender;
- (IBAction)deleteBtn:(id)sender;

@end
