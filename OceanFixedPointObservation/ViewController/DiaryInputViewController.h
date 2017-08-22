//
//  DiaryInputViewController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2017/05/23.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>
@import XuniInputDynamicKit;

@interface DiaryInputViewController : UIViewController
<XuniComboBoxDelegate, XuniDropDownDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet XuniComboBox *comboBoxYear;
@property (weak, nonatomic) IBOutlet XuniComboBox *comboBoxMonth;
@property (weak, nonatomic) IBOutlet XuniComboBox *comboBoxDay;
@property (weak, nonatomic) IBOutlet XuniComboBox *comboBoxTime;
@property (weak, nonatomic) IBOutlet XuniComboBox *comboBoxPlace;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *inputScrollView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (assign, nonatomic) int diaryFlag;//0新規、1更新
@property (strong, nonatomic) NSMutableDictionary *eventDic;
@property (strong, nonatomic) NSString *eventId;

@property (weak, nonatomic) IBOutlet UITextView *diaryTextView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)addBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
- (IBAction)deleteBtn:(id)sender;

@end
