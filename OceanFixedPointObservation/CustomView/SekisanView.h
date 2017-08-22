//
//  SekisanView.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/06/27.
//  Copyright © 2016年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"


@interface SekisanView : UIView

+ (instancetype)SekisanView;

//パネル1
@property (weak, nonatomic) IBOutlet UIView *panel1;
@property (weak, nonatomic) IBOutlet UIView *panel1_View1;
@property (weak, nonatomic) IBOutlet UILabel *panel1_AreaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel1_DataTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel1_PointLabel;

@property (weak, nonatomic) IBOutlet UIView *panel1_View2;
@property (weak, nonatomic) IBOutlet UILabel *panel1_UnitLabel1;
@property (weak, nonatomic) IBOutlet UILabel *panel1_AssayVal1;
@property (weak, nonatomic) IBOutlet UILabel *panel1_AssayVal2;
@property (weak, nonatomic) IBOutlet UILabel *panel1_MaxValLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel1_MinValLabel;

@property (weak, nonatomic) IBOutlet UIView *panel1_View3;
@property (weak, nonatomic) IBOutlet UILabel *panel1_UnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel1_StdLabel;


//パネル2
@property (weak, nonatomic) IBOutlet UIView *panel2;
@property (weak, nonatomic) IBOutlet UIView *panel2_View1;
@property (weak, nonatomic) IBOutlet UILabel *panel2_AreaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel2_DataTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel2_PointLabel;

@property (weak, nonatomic) IBOutlet UIView *panel2_View2;
@property (weak, nonatomic) IBOutlet UILabel *panel2_UnitLabel1;
@property (weak, nonatomic) IBOutlet UILabel *panel2_AssayVal1;
@property (weak, nonatomic) IBOutlet UILabel *panel2_AssayVal2;
@property (weak, nonatomic) IBOutlet UILabel *panel2_MaxValLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel2_MinValLabel;

@property (weak, nonatomic) IBOutlet UIView *panel2_View3;
@property (weak, nonatomic) IBOutlet UILabel *panel2_UnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel2_StdLabel;

//パネル3
@property (weak, nonatomic) IBOutlet UIView *panel3;
@property (weak, nonatomic) IBOutlet UIView *panel3_View1;
@property (weak, nonatomic) IBOutlet UILabel *panel3_AreaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel3_DataTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel3_PointLabel;

@property (weak, nonatomic) IBOutlet UIView *panel3_View2;
@property (weak, nonatomic) IBOutlet UILabel *panel3_UnitLabel1;
@property (weak, nonatomic) IBOutlet UILabel *panel3_AssayVal1;
@property (weak, nonatomic) IBOutlet UILabel *panel3_AssayVal2;
@property (weak, nonatomic) IBOutlet UILabel *panel3_MaxValLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel3_MinValLabel;

@property (weak, nonatomic) IBOutlet UIView *panel3_View3;
@property (weak, nonatomic) IBOutlet UILabel *panel3_UnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel3_StdLabel;

//パネル4
@property (weak, nonatomic) IBOutlet UIView *panel4;
@property (weak, nonatomic) IBOutlet UIView *panel4_View1;
@property (weak, nonatomic) IBOutlet UILabel *panel4_AreaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel4_DataTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel4_PointLabel;

@property (weak, nonatomic) IBOutlet UIView *panel4_View2;
@property (weak, nonatomic) IBOutlet UILabel *panel4_UnitLabel1;
@property (weak, nonatomic) IBOutlet UILabel *panel4_AssayVal1;
@property (weak, nonatomic) IBOutlet UILabel *panel4_AssayVal2;
@property (weak, nonatomic) IBOutlet UILabel *panel4_MaxValLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel4_MinValLabel;

@property (weak, nonatomic) IBOutlet UIView *panel4_View3;
@property (weak, nonatomic) IBOutlet UILabel *panel4_UnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *panel4_StdLabel;


//その他ボタン、日付系
@property (weak, nonatomic) IBOutlet UIButton *mapBtn1;
- (IBAction)mapBtn1:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *mapBtn2;
- (IBAction)mapBtn2:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *mapBtn3;
- (IBAction)mapBtn3:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *mapBtn4;
- (IBAction)mapBtn4:(id)sender;

//MainViewController取得用
@property (strong, nonatomic) MainViewController *mainViewController;

@end
