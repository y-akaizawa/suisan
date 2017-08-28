//
//  ChartViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/17.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import "ChartViewController.h"
#import "XuniFlexChartDynamicKit/XuniFlexChartDynamicKit.h"
#import "ChartData.h"
#import "GetArrayObject.h"

@import XuniCalendarDynamicKit;

#define chartTag 10001
@interface ChartViewController () <XuniCalendarDelegate>
@property (strong, nonatomic) XuniCalendar *calendar;

@end

@implementation ChartViewController

NSUserDefaults *userUD;

NSMutableArray *pickerHeikinDateAry;//平均表示データ
NSMutableArray *pickerPlaceDateAry;//場所表示データ
NSMutableArray *pickerDayDateAry;//何日前表示データ

NSMutableArray *pickerSelectHeikinDateAry;//平均表示内容データ
NSMutableArray *pickerSelectPlaceDateAry;//場所表示内容データ
NSMutableArray *pickerSelectDayDateAry;//何日前表示内容データ

NSInteger pickerSelectInt;//現在選択中の番号
int pickerInt;//現在どの項目が表示されているか 1=平均 2=場所 3=何日前か
int heikinSelectInt;//平均で選択された項目の番号
int dialogSelectInt1;//ダイアログの場所で選択された番号
int dialogSelectInt2;//ダイアログの何日前かで選択された番号

NSString *dataString;//月前半後半
NSString *sDataStr;//現在のグラフの最初の日付
NSString *eDataStr;//現在のグラフの最後の日付
BOOL dataBOOL;//最新のデータかどうか
BOOL addBOOL;//データの追加をしているかどうか

BOOL chartDiaryBool;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCalendarView];
    userUD = [NSUserDefaults standardUserDefaults];//選択中の平均値保存用
    NSString *heikin = [userUD objectForKey:@"Heikin_Key"];
    
    dataBOOL = YES;
    addBOOL = NO;
    self.rightBtn.hidden = YES;
    
    chartDiaryBool = NO;
    self.diarySwitch.on = NO;
    
    heikinSelectInt = [heikin intValue];
    dialogSelectInt1 = 0;
    dialogSelectInt2 = 0;
    
    //各データ格納
    pickerHeikinDateAry = [GetArrayObject heikinData];
    pickerSelectHeikinDateAry = [GetArrayObject heikinNumData];
    
    pickerPlaceDateAry = [GetArrayObject allAreaData];
    pickerSelectPlaceDateAry = [GetArrayObject allAreaCDData];
    
    pickerDayDateAry = [GetArrayObject yearDayData];
    pickerSelectDayDateAry = [GetArrayObject yearDayNumData];
    
    CGRect rect = [Common getScreenSize];
    self.pickerBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, rect.size.height, rect.size.width, 200)];
    self.pickerBaseView.layer.borderWidth = 2.0f;
    self.pickerBaseView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.pickerBaseView.backgroundColor = [UIColor redColor];
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, rect.size.width, 156)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerBaseView.backgroundColor = [UIColor whiteColor];
    [self.pickerBaseView addSubview:self.pickerView];
    
    self.heikinBtn.layer.borderWidth = 1.0f;
    self.heikinBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.heikinBtn.layer.cornerRadius = 5.0f;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(4,4,100, 40);
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [[UIColor blackColor] CGColor];
    button.layer.cornerRadius = 5.0f;
    [button setTitle:@"決定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(okBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerBaseView addSubview:button];
    
    
    self.dialogBaseView.frame = rect;
    self.dialogBaseView.alpha = 0;
    
    CGRect rect2 = [Common getCenterFrameWithView:self.dialogView parent:self.dialogBaseView];
    self.dialogView.frame = rect2;
    [self.dialogBaseView addSubview:self.dialogView];
    self.dialogTitleLabel.text = @"グラフに追加する情報を\n選択してください";
    self.dialogItemBtn1.layer.borderWidth = 1.0f;
    self.dialogItemBtn1.layer.borderColor = [[UIColor blackColor] CGColor];
    self.dialogItemBtn2.layer.borderWidth = 1.0f;
    self.dialogItemBtn2.layer.borderColor = [[UIColor blackColor] CGColor];
    self.dialogBaseView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    
    [self.heikinBtn setTitle:[pickerHeikinDateAry objectAtIndex:heikinSelectInt] forState:UIControlStateNormal];
    [self setChartView:@"2" heikin:[pickerSelectHeikinDateAry objectAtIndex:heikinSelectInt]];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:chartTag];
    chart.frame = CGRectMake(5, 150, self.view.bounds.size.width-10, self.view.bounds.size.height - 170);
    [chart setNeedsDisplay];
}
-(void)setCalendarView{
    self.calendar = [[XuniCalendar alloc] initWithFrame:CGRectMake(0, 0, self.CalendarView.frame.size.width, self.CalendarView.frame.size.height)];
    self.calendar.delegate = self;
    self.calendar.borderColor = [UIColor blackColor];
    //self.calendar.borderWidth = 2.0;
    
    self.calendar.headerBackgroundColor = [UIColor colorWithRed:30 / 255.0 green:30 / 255.0 blue:200 / 255.0 alpha:1.0];
    self.calendar.headerTextColor = [UIColor whiteColor];
    self.calendar.headerFont = [UIFont boldSystemFontOfSize:28.0];
    
    self.calendar.dayOfWeekFormat = XuniDayOfWeekFormatD;
    self.calendar.dayOfWeekBackgroundColor = [UIColor colorWithRed:80 / 255.0 green:80 / 255.0 blue:200 / 255.0 alpha:1.0];
    self.calendar.dayOfWeekTextColor = [UIColor whiteColor];
    self.calendar.dayOfWeekFont = [UIFont boldSystemFontOfSize:20.0];
    
    self.calendar.dayBorderColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1.0];
    self.calendar.dayBorderWidth = 2;
    
    self.calendar.adjacentDayTextColor = [UIColor grayColor];
    self.calendar.calendarFont = [UIFont systemFontOfSize:14.0];
    self.calendar.todayFont = [UIFont italicSystemFontOfSize:16.0];
    
    self.calendar.maxDate = [NSDate date];
    self.calendar.minDate = [Common minTimeString];
    
    self.calendar.selectedDate = [NSDate date];
    self.calendar.displayDate = [NSDate date];
    
    self.CalendarBaseView.hidden = YES;
    [self.CalendarView addSubview:self.calendar];
}

