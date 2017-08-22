//
//  TableViewController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/17.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"

@interface TableViewController : UIViewController
<FlexGridDelegate>

@property (nonatomic, strong) NSMutableArray *userDataAry;
@property (strong, nonatomic) NSString *pageCount;

@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UILabel *toolLabel;
@property (weak, nonatomic) IBOutlet UIView *toolBaseView;
@property (weak, nonatomic) IBOutlet UIView *itemNameView;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
- (IBAction)leftBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
- (IBAction)rightBtn:(id)sender;

- (IBAction)backBtn:(id)sender;

@property (strong, nonatomic) FlexGrid *flex;

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
@property (weak, nonatomic) IBOutlet UISwitch *tableDiaryBtn;
- (IBAction)tableDiaryBtn:(id)sender;




@end
