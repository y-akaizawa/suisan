//
//  ChartViewController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/17.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XuniFlexChartDynamicKit/XuniFlexChartDynamicKit.h>

@interface ChartViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource, FlexChartDelegate>
@property (nonatomic, strong)NSMutableArray *userDataAry;
@property (strong, nonatomic) NSString *pageCount;
- (IBAction)backBtn:(id)sender;

@property (nonatomic, strong)UIView *pickerBaseView;
@property (nonatomic, strong)UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UIButton *heikinBtn;
- (IBAction)heikinBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)addBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
- (IBAction)leftBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *toolLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
- (IBAction)rightBtn:(id)sender;


//ダイアログ
@property (weak, nonatomic) IBOutlet UIView *dialogBaseView;
@property (weak, nonatomic) IBOutlet UIView *dialogView;
@property (weak, nonatomic) IBOutlet UILabel *dialogTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *dialogItemBtn1;
- (IBAction)dialogItemBtn1:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dialogItemBtn2;
- (IBAction)dialogItemBtn2:(id)sender;


- (IBAction)dialogCloseBtn:(id)sender;
- (IBAction)dialogOKBtn:(id)sender;

//カレンダー
@property (weak, nonatomic) IBOutlet UIView *CalendarBaseView;
@property (weak, nonatomic) IBOutlet UIView *CalendarView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *CalendarSegment;
- (IBAction)CalendarSegment:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *today;
- (IBAction)today:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *close;
- (IBAction)close:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *calendarBtn;
- (IBAction)calendarBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *diarySwitch;
- (IBAction)diarySwitch:(id)sender;


@end