- (void)selectionChanged:(XuniCalendar *)sender selectedDates:(XuniCalendarRange*)selectedDates{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    // １日プラス
    components.day = 1;
    NSDate *todey = [calendar dateByAddingComponents:components toDate:sender.selectedDate options:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"JST"]];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *outputDateStr = [formatter stringFromDate:todey];
    NSLog(@"%@",outputDateStr);
    sDataStr = outputDateStr;
    [self setChartView:@"0" heikin:[pickerSelectHeikinDateAry objectAtIndex:heikinSelectInt]];
    self.CalendarBaseView.hidden = YES;
}

/*
 グラフ取得
 plusminusStr = 0でマイナス　1でプラス　2で現在の時間取得　3で現状選択されている時間
 heikin = 平均表示時の値
 */
-(void)setChartView:(NSString *)plusminusStr heikin:(NSString *)heikin{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDataDic = [ud objectForKey:@"UserData_Key"];
    NSString *tdflg = @"";
    NSString *startDate = @"";
    NSString *endDate = @"";
    
    if ([plusminusStr  isEqual: @"0"]) {
        dataString = sDataStr;
        tdflg = @"0";
    }
    if ([plusminusStr  isEqual: @"1"]) {
        dataString = eDataStr;
        tdflg = @"1";
    }
    if ([plusminusStr  isEqual: @"2"]) {
        startDate = [[Common getMinus14TimeString:[Common getTimeString]] substringWithRange:NSMakeRange(0, 8)];
        endDate = [[Common getTimeString] substringWithRange:NSMakeRange(0, 8)];
        dataString = endDate;
        tdflg = @"0";
    }
    if ([plusminusStr  isEqual: @"3"]) {
        startDate = sDataStr;
        endDate = [Common getPlus1TimeString:eDataStr];
        dataString = endDate;
        tdflg = @"0";
    }
    
    //各パネルのデータセットコード取得
    NSString *aDataSetCD = @"";
    NSString *bDataSetCD = @"";
    NSString *cDataSetCD = @"";
    NSString *dDataSetCD = @"";
    
    if ([self.pageCount  isEqual: @"1"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD1"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD2"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD3"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD4"];
    }
    if ([self.pageCount  isEqual: @"2"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD5"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD6"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD7"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD8"];
    }
    if ([self.pageCount  isEqual: @"3"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD9"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD10"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD11"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD12"];
    }
    if ([self.pageCount  isEqual: @"4"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD13"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD14"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD15"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD16"];
    }
    if ([self.pageCount  isEqual: @"5"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD17"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD18"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD19"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD20"];
    }
    if ([self.pageCount  isEqual: @"6"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD21"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD22"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD23"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD24"];
    }
    if ([self.pageCount  isEqual: @"7"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD25"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD26"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD27"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD28"];
    }
    if ([self.pageCount  isEqual: @"8"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD29"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD30"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD31"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD32"];
    }
    if ([self.pageCount  isEqual: @"9"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD33"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD34"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD35"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD36"];
    }
    if ([self.pageCount  isEqual: @"10"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD37"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD38"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD39"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD40"];
    }
    FlexChart *chart = [[FlexChart alloc] init];
    chart.delegate = self;
    
    [Common showSVProgressHUD:@""];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *eventAry1 = [PHPConnection getEventId:aDataSetCD dataSetCD2:bDataSetCD dataSetCD3:cDataSetCD dataSetCD4:dDataSetCD targetDate:dataString targetDateflg:tdflg page:@"1" page1count:@"100"];
        NSMutableArray *chartData = [ChartData chartData:dataString heikin:heikin tdflg:tdflg pageCount:self.pageCount];
        NSMutableArray *unitAry = [PHPConnection getUnitData:aDataSetCD dataSetCD2:bDataSetCD dataSetCD3:cDataSetCD dataSetCD4:dDataSetCD];
        
        NSMutableArray *valAry;
        if ([heikin  isEqual: @"0"]) {
            valAry = [PHPConnection getTableData14_2:aDataSetCD dataSetCD2:bDataSetCD dataSetCD3:cDataSetCD dataSetCD4:dDataSetCD targetDate:dataString targetDateflg:tdflg];
        }else{
            valAry = [PHPConnection getTableHeikinData14_2:aDataSetCD dataSetCD2:bDataSetCD dataSetCD3:cDataSetCD dataSetCD4:dDataSetCD targetDate:dataString targetDateflg:tdflg heikin:heikin];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableArray *eventAry = [[NSMutableArray alloc] initWithCapacity:0];
            for(NSDictionary *objData in [eventAry1 reverseObjectEnumerator]){
                [eventAry addObject: objData];
            }
            
            XuniSeries *panel1;
            XuniSeries *panel2;
            XuniSeries *panel3;
            XuniSeries *panel4;
            NSString *unitTypeStr = @"";
            NSString *unitStr = @"";
            NSDictionary *unitDic = [unitAry objectAtIndex:0];
            
            //単位が１個の場合(これまで通り)
            if ([[unitDic objectForKey:@"UNITCOUNT"]  isEqual: @"1"]) {
                //chart.bindingX = @"name";
                for( NSDictionary * userDataDic in self.userDataAry) {
                    NSString *panelNo = [userDataDic objectForKey:@"PANEL"];
                    int panelInt = [panelNo intValue];
                    int page1 = 1+(([self.pageCount intValue]-1)*4);
                    int page2 = 2+(([self.pageCount intValue]-1)*4);
                    int page3 = 3+(([self.pageCount intValue]-1)*4);
                    int page4 = 4+(([self.pageCount intValue]-1)*4);
                    
                    if (page1 == panelInt) {
                        if ([[userDataDic objectForKey:@"DATASETCD"]  isEqual: @"0"]) {
                            
                        }else{
                            panel1 = [[XuniSeries alloc] initForChart:chart binding:@"panelANum, panelANum" name:[NSString stringWithFormat:@"%@ %@ %@",[userDataDic objectForKey:@"AREANM"],[userDataDic objectForKey:@"DATATYPE"],[userDataDic objectForKey:@"POINT"]]];
                            [chart.series addObject:panel1];
                            if ([[unitDic objectForKey:@"UNIT1"] isEqual: @""]) {
                                chart.axisY.title = [NSString stringWithFormat:@"%@",[userDataDic objectForKey:@"DATATYPE"]];
                            }else{
                                chart.axisY.title = [NSString stringWithFormat:@"%@(%@)",[userDataDic objectForKey:@"DATATYPE"],[userDataDic objectForKey:@"UNIT"]];
                            }
                        }
                    }
                    if (page2 == panelInt) {
                        if ([[userDataDic objectForKey:@"DATASETCD"]  isEqual: @"0"]) {
                            
                        }else{
                            panel2 = [[XuniSeries alloc] initForChart:chart binding:@"panelBNum, panelBNum" name:[NSString stringWithFormat:@"%@ %@ %@",[userDataDic objectForKey:@"AREANM"],[userDataDic objectForKey:@"DATATYPE"],[userDataDic objectForKey:@"POINT"]]];
                            [chart.series addObject:panel2];
                            if ([[unitDic objectForKey:@"UNIT1"] isEqual: @""]) {
                                chart.axisY.title = [NSString stringWithFormat:@"%@",[userDataDic objectForKey:@"DATATYPE"]];
                            }else{
                                chart.axisY.title = [NSString stringWithFormat:@"%@(%@)",[userDataDic objectForKey:@"DATATYPE"],[userDataDic objectForKey:@"UNIT"]];
                            }
                        }
                    }
                    if (page3 == panelInt) {
                        if ([[userDataDic objectForKey:@"DATASETCD"]  isEqual: @"0"]) {
                            
                        }else{
                            panel3 = [[XuniSeries alloc] initForChart:chart binding:@"panelCNum, panelCNum" name:[NSString stringWithFormat:@"%@ %@ %@",[userDataDic objectForKey:@"AREANM"],[userDataDic objectForKey:@"DATATYPE"],[userDataDic objectForKey:@"POINT"]]];
                            [chart.series addObject:panel3];
                            if ([[unitDic objectForKey:@"UNIT1"] isEqual: @""]) {
                                chart.axisY.title = [NSString stringWithFormat:@"%@",[userDataDic objectForKey:@"DATATYPE"]];
                            }else{
                                chart.axisY.title = [NSString stringWithFormat:@"%@(%@)",[userDataDic objectForKey:@"DATATYPE"],[userDataDic objectForKey:@"UNIT"]];
                            }
                        }
                    }
                    if (page4 == panelInt) {
                        if ([[userDataDic objectForKey:@"DATASETCD"]  isEqual: @"0"]) {
                            
                        }else{
                            panel4 = [[XuniSeries alloc] initForChart:chart binding:@"panelDNum, panelDNum" name:[NSString stringWithFormat:@"%@ %@ %@",[userDataDic objectForKey:@"AREANM"],[userDataDic objectForKey:@"DATATYPE"],[userDataDic objectForKey:@"POINT"]]];
                            [chart.series addObject:panel4];
                            if ([[unitDic objectForKey:@"UNIT1"] isEqual: @""]) {
                                chart.axisY.title = [NSString stringWithFormat:@"%@",[userDataDic objectForKey:@"DATATYPE"]];
                            }else{
                                chart.axisY.title = [NSString stringWithFormat:@"%@(%@)",[userDataDic objectForKey:@"DATATYPE"],[userDataDic objectForKey:@"UNIT"]];
                            }
                        }
                    }
                    unitTypeStr = [userDataDic objectForKey:@"DATATYPE"];
                    unitStr = [userDataDic objectForKey:@"UNIT"];
                }
                chart.axisX.overlappingLabels = XuniChartOverlappingLabelsAuto;
                
                chart.axisX.majorGridVisible = false;
                chart.axisY.majorGridVisible = true;
                chart.chartType = XuniChartTypeLine;
                chart.zoomMode = XuniZoomModeX;
                
                
                //chart.selectedBorderWidth = 1.3;
                //chart.borderWidth = 0.5;
                chart.legend.orientation = XuniChartLegendOrientationVertical;
                chart.legendToggle = true;
                chart.legend.position = XuniChartLegendPositionBottom;
                
                chart.loadAnimation.animationMode = XuniAnimationModePoint;
                chart.loadAnimation.duration = 1.0;
                
                chart.tooltip.isVisible = true;
                chart.tooltip.backgroundColor = RGB(0, 128, 255);
                chart.tooltip.textColor = [UIColor whiteColor];
                chart.tooltip.gap = 10;
                chart.tooltip.showDelay = 0.5;
                chart.interpolateNulls = false;
                
                chart.axisY.majorUnit = 1.0;
                chart.axisX.majorUnit = 24.0;
                chart.itemsSource = chartData;
                chart.axisY.majorGridColor = RGB(240, 248, 255);
                chart.axisY.majorGridFill = RGB(240, 248, 255);
                
                
                if (self.diarySwitch.on == YES && chartDiaryBool == YES) {
                    NSMutableArray *eventAry1 = [[NSMutableArray alloc] initWithCapacity:0];
                    NSMutableArray *eventAry2 = [[NSMutableArray alloc] initWithCapacity:0];
                    NSMutableArray *eventAry3 = [[NSMutableArray alloc] initWithCapacity:0];
                    NSMutableArray *eventAry4 = [[NSMutableArray alloc] initWithCapacity:0];
                    int aryCount = 0;
                    for(NSDictionary *dic in eventAry){
                        if ([dic objectForKey:@"EVENTID1"] != [NSNull null]) {
                            [eventAry1 addObject:[NSString stringWithFormat:@"%d",aryCount]];
                        }
                        if ([dic objectForKey:@"EVENTID2"] != [NSNull null]) {
                            [eventAry2 addObject:[NSString stringWithFormat:@"%d",aryCount]];
                        }
                        if ([dic objectForKey:@"EVENTID3"] != [NSNull null]) {
                            [eventAry3 addObject:[NSString stringWithFormat:@"%d",aryCount]];
                        }
                        if ([dic objectForKey:@"EVENTID4"] != [NSNull null]) {
                            [eventAry4 addObject:[NSString stringWithFormat:@"%d",aryCount]];
                        }
                        aryCount++;
                    }
                    for(int i = 0; i < chartData.count; i++){
                        if ([[valAry objectAtIndex:i] objectForKey:@"VAL1"] != [NSNull null]) {
                            for(int i2 = 0; i2 < eventAry1.count; i2++){
                                if (i == [[eventAry1 objectAtIndex:i2] intValue]) {
                                    double yp = [[[valAry objectAtIndex:i] objectForKey:@"VAL1"] doubleValue];
                                    NSLog(@"VAL1 = %@",[[valAry objectAtIndex:i] objectForKey:@"VAL1"]);
                                    NSLog(@"yp = %f",yp);
                                    [chart.annotations addObject:[self setChartAnnotation:chart xp:i yp:yp eventId:[[eventAry objectAtIndex:i] objectForKey:@"EVENTID1"]chartNam:1]];
                                }
                            }
                        }
                        
                        if ([[valAry objectAtIndex:i] objectForKey:@"VAL2"] != [NSNull null]) {
                            for(int i2 = 0; i2 < eventAry2.count; i2++){
                                if (i == [[eventAry2 objectAtIndex:i2] intValue]) {
                                    double yp = [[[valAry objectAtIndex:i] objectForKey:@"VAL2"] doubleValue];
                                    [chart.annotations addObject:[self setChartAnnotation:chart xp:i yp:yp eventId:[[eventAry objectAtIndex:i] objectForKey:@"EVENTID2"]chartNam:2]];
                                }
                            }
                        }
                        
                        if ([[valAry objectAtIndex:i] objectForKey:@"VAL3"] != [NSNull null]) {
                            for(int i2 = 0; i2 < eventAry3.count; i2++){
                                if (i == [[eventAry3 objectAtIndex:i2] intValue]) {
                                    double yp = [[[valAry objectAtIndex:i] objectForKey:@"VAL3"] doubleValue];
                                    [chart.annotations addObject:[self setChartAnnotation:chart xp:i yp:yp eventId:[[eventAry objectAtIndex:i] objectForKey:@"EVENTID3"] chartNam:3]];
                                }
                            }
                        }
                        
                        if ([[valAry objectAtIndex:i] objectForKey:@"VAL4"] != [NSNull null]) {
                            for(int i2 = 0; i2 < eventAry4.count; i2++){
                                if (i == [[eventAry4 objectAtIndex:i2] intValue]) {
                                    double yp = [[[valAry objectAtIndex:i] objectForKey:@"VAL4"] doubleValue];
                                    [chart.annotations addObject:[self setChartAnnotation:chart xp:i yp:yp eventId:[[eventAry objectAtIndex:i] objectForKey:@"EVENTID4"] chartNam:4]];
                                }
                            }
                        }
                    }
                }
                //Y軸の最大値最小値を設定
                double columnMax = chart.axisY.actualMax;
                double columnMin = chart.axisY.actualMin;
                [chart.axisY setMax:[NSNumber numberWithDouble:[Common chartMax:columnMax min:columnMin]]];
                [chart.axisY setMin:[NSNumber numberWithDouble:[Common chartMax:columnMin min:columnMin]]];
                
                
            //単位が複数あった場合
            }else{
                NSLog(@"eventAry = %@",eventAry);
                NSLog(@"chartData = %@",chartData);
                //軸を増やす用のパーツを用意する。(最大4本)
                //XuniAxis *axis1;
                XuniAxis *axis2;
                XuniAxis *axis3;
                XuniAxis *axis4;
                
                chart.delegate = self;
                //chart.bindingX = @"name";
                chart.axisX.overlappingLabels = XuniChartOverlappingLabelsAuto;
                
                BOOL firstUnit = NO;//左側の軸ができたかどうか
                for( NSDictionary * userDataDic in self.userDataAry) {
                    NSString *panelNo = [userDataDic objectForKey:@"PANEL"];
                    int panelInt = [panelNo intValue];
                    int page1 = 1+(([self.pageCount intValue]-1)*4);
                    int page2 = 2+(([self.pageCount intValue]-1)*4);
                    int page3 = 3+(([self.pageCount intValue]-1)*4);
                    int page4 = 4+(([self.pageCount intValue]-1)*4);
                    
                    //NSLog(@"panelNum = %@ \n pageCount = %@",panelNum,self.pageCount);
                    if (page1 == panelInt) {
                        if ([[userDataDic objectForKey:@"DATASETCD"]  isEqual: @"0"]) {
                        }else{
                            panel1 = [[XuniSeries alloc] initForChart:chart binding:@"panelANum, panelANum" name:[NSString stringWithFormat:@"%@ %@ %@",[userDataDic objectForKey:@"AREANM"],[userDataDic objectForKey:@"DATATYPE"],[userDataDic objectForKey:@"POINT"]]];
                            [chart.series addObject:panel1];
                            if ([[unitDic objectForKey:@"UNIT1"] isEqual: @""]) {
                                chart.axisY.title = [NSString stringWithFormat:@"%@",[userDataDic objectForKey:@"DATATYPE"]];
                            }else{
                                chart.axisY.title = [NSString stringWithFormat:@"%@(%@)",[userDataDic objectForKey:@"DATATYPE"],[userDataDic objectForKey:@"UNIT"]];
                            }
                            firstUnit = YES;
                        }
                    }
                    if (page2 == panelInt) {
                        if ([[userDataDic objectForKey:@"DATASETCD"]  isEqual: @"0"]) {
                        }else{
                            panel2 = [[XuniSeries alloc] initForChart:chart binding:@"panelBNum, panelBNum" name:[NSString stringWithFormat:@"%@ %@ %@",[userDataDic objectForKey:@"AREANM"],[userDataDic objectForKey:@"DATATYPE"],[userDataDic objectForKey:@"POINT"]]];
                            if (firstUnit == NO) {
                                [chart.series addObject:panel2];
                                if ([[unitDic objectForKey:@"UNIT2"] isEqual: @""]) {
                                    chart.axisY.title = [NSString stringWithFormat:@"%@",[userDataDic objectForKey:@"DATATYPE"]];
                                }else{
                                    chart.axisY.title = [NSString stringWithFormat:@"%@(%@)",[userDataDic objectForKey:@"DATATYPE"],[userDataDic objectForKey:@"UNIT"]];
                                }
                                firstUnit = YES;
                            }else{
                                if ([unitDic objectForKey:@"UNIT1"] == [unitDic objectForKey:@"UNIT2"]) {
                                    [chart.series addObject:panel2];
                                }else{
                                    axis2 = [[XuniAxis alloc] initWithPosition:XuniPositionRight forChart:chart];
                                    axis2.majorUnit = 1;
                                    if ([[unitDic objectForKey:@"UNIT2"] isEqual: @""]) {
                                        axis2.title = [NSString stringWithFormat:@"%@",[userDataDic objectForKey:@"DATATYPE"]];
                                    }else{
                                        axis2.title = [NSString stringWithFormat:@"%@(%@)",[userDataDic objectForKey:@"DATATYPE"],[userDataDic objectForKey:@"UNIT"]];
                                    }
                                    
                                    axis2.axisLineVisible = true;
                                    axis2.majorGridVisible = NO;
                                    axis2.majorGridWidth = 1;
                                    axis2.minorTickWidth = 0;
                                    axis2.labelsVisible = YES;
                                    [chart.axesArray addObject:axis2];
                                    [panel2 setAxisY:axis2];
                                    [chart.series addObject:panel2];
                                }
                            }
                        }
                    }
                    if (page3 == panelInt) {
                        if ([[userDataDic objectForKey:@"DATASETCD"]  isEqual: @"0"]) {
                        }else{
                            panel3 = [[XuniSeries alloc] initForChart:chart binding:@"panelCNum, panelCNum" name:[NSString stringWithFormat:@"%@ %@ %@",[userDataDic objectForKey:@"AREANM"],[userDataDic objectForKey:@"DATATYPE"],[userDataDic objectForKey:@"POINT"]]];
                            if (firstUnit == NO) {
                                [chart.series addObject:panel3];
                                if ([[unitDic objectForKey:@"UNIT3"] isEqual: @""]) {
                                    chart.axisY.title = [NSString stringWithFormat:@"%@",[userDataDic objectForKey:@"DATATYPE"]];
                                }else{
                                    chart.axisY.title = [NSString stringWithFormat:@"%@(%@)",[userDataDic objectForKey:@"DATATYPE"],[userDataDic objectForKey:@"UNIT"]];
                                }
                                firstUnit = YES;
                            }else{
                                if ([unitDic objectForKey:@"UNIT1"] == [unitDic objectForKey:@"UNIT3"] || [unitDic objectForKey:@"UNIT2"] == [unitDic objectForKey:@"UNIT3"]) {
                                    [chart.series addObject:panel3];
                                }else{
                                    axis3 = [[XuniAxis alloc] initWithPosition:XuniPositionRight forChart:chart];
                                    axis3.majorUnit = 1;
                                    if ([[unitDic objectForKey:@"UNIT3"] isEqual: @""]) {
                                        axis3.title = [NSString stringWithFormat:@"%@",[userDataDic objectForKey:@"DATATYPE"]];
                                    }else{
                                        axis3.title = [NSString stringWithFormat:@"%@(%@)",[userDataDic objectForKey:@"DATATYPE"],[userDataDic objectForKey:@"UNIT"]];
                                    }
                                    axis3.axisLineVisible = true;
                                    axis3.majorGridVisible = NO;
                                    axis3.majorGridWidth = 1;
                                    axis3.minorTickWidth = 0;
                                    axis3.labelsVisible = YES;
                                    [chart.axesArray addObject:axis3];
                                    [panel3 setAxisY:axis3];
                                    [chart.series addObject:panel3];
                                }
                            }
                        }
                    }
                    if (page4 == panelInt) {
                        if ([[userDataDic objectForKey:@"DATASETCD"]  isEqual: @"0"]) {
                        }else{
                            panel4 = [[XuniSeries alloc] initForChart:chart binding:@"panelDNum, panelDNum" name:[NSString stringWithFormat:@"%@ %@ %@",[userDataDic objectForKey:@"AREANM"],[userDataDic objectForKey:@"DATATYPE"],[userDataDic objectForKey:@"POINT"]]];
                            if (firstUnit == NO) {
                                [chart.series addObject:panel4];
                                if ([[unitDic objectForKey:@"UNIT4"] isEqual: @""]) {
                                    chart.axisY.title = [NSString stringWithFormat:@"%@",[userDataDic objectForKey:@"DATATYPE"]];
                                }else{
                                    chart.axisY.title = [NSString stringWithFormat:@"%@(%@)",[userDataDic objectForKey:@"DATATYPE"],[unitDic objectForKey:@"UNIT4"]];
                                }
                                firstUnit = YES;
                            }else{
                                if ([unitDic objectForKey:@"UNIT1"] == [unitDic objectForKey:@"UNIT4"] || [unitDic objectForKey:@"UNIT2"] == [unitDic objectForKey:@"UNIT4"] || [unitDic objectForKey:@"UNIT3"] == [unitDic objectForKey:@"UNIT4"]) {
                                    [chart.series addObject:panel4];
                                }else{
                                    axis4 = [[XuniAxis alloc] initWithPosition:XuniPositionRight forChart:chart];
                                    axis4.majorUnit = 1;
                                    if ([[unitDic objectForKey:@"UNIT4"] isEqual: @""]) {
                                        axis4.title = [NSString stringWithFormat:@"%@",[userDataDic objectForKey:@"DATATYPE"]];
                                    }else{
                                        axis4.title = [NSString stringWithFormat:@"%@(%@)",[userDataDic objectForKey:@"DATATYPE"],[unitDic objectForKey:@"UNIT4"]];
                                    }
                                    axis4.axisLineVisible = true;
                                    axis4.majorGridVisible = NO;
                                    axis4.majorGridWidth = 1;
                                    axis4.minorTickWidth = 0;
                                    axis4.labelsVisible = YES;
                                    [chart.axesArray addObject:axis4];
                                    [panel4 setAxisY:axis4];
                                    [chart.series addObject:panel4];
                                }
                            }
                        }
                    }
                }
            }
            chart.chartType = XuniChartTypeLine;
            chart.zoomMode = XuniZoomModeX;
            
            //chart.selectedBorderWidth = 1.3;
            //chart.borderWidth = 0.5;
            chart.legend.orientation = XuniChartLegendOrientationVertical;
            chart.legendToggle = true;
            chart.legend.position = XuniChartLegendPositionBottom;
            
            chart.loadAnimation.animationMode = XuniAnimationModePoint;
            chart.loadAnimation.duration = 1.0;
            
            chart.tooltip.isVisible = true;
            chart.tooltip.backgroundColor = RGB(0, 128, 255);
            chart.tooltip.textColor = [UIColor whiteColor];
            chart.tooltip.gap = 10;
            chart.tooltip.showDelay = 0.5;
            chart.interpolateNulls = false;
            
            chart.axisX.majorUnit = 24.0;
            chart.itemsSource = chartData;
            chart.axisY.majorGridColor = RGB(240, 248, 255);
            chart.axisY.majorGridFill = RGB(240, 248, 255);
            chart.tag = chartTag;
            chart.bindingX = @"name2";
            NSString *sdata = [chart.xlabels objectAtIndex:0];
            NSString *edata = [chart.xlabels objectAtIndex:chart.xlabels.count-1];
            self.toolLabel.text = [NSString stringWithFormat:@"%@年%@月%@日〜%@年%@月%@日",[sdata substringWithRange:NSMakeRange(0, 4)],[sdata substringWithRange:NSMakeRange(4, 2)],[sdata substringWithRange:NSMakeRange(6, 2)],[edata substringWithRange:NSMakeRange(0, 4)],[edata substringWithRange:NSMakeRange(4, 2)],[edata substringWithRange:NSMakeRange(6, 2)]];
            self.toolLabel = [Common getMoziSizeSetting:self.toolLabel];
            sDataStr = sdata;
            eDataStr = edata;
            chart.bindingX = @"name";
            UIView *xuniView = [self.view viewWithTag: chartTag];
            [xuniView removeFromSuperview];
            
            if (self.diarySwitch.on == YES && chartDiaryBool == YES) {
                NSMutableArray *eventAry1 = [[NSMutableArray alloc] initWithCapacity:0];
                NSMutableArray *eventAry2 = [[NSMutableArray alloc] initWithCapacity:0];
                NSMutableArray *eventAry3 = [[NSMutableArray alloc] initWithCapacity:0];
                NSMutableArray *eventAry4 = [[NSMutableArray alloc] initWithCapacity:0];
                int aryCount = 0;
                for(NSDictionary *dic in eventAry){
                    if ([dic objectForKey:@"EVENTID1"] != [NSNull null]) {
                        [eventAry1 addObject:[NSString stringWithFormat:@"%d",aryCount]];
                    }
                    if ([dic objectForKey:@"EVENTID2"] != [NSNull null]) {
                        [eventAry2 addObject:[NSString stringWithFormat:@"%d",aryCount]];
                    }
                    if ([dic objectForKey:@"EVENTID3"] != [NSNull null]) {
                        [eventAry3 addObject:[NSString stringWithFormat:@"%d",aryCount]];
                    }
                    if ([dic objectForKey:@"EVENTID4"] != [NSNull null]) {
                        [eventAry4 addObject:[NSString stringWithFormat:@"%d",aryCount]];
                    }
                    aryCount++;
                }
                for(int i = 0; i < chartData.count; i++){
                    if ([[valAry objectAtIndex:i] objectForKey:@"VAL1"] != [NSNull null]) {
                        for(int i2 = 0; i2 < eventAry1.count; i2++){
                            if (i == [[eventAry1 objectAtIndex:i2] intValue]) {
                                double yp = [[[valAry objectAtIndex:i] objectForKey:@"VAL1"] doubleValue];
                                NSLog(@"VAL1 = %@",[[valAry objectAtIndex:i] objectForKey:@"VAL1"]);
                                NSLog(@"yp = %f",yp);
                                [chart.annotations addObject:[self setChartAnnotation:chart xp:i yp:yp eventId:[[eventAry objectAtIndex:i] objectForKey:@"EVENTID1"]chartNam:1]];
                            }
                        }
                    }
                    
                    if ([[valAry objectAtIndex:i] objectForKey:@"VAL2"] != [NSNull null]) {
                        for(int i2 = 0; i2 < eventAry2.count; i2++){
                            if (i == [[eventAry2 objectAtIndex:i2] intValue]) {
                                double yp = [[[valAry objectAtIndex:i] objectForKey:@"VAL2"] doubleValue];
                                [chart.annotations addObject:[self setChartAnnotation:chart xp:i yp:yp eventId:[[eventAry objectAtIndex:i] objectForKey:@"EVENTID2"]chartNam:2]];
                            }
                        }
                    }
                    
                    if ([[valAry objectAtIndex:i] objectForKey:@"VAL3"] != [NSNull null]) {
                        for(int i2 = 0; i2 < eventAry3.count; i2++){
                            if (i == [[eventAry3 objectAtIndex:i2] intValue]) {
                                double yp = [[[valAry objectAtIndex:i] objectForKey:@"VAL3"] doubleValue];
                                [chart.annotations addObject:[self setChartAnnotation:chart xp:i yp:yp eventId:[[eventAry objectAtIndex:i] objectForKey:@"EVENTID3"]chartNam:3]];
                            }
                        }
                    }
                    
                    if ([[valAry objectAtIndex:i] objectForKey:@"VAL4"] != [NSNull null]) {
                        for(int i2 = 0; i2 < eventAry4.count; i2++){
                            if (i == [[eventAry4 objectAtIndex:i2] intValue]) {
                                double yp = [[[valAry objectAtIndex:i] objectForKey:@"VAL4"] doubleValue];
                                [chart.annotations addObject:[self setChartAnnotation:chart xp:i yp:yp eventId:[[eventAry objectAtIndex:i] objectForKey:@"EVENTID4"]chartNam:4]];
                            }
                        }
                    }
                }
            }
            NSLog(@"chart.axesArray = %@",chart.axesArray);
            for (int i = 0; i < chart.axesArray.count; i++) {
                XuniAxis *imageChart = [chart.axesArray objectAtIndex:i];
                //Y軸の最大値最小値を設定
                double columnMax = imageChart.chart.axisY.actualMax;
                double columnMin = imageChart.chart.axisY.actualMin;
                NSLog(@"columnMax = %f",columnMax);
                NSLog(@"columnMin = %f",columnMin);
                [imageChart.chart.axisY setMax:[NSNumber numberWithDouble:[Common chartMax:columnMax min:columnMin]]];
                [imageChart.chart.axisY setMin:[NSNumber numberWithDouble:[Common chartMax:columnMin min:columnMin]]];
            }
            
            
            //最後の日付が今日なら進むボタンを非表示にする
            NSString *targetdate = [Common getTimeString];
            int dataInt1 = [[targetdate substringWithRange:NSMakeRange(0, 8)] intValue];
            int dataInt2 = [[eDataStr substringWithRange:NSMakeRange(0, 8)] intValue];
            if (dataInt1 == dataInt2) {
                dataBOOL = YES;
                self.rightBtn.hidden = YES;
            }
            
            BOOL getMaxBackCountFlag = [[[Common alloc] init] getMaxBackCountFlag:sdata];
            if (getMaxBackCountFlag == YES) {
                self.leftBtn.hidden = YES;
            }
            
            [self.view addSubview:chart];
            
            [self.view addSubview:self.pickerBaseView];
            [self.view bringSubviewToFront:self.dialogBaseView];
            [self.view bringSubviewToFront:self.pickerBaseView];
            [Common dismissSVProgressHUD];
        });
    });
}
//チャートのアノテーションを作成する
-(XuniChartImageAnnotation *)setChartAnnotation:(FlexChart *)chart xp:(double)xp yp:(double)yp eventId:(NSString *)eventId chartNam:(int)chartNam{
    NSDictionary *diaryDic = [[PHPConnection getDiaryEventId:eventId] objectAtIndex:0];
    
    
    // Image annotation.
    XuniAxis *imageChart = [chart.axesArray objectAtIndex:chartNam-1];
    XuniChartImageAnnotation *image = [[XuniChartImageAnnotation alloc] initWithChart:imageChart.chart];
    image.isVisible = YES;
    image.position = XuniChartAnnotationPositionCenter;
    image.attachment = XuniChartAnnotationAttachmentDataCoordinate;
    image.width = 30;
    image.height = 30;
    image.point.x = xp;
    image.point.y = yp;
    
    switch (chartNam) {
        case 1:
            image.source = [UIImage imageNamed:@"maru1.png"];
            break;
        case 2:
            image.source = [UIImage imageNamed:@"maru2.png"];
            break;
        case 3:
            image.source = [UIImage imageNamed:@"maru3.png"];
            break;
        case 4:
            image.source = [UIImage imageNamed:@"maru4.png"];
            break;
            
        default:
            break;
    }
    
    NSString *monthStr = [[diaryDic objectForKey:@"ASSAYDATE"] substringWithRange:NSMakeRange(4, 2)];
    NSString *dayStr = [[diaryDic objectForKey:@"ASSAYDATE"] substringWithRange:NSMakeRange(6, 2)];
    NSString *timeStr = [[diaryDic objectForKey:@"ASSAYDATE"] substringWithRange:NSMakeRange(8, 2)];
    if([[monthStr substringWithRange:NSMakeRange(0, 1)]  isEqual: @"0"]){
        monthStr = [dayStr substringWithRange:NSMakeRange(1, 1)];
    }
    if([[dayStr substringWithRange:NSMakeRange(0, 1)]  isEqual: @"0"]){
        dayStr = [dayStr substringWithRange:NSMakeRange(1, 1)];
    }
    if([[timeStr substringWithRange:NSMakeRange(0, 1)]  isEqual: @"0"]){
        timeStr = [timeStr substringWithRange:NSMakeRange(1, 1)];
    }
    NSString *day = [NSString stringWithFormat:@"%@年%@月%@日%@時",[[diaryDic objectForKey:@"ASSAYDATE"] substringWithRange:NSMakeRange(0, 4)],monthStr,dayStr,timeStr];
    NSString *name = [NSString stringWithFormat:@"%@ 水深%@",[diaryDic objectForKey:@"AREANM"],[diaryDic objectForKey:@"POINT"]];
    NSString *val = [NSString stringWithFormat:@"%@ %@%@",[diaryDic objectForKey:@"DATATYPE"],[diaryDic objectForKey:@"ASSAYVAL"],[diaryDic objectForKey:@"UNIT"]];
    
    image.tooltipText = [NSString stringWithFormat:@"日誌\n\n%@\n%@\n%@\n\n%@",day,name,val,[diaryDic objectForKey:@"MEMO"]];
    return image;
}

