//
//  SekisanSettingViewController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/04/18.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>
@import XuniInputDynamicKit;

@interface SekisanSettingViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate,XuniComboBoxDelegate, XuniDropDownDelegate,UITextViewDelegate>

@property (nonatomic, strong)UIView *pickerBaseView;
@property (nonatomic, strong)UIPickerView *pickerView;

@property (strong, nonatomic)NSString *sekisanCountStr;
@property (strong, nonatomic)NSMutableArray *sekisanAry;

@property (weak, nonatomic) IBOutlet UILabel *areaNameLabel;

@property (weak, nonatomic) IBOutlet XuniComboBox *comboBoxPlace;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel1;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel2;

//カレンダー
@property (weak, nonatomic) IBOutlet UIButton *timeFromBtn;
- (IBAction)timeFromBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *timeToBtn;
- (IBAction)timeToBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *CalendarBaseView;
@property (weak, nonatomic) IBOutlet UIView *CalendarView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *CalendarSegment;
- (IBAction)CalendarSegment:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *today;
- (IBAction)today:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *close;
- (IBAction)close:(id)sender;




@property (weak, nonatomic) IBOutlet UITextField *referenceTextField;
@property (weak, nonatomic) IBOutlet UITextField *criterionTextField;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

- (IBAction)okBtn:(id)sender;
- (IBAction)previewBtn:(id)sender;
- (IBAction)deleteBtn:(id)sender;
- (IBAction)backBtn:(id)sender;

//積算値プレビュー
@property (strong, nonatomic) UIView *panel_Base_View;
@property (weak, nonatomic) IBOutlet UIView *previewPanel;

@property (weak, nonatomic) IBOutlet UIView *panel_View1;
@property (weak, nonatomic) IBOutlet UILabel *panel_AreaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel_DataTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel_PointLabel;

@property (weak, nonatomic) IBOutlet UIView *panel_View2;
@property (weak, nonatomic) IBOutlet UILabel *panel_UnitLabel1;
@property (weak, nonatomic) IBOutlet UILabel *panel_AssayVal1;
@property (weak, nonatomic) IBOutlet UILabel *panel_AssayVal2;
@property (weak, nonatomic) IBOutlet UILabel *panel_MaxValLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel_MinValLabel;

@property (weak, nonatomic) IBOutlet UIView *panel_View3;
@property (weak, nonatomic) IBOutlet UILabel *panel_UnitLabel2;
@property (weak, nonatomic) IBOutlet UILabel *panel_StdLabel;

- (IBAction)panelCloseBtn:(id)sender;



@end