-(BOOL)tapped:(FlexChartBase *)sender point:(XuniPoint *)point
{
    FlexChart *chart = (FlexChart *)[self.view viewWithTag:chartTag];
    XuniChartHitTestInfo *hitTest = [chart hitTest:point];
    //NSLog(@"%f : %f",hitTest.point.x,hitTest.point.y);
    return false;
}

// 列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    return 1;
}

// 行数
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    if (pickerInt == 1) {
        return pickerHeikinDateAry.count;
    }
    if (pickerInt == 2) {
        return pickerPlaceDateAry.count;
    }
    if (pickerInt == 3) {
        return pickerDayDateAry.count;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = (id)view;
    
    if (!label) {
        label= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    if (pickerInt == 1) {
        label.text = [NSString stringWithFormat:@"%@",[pickerHeikinDateAry objectAtIndex:row]];
    }
    if (pickerInt == 2) {
        label.text = [NSString stringWithFormat:@"%@",[pickerPlaceDateAry objectAtIndex:row]];
    }
    if (pickerInt == 3) {
        label.text = [NSString stringWithFormat:@"%@",[pickerDayDateAry objectAtIndex:row]];
    }
    
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.backgroundColor = [UIColor blueColor]; // 追加
    
    return label;
}
//選択されたピッカービューを取得
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger selectedRow = [pickerView selectedRowInComponent:0];
    pickerSelectInt = selectedRow;
    NSLog(@"%ld", (long)selectedRow);
}

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)okBtn{
    //ピッカーダイアログの内容を決定閉じるときの処理
    [UIView transitionWithView:self.pickerBaseView
                      duration:.3
                       options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        self.pickerBaseView.transform = CGAffineTransformIdentity;
                    }
                    completion:^(BOOL finished) {
                        if (pickerInt == 1) {
                            //平均値は次回以降も使うため保存しておく
                            heikinSelectInt = (int)pickerSelectInt;
                            
                            [userUD setObject:[NSString stringWithFormat:@"%d",heikinSelectInt] forKey:@"Heikin_Key"];
                            [userUD synchronize];
                            
                            [self.heikinBtn setTitle:[pickerHeikinDateAry objectAtIndex:heikinSelectInt] forState:UIControlStateNormal];
                            if (addBOOL == NO) {
                                [self setChartView:@"3" heikin:[pickerSelectHeikinDateAry objectAtIndex:heikinSelectInt]];
                            }else{
                                [self setChartView:@"3" heikin:[pickerSelectHeikinDateAry objectAtIndex:heikinSelectInt]];
                            }
                        }
                        if (pickerInt == 2) {
                            dialogSelectInt1 = (int)pickerSelectInt;
                            [self.dialogItemBtn1 setTitle:[pickerPlaceDateAry objectAtIndex:dialogSelectInt1] forState:UIControlStateNormal];
                        }
                        if (pickerInt == 3) {
                            dialogSelectInt2 = (int)pickerSelectInt;
                            [self.dialogItemBtn2 setTitle:[pickerDayDateAry objectAtIndex:dialogSelectInt2] forState:UIControlStateNormal];
                        }
                    }];
}


- (IBAction)heikinBtn:(id)sender {
    pickerInt = 1;
    [self.pickerView reloadAllComponents];
    [UIView transitionWithView:self.pickerBaseView
                      duration:.3
                       options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        self.pickerBaseView.transform = CGAffineTransformMakeTranslation(0, -200);
                    }
                    completion:^(BOOL finished) {
                    }];
}

- (IBAction)addBtn:(id)sender {
    [self.dialogItemBtn1 setTitle:[pickerPlaceDateAry objectAtIndex:dialogSelectInt1] forState:UIControlStateNormal];
    [self.dialogItemBtn2 setTitle:[pickerDayDateAry objectAtIndex:dialogSelectInt2] forState:UIControlStateNormal];
    self.dialogBaseView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView transitionWithView:self.dialogBaseView duration:.2 options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut animations:^{
        self.dialogBaseView.alpha = 1.0;
        self.dialogBaseView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)leftBtn:(id)sender {
    dataBOOL = NO;
    self.rightBtn.hidden = NO;
    if (addBOOL == NO) {
        [self setChartView:@"0" heikin:[pickerSelectHeikinDateAry objectAtIndex:heikinSelectInt]];
    }else{
        [self setChartView:@"0" heikin:[pickerSelectHeikinDateAry objectAtIndex:heikinSelectInt]];
    }
}

- (IBAction)rightBtn:(id)sender {
    self.leftBtn.hidden = NO;
    if (addBOOL == NO) {
        [self setChartView:@"1" heikin:[pickerSelectHeikinDateAry objectAtIndex:heikinSelectInt]];
    }else{
        [self setChartView:@"1" heikin:[pickerSelectHeikinDateAry objectAtIndex:heikinSelectInt]];
    }
}

- (IBAction)dialogItemBtn1:(id)sender {
    pickerInt = 2;
    [self.pickerView reloadAllComponents];
    [UIView transitionWithView:self.pickerBaseView
                      duration:.3
                       options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        self.pickerBaseView.transform = CGAffineTransformMakeTranslation(0, -200);
                    }
                    completion:^(BOOL finished) {
                        
                    }];
}

- (IBAction)dialogItemBtn2:(id)sender {
    pickerInt = 3;
    [self.pickerView reloadAllComponents];
    [UIView transitionWithView:self.pickerBaseView
                      duration:.3
                       options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        self.pickerBaseView.transform = CGAffineTransformMakeTranslation(0, -200);
                    }
                    completion:^(BOOL finished) {
                    }];
}

- (IBAction)dialogCloseBtn:(id)sender {
    [UIView transitionWithView:self.dialogBaseView
                      duration:.3
                       options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        self.dialogBaseView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                        self.dialogBaseView.alpha = 0;
                    }
                    completion:^(BOOL finished) {
                    }];
    [UIView transitionWithView:self.pickerBaseView
                      duration:.3
                       options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        self.pickerBaseView.transform = CGAffineTransformIdentity;
                    }
                    completion:^(BOOL finished) {
                        //閉じるだけなので特になにもなし
                    }];
}

- (IBAction)dialogOKBtn:(id)sender {
    [UIView transitionWithView:self.dialogBaseView
                      duration:.3
                       options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        self.dialogBaseView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                        self.dialogBaseView.alpha = 0;
                    }
                    completion:^(BOOL finished) {
                    }];
    [UIView transitionWithView:self.pickerBaseView
                      duration:.3
                       options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        self.pickerBaseView.transform = CGAffineTransformIdentity;
                    }
                    completion:^(BOOL finished) {
                        //追加分グラフ処理
                        [self setChartView:@"3" heikin:[pickerSelectHeikinDateAry objectAtIndex:heikinSelectInt]];
                        addBOOL = YES;
                    }];
}
- (IBAction)CalendarSegment:(id)sender {
    if (self.CalendarSegment.selectedSegmentIndex == 0) {
        [self.calendar changeViewModeAsync:XuniCalendarViewModeMonth date:nil];
    }
    else if (self.CalendarSegment.selectedSegmentIndex == 1) {
        [self.calendar changeViewModeAsync:XuniCalendarViewModeYear date:nil];
    }
}
- (IBAction)today:(id)sender {
    self.calendar.selectedDate = [NSDate date];
    self.calendar.displayDate = [NSDate date];
}
- (IBAction)close:(id)sender {
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.CalendarBaseView.alpha = 0.0f;
                     } completion:^(BOOL finished){
                         self.CalendarBaseView.hidden = YES;
                     }];
}
- (IBAction)calendarBtn:(id)sender {
    [self.view bringSubviewToFront:self.CalendarBaseView];
    self.calendar.selectedDate = [NSDate date];
    self.calendar.displayDate = [NSDate date];
    self.CalendarSegment.selectedSegmentIndex = 0;
    [self.calendar changeViewModeAsync:XuniCalendarViewModeMonth date:nil];
    self.CalendarBaseView.hidden = NO;
    self.CalendarBaseView.alpha = 0.0f;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.CalendarBaseView.alpha = 1.0f;
                     } completion:^(BOOL finished){
                         
                     }];
}
- (IBAction)diarySwitch:(id)sender {
    if (self.diarySwitch.on == YES) {
        chartDiaryBool = YES;
        [self setChartView:@"3" heikin:[pickerSelectHeikinDateAry objectAtIndex:heikinSelectInt]];
    }else{
        chartDiaryBool = NO;
        [self setChartView:@"3" heikin:[pickerSelectHeikinDateAry objectAtIndex:heikinSelectInt]];
    }
}
@end
