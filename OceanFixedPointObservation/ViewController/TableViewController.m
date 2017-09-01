//
//  TableViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/17.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import "TableViewController.h"
#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"
#import "TableData1.h"

@import XuniCalendarDynamicKit;

@interface TableViewController () <XuniCalendarDelegate>
@property (strong, nonatomic) XuniCalendar *calendar;

@end

@implementation TableViewController

NSString *datastr;//最終的な値
NSString *startDataStr;//現在の表の最初の日付
NSString *endDataStr;//現在の表の最後の日付
BOOL newDataBOOL;//最新のデータかどうか
BOOL tableDiaryBool;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCalendarView];
    
    CGRect rect = [Common getScreenSize];
    self.toolView.frame = CGRectMake(0, 64, rect.size.width, 44);
    self.toolBaseView.frame = CGRectMake(rect.size.width/2-self.toolBaseView.frame.size.width/2, 0, self.toolBaseView.frame.size.width, self.toolBaseView.frame.size.height);
    newDataBOOL = YES;
    //スイッチデフォルトをoff
    tableDiaryBool = NO;
    self.tableDiaryBtn.on = NO;
    
    self.rightBtn.hidden = YES;
    [self setItemNameLabel];
    [self setTable:@"2"];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tStartDate"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tEndDate"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //self.flex = (FlexGrid*)[self.view viewWithTag:1];
    [self.view sendSubviewToBack:self.flex];
    CGFloat space = [UIApplication sharedApplication].statusBarFrame.size.height+44+44+20;
    
    self.flex.frame = CGRectMake(-33.5, space, self.view.bounds.size.width+35, self.view.bounds.size.height - space);
    [self.flex setNeedsDisplay];
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
    
    // １日マイナス
    components.day = 1;
    NSDate *todey = [calendar dateByAddingComponents:components toDate:sender.selectedDate options:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"JST"]];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *outputDateStr = [formatter stringFromDate:todey];
    startDataStr = outputDateStr;
    [self setTable:@"0"];
    self.CalendarBaseView.hidden = YES;
}

-(void)setItemNameLabel{
    CGRect rect = [Common getScreenSize];
    float itemNameWidth = rect.size.width/5;
    UIFont *font;
    //5sなどのサイズ
    if (rect.size.width == 320) {
        font = [UIFont fontWithName:@"HiraKakuProN-W6" size:13];
    }
    //6のサイズ
    if (rect.size.width == 375) {
        font = [UIFont fontWithName:@"HiraKakuProN-W6" size:15];
    }
    //6プラスのサイズ
    if (rect.size.width == 414) {
        font = [UIFont fontWithName:@"HiraKakuProN-W6" size:17];
    }
    
    UIColor *labelColor = RGB(0, 0, 204);
    UILabel *itemNameLabel1 = [[UILabel alloc] init];
    itemNameLabel1.frame = CGRectMake(0, 0, itemNameWidth+1, 50);
    itemNameLabel1.font = font;
    itemNameLabel1.backgroundColor = labelColor;
    itemNameLabel1.textColor = [UIColor whiteColor];
    itemNameLabel1.numberOfLines = 0;
    itemNameLabel1.text = @"\n 日付";
    [self.itemNameView addSubview:itemNameLabel1];
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDataDic = [ud objectForKey:@"UserData_Key"];
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
    
    
    for( NSDictionary * userDataDic in self.userDataAry) {
        NSString *panelNo = [userDataDic objectForKey:@"PANEL"];
        int panelInt = [panelNo intValue];
        int page1 = 1+(([self.pageCount intValue]-1)*4);
        int page2 = 2+(([self.pageCount intValue]-1)*4);
        int page3 = 3+(([self.pageCount intValue]-1)*4);
        int page4 = 4+(([self.pageCount intValue]-1)*4);
        
        if (page1 == panelInt) {
            UILabel *itemNameLabel = [[UILabel alloc] init];
            itemNameLabel.frame = CGRectMake(itemNameWidth+2, 0, itemNameWidth-1, 50);
            itemNameLabel.font = font;
            itemNameLabel.backgroundColor = labelColor;
            itemNameLabel.textColor = [UIColor whiteColor];
            itemNameLabel.numberOfLines = 3;
            itemNameLabel = [Common getMoziSizeSetting:itemNameLabel];
            if ([aDataSetCD  isEqual: @"0"]) {
                itemNameLabel.text = @"";
                
            }else{
                itemNameLabel.text = [NSString stringWithFormat:@" %@\n %@\n %@",
                                      [userDataDic objectForKey:@"AREANM"],
                                      [userDataDic objectForKey:@"DATATYPE"],
                                      [userDataDic objectForKey:@"POINT"]];
            }
            [self.itemNameView addSubview:itemNameLabel];
        }
        if (page2 == panelInt) {
            UILabel *itemNameLabel = [[UILabel alloc] init];
            itemNameLabel.frame = CGRectMake(itemNameWidth*2+2, 0, itemNameWidth-1, 50);
            itemNameLabel.font = font;
            itemNameLabel.backgroundColor = labelColor;
            itemNameLabel.textColor = [UIColor whiteColor];
            itemNameLabel.numberOfLines = 3;
            itemNameLabel = [Common getMoziSizeSetting:itemNameLabel];
            if ([bDataSetCD  isEqual: @"0"]) {
                itemNameLabel.text = @"";
            }else{
                itemNameLabel.text = [NSString stringWithFormat:@" %@\n %@\n %@",
                                      [userDataDic objectForKey:@"AREANM"],
                                      [userDataDic objectForKey:@"DATATYPE"],
                                      [userDataDic objectForKey:@"POINT"]];
            }
            [self.itemNameView addSubview:itemNameLabel];
        }
        if (page3 == panelInt) {
            UILabel *itemNameLabel = [[UILabel alloc] init];
            itemNameLabel.frame = CGRectMake(itemNameWidth*3+2, 0, itemNameWidth-1, 50);
            itemNameLabel.font = font;
            itemNameLabel.backgroundColor = labelColor;
            itemNameLabel.textColor = [UIColor whiteColor];
            itemNameLabel.numberOfLines = 3;
            itemNameLabel = [Common getMoziSizeSetting:itemNameLabel];
            if ([cDataSetCD  isEqual: @"0"]) {
                itemNameLabel.text = @"";
            }else{
                itemNameLabel.text = [NSString stringWithFormat:@" %@\n %@\n %@",
                                      [userDataDic objectForKey:@"AREANM"],
                                      [userDataDic objectForKey:@"DATATYPE"],
                                      [userDataDic objectForKey:@"POINT"]];
            }
            [self.itemNameView addSubview:itemNameLabel];
        }
        if (page4 == panelInt) {
            UILabel *itemNameLabel = [[UILabel alloc] init];
            itemNameLabel.frame = CGRectMake(itemNameWidth*4+2, 0, itemNameWidth, 50);
            itemNameLabel.font = font;
            itemNameLabel.backgroundColor = labelColor;
            itemNameLabel.textColor = [UIColor whiteColor];
            itemNameLabel.numberOfLines = 3;
            itemNameLabel = [Common getMoziSizeSetting:itemNameLabel];
            if ([dDataSetCD  isEqual: @"0"]) {
                itemNameLabel.text = @"";
            }else{
                itemNameLabel.text = [NSString stringWithFormat:@" %@\n %@\n %@",
                                      [userDataDic objectForKey:@"AREANM"],
                                      [userDataDic objectForKey:@"DATATYPE"],
                                      [userDataDic objectForKey:@"POINT"]];
            }
            [self.itemNameView addSubview:itemNameLabel];
        }
    }
}

/*
 表取得
 plusminusStr = 0でマイナス　1でプラス　2で現在の時間取得　3で現状選択されている時間
 */
-(void)setTable:(NSString *)plusminusStr{
    [self.flex removeFromSuperview];
    self.flex = [[FlexGrid alloc] init];
    self.flex.selectionMode = GridSelectionModeCell;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDataDic = [ud objectForKey:@"UserData_Key"];
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
    
    NSString *tdflg = @"";
    NSString *startDate = @"";
    NSString *endDate = @"";
    
    if ([plusminusStr  isEqual: @"0"]) {
        datastr = startDataStr;
        tdflg = @"0";
    }
    if ([plusminusStr  isEqual: @"1"]) {
        datastr = endDataStr;
        tdflg = @"1";
    }
    if ([plusminusStr  isEqual: @"2"]) {
        startDate = [[Common getMinus14TimeString:[Common getTimeString]] substringWithRange:NSMakeRange(0, 8)];
        endDate = [[Common getTimeString] substringWithRange:NSMakeRange(0, 8)];
        datastr = endDate;
        tdflg = @"0";
    }
    if ([plusminusStr  isEqual: @"3"]) {
        startDate = startDataStr;
        endDate = [Common getPlus1TimeString:endDataStr];
        datastr = endDate;
        tdflg = @"0";
    }
    [Common showSVProgressHUD:@""];
    __block TableViewController *blockself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *eventAry = [PHPConnection getEventId:aDataSetCD dataSetCD2:bDataSetCD dataSetCD3:cDataSetCD dataSetCD4:dDataSetCD targetDate:datastr targetDateflg:tdflg page:@"1" page1count:@"100"];
        
        NSMutableArray *ary = [PHPConnection getTableData14_2:aDataSetCD dataSetCD2:bDataSetCD dataSetCD3:cDataSetCD dataSetCD4:dDataSetCD targetDate:datastr targetDateflg:tdflg];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.flex.columnHeaderBackgroundColor = [UIColor blueColor];
            self.flex.columnHeaderTextColor = [UIColor whiteColor];
            
            self.flex.columnHeaderFont = [UIFont boldSystemFontOfSize:self.flex.columnHeaderFont.pointSize];
            self.flex.autoGenerateColumns = false;
            CGRect rect = [Common getScreenSize];
            float columnWidth = rect.size.width/5;
            
            GridColumn *column1 = [[GridColumn alloc] init];
            column1.binding = @"dayStr";
            column1.header = @"日付";
            column1.width = columnWidth;
            [self.flex.columns addObject:column1];
            
            GridColumn *column2 = [[GridColumn alloc] init];
            GridColumn *column3 = [[GridColumn alloc] init];
            GridColumn *column4 = [[GridColumn alloc] init];
            GridColumn *column5 = [[GridColumn alloc] init];
            
            NSMutableParagraphStyle *style = NSParagraphStyle.defaultParagraphStyle.mutableCopy;
            style.alignment = kCTCenterTextAlignment;
            
            for( NSDictionary * userDataDic in self.userDataAry) {
                NSString *panelNo = [userDataDic objectForKey:@"PANEL"];
                if ([panelNo  isEqual: @"1"]) {
                    if ([aDataSetCD  isEqual: @"0"]) {
                        column2.binding = @"panelAStr";
                        column2.header = @"";
                        column2.width = columnWidth;
                        [self.flex.columns addObject:column2];
                    }else{
                        column2.binding = @"panelAStr";
                        column2.header = [NSString stringWithFormat:@"%@\n%@ %@",
                                          [userDataDic objectForKey:@"AREANM"],
                                          [userDataDic objectForKey:@"DATATYPE"],
                                          [userDataDic objectForKey:@"POINT"]];
                        column2.width = columnWidth;
                        [self.flex.columns addObject:column2];
                    }
                }
                if ([panelNo  isEqual: @"2"]) {
                    if ([bDataSetCD  isEqual: @"0"]) {
                        column3.binding = @"panelBStr";
                        column3.header = @"";
                        column3.width = columnWidth;
                        [self.flex.columns addObject:column3];
                    }else{
                        column3.binding = @"panelBStr";
                        column3.header = [NSString stringWithFormat:@"%@\n%@ %@",
                                          [userDataDic objectForKey:@"AREANM"],
                                          [userDataDic objectForKey:@"DATATYPE"],
                                          [userDataDic objectForKey:@"POINT"]];
                        column3.width = columnWidth;
                        [self.flex.columns addObject:column3];
                    }
                }
                if ([panelNo  isEqual: @"3"]) {
                    if ([cDataSetCD  isEqual: @"0"]) {
                        column4.binding = @"panelCStr";
                        column4.header = @"";
                        column4.width = columnWidth;
                        [self.flex.columns addObject:column4];
                    }else{
                        column4.binding = @"panelCStr";
                        column4.header = [NSString stringWithFormat:@"%@\n%@ %@",
                                          [userDataDic objectForKey:@"AREANM"],
                                          [userDataDic objectForKey:@"DATATYPE"],
                                          [userDataDic objectForKey:@"POINT"]];
                        column4.width = columnWidth;
                        [self.flex.columns addObject:column4];
                    }
                }
                if ([panelNo  isEqual: @"4"]) {
                    if ([dDataSetCD  isEqual: @"0"]) {
                        column5.binding = @"panelDStr";
                        column5.header = @"";
                        column5.width = columnWidth;
                        [self.flex.columns addObject:column5];
                    }else{
                        column5.binding = @"panelDStr";
                        column5.header = [NSString stringWithFormat:@"%@\n%@ %@",
                                          [userDataDic objectForKey:@"AREANM"],
                                          [userDataDic objectForKey:@"DATATYPE"],
                                          [userDataDic objectForKey:@"POINT"]];
                        column5.width = columnWidth;
                        [self.flex.columns addObject:column5];
                    }
                }
            }
            //背景カラー
            self.flex.backgroundColor = RGB(255, 255, 255);//デフォ
            self.flex.alternatingRowBackgroundColor = RGB(238, 238, 238);//奇数行
            UIFont *font;
            //5sなどのサイズ
            if (rect.size.width == 320) {
                font = [UIFont fontWithName:@"HiraKakuProN-W6" size:13];
            }
            //6のサイズ
            if (rect.size.width == 375) {
                font = [UIFont fontWithName:@"HiraKakuProN-W6" size:15];
            }
            //6プラスのサイズ
            if (rect.size.width == 414) {
                font = [UIFont fontWithName:@"HiraKakuProN-W6" size:17];
            }
            self.flex.font = font;
            
            self.flex.isReadOnly = true;
            self.flex.delegate = self;
            self.flex.tag = 1;
            self.flex.itemsSource = [TableData1 getTableData:ary];
            
            //UIView *xuniView = [self.view viewWithTag: 1];
            [self.flex removeFromSuperview];
            
            if (self.tableDiaryBtn.on == YES && tableDiaryBool == YES) {
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
                [self.flex.flexGridFormatItem addHandler:^(XuniEventContainer<GridFormatItemEventArgs *> *eventContainer) {
                    if (eventContainer.eventArgs.panel.cellType == GridCellTypeCell) {
                        FlexGrid *g = blockself.flex;
                        GridColumn *col = [g.columns objectAtIndex:eventContainer.eventArgs.col];
                        if ([col.binding isEqualToString:@"panelAStr"]) {
                            //各セルの数値取得(今後数値による文字色変更に使うかもしれない)
                            //                        NSNumber *n = (NSNumber *)[eventContainer.eventArgs.panel getCellDataForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col formatted:NO];
                            for(NSString *str in eventAry1){
                                if (eventContainer.eventArgs.row == [str intValue]) {
                                    CGRect r = [eventContainer.eventArgs.panel getCellRectForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col];
                                    CGContextSetFillColorWithColor(eventContainer.eventArgs.context, [UIColor colorWithRed:0.23 green:0.50 blue:0.90 alpha:1.0].CGColor);
                                    CGContextFillRect(eventContainer.eventArgs.context, r);
                                    [eventContainer.eventArgs.panel.textAttributes setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
                                }
                            }
                        }
                        if ([col.binding isEqualToString:@"panelBStr"]) {
                            //各セルの数値取得(今後数値による文字色変更に使うかもしれない)
                            //                        NSNumber *n = (NSNumber *)[eventContainer.eventArgs.panel getCellDataForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col formatted:NO];
                            for(NSString *str in eventAry2){
                                if (eventContainer.eventArgs.row == [str intValue]) {
                                    CGRect r = [eventContainer.eventArgs.panel getCellRectForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col];
                                    CGContextSetFillColorWithColor(eventContainer.eventArgs.context, [UIColor colorWithRed:0.23 green:0.50 blue:0.90 alpha:1.0].CGColor);
                                    CGContextFillRect(eventContainer.eventArgs.context, r);
                                    [eventContainer.eventArgs.panel.textAttributes setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
                                }
                            }
                        }
                        if ([col.binding isEqualToString:@"panelCStr"]) {
                            //各セルの数値取得(今後数値による文字色変更に使うかもしれない)
                            //                        NSNumber *n = (NSNumber *)[eventContainer.eventArgs.panel getCellDataForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col formatted:NO];
                            for(NSString *str in eventAry3){
                                if (eventContainer.eventArgs.row == [str intValue]) {
                                    CGRect r = [eventContainer.eventArgs.panel getCellRectForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col];
                                    CGContextSetFillColorWithColor(eventContainer.eventArgs.context, [UIColor colorWithRed:0.23 green:0.50 blue:0.90 alpha:1.0].CGColor);
                                    CGContextFillRect(eventContainer.eventArgs.context, r);
                                    [eventContainer.eventArgs.panel.textAttributes setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
                                }
                            }
                        }
                        if ([col.binding isEqualToString:@"panelDStr"]) {
                            //各セルの数値取得(今後数値による文字色変更に使うかもしれない)
                            //                        NSNumber *n = (NSNumber *)[eventContainer.eventArgs.panel getCellDataForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col formatted:NO];
                            for(NSString *str in eventAry4){
                                if (eventContainer.eventArgs.row == [str intValue]) {
                                    CGRect r = [eventContainer.eventArgs.panel getCellRectForRow:eventContainer.eventArgs.row inColumn:eventContainer.eventArgs.col];
                                    CGContextSetFillColorWithColor(eventContainer.eventArgs.context, [UIColor colorWithRed:0.23 green:0.50 blue:0.90 alpha:1.0].CGColor);
                                    CGContextFillRect(eventContainer.eventArgs.context, r);
                                    [eventContainer.eventArgs.panel.textAttributes setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
                                }
                            }
                        }
                    }
                    eventContainer.eventArgs.cancel = false;
                    
                } forObject:self];
                [self.flex.flexGridSelectionChanged addHandler:^(XuniEventContainer<GridCellRangeEventArgs *> *eventContainer) {
                    NSDictionary *dic = [eventAry objectAtIndex:eventContainer.eventArgs.row];
                    switch (eventContainer.eventArgs.col) {
                        case 1:
                            if ([dic objectForKey:@"EVENTID1"] != [NSNull null]) {
                                [self diaryAlartSet:[dic objectForKey:@"EVENTID1"]];
                            }
                            break;
                        case 2:
                            if ([dic objectForKey:@"EVENTID2"] != [NSNull null]) {
                                [self diaryAlartSet:[dic objectForKey:@"EVENTID2"]];
                            }
                            break;
                        case 3:
                            if ([dic objectForKey:@"EVENTID3"] != [NSNull null]) {
                                [self diaryAlartSet:[dic objectForKey:@"EVENTID3"]];
                            }
                            break;
                        case 4:
                            if ([dic objectForKey:@"EVENTID4"] != [NSNull null]) {
                                [self diaryAlartSet:[dic objectForKey:@"EVENTID4"]];
                            }
                            break;
                            
                        default:
                            break;
                    }
                    
                } forObject:self];
            }
            
            TableData1 *td = [self.flex.itemsSource objectAtIndex:self.flex.viewRange.row2];
            NSString *startDate = td.dayStr2;
            TableData1 *td2 = [self.flex.itemsSource objectAtIndex:self.flex.viewRange.col];
            NSString *endDate = td2.dayStr2;
            self.toolLabel.text = [NSString stringWithFormat:@"%@年%@月%@日〜%@年%@月%@日",[startDate substringWithRange:NSMakeRange(0, 4)],[startDate substringWithRange:NSMakeRange(4, 2)],[startDate substringWithRange:NSMakeRange(6, 2)],[endDate substringWithRange:NSMakeRange(0, 4)],[endDate substringWithRange:NSMakeRange(4, 2)],[endDate substringWithRange:NSMakeRange(6, 2)]];
            self.toolLabel = [Common getMoziSizeSetting:self.toolLabel];
            startDataStr = startDate;
            endDataStr = endDate;
            //最後の日付が今日なら進むボタンを非表示にする
            NSString *targetdate = [Common getTimeString];
            int dataInt1 = [[targetdate substringWithRange:NSMakeRange(0, 8)] intValue];
            int dataInt2 = [[endDataStr substringWithRange:NSMakeRange(0, 8)] intValue];
            if (dataInt1 == dataInt2) {
                newDataBOOL = YES;
                self.rightBtn.hidden = YES;
            }
            //最初の日付が2016年1月1日より前になったら戻るボタンを非表示にする
//            int sDataInt = [[startDataStr substringWithRange:NSMakeRange(0, 8)] intValue];
//            int maxBackInt = [maxBackCount intValue];
//            if (maxBackInt >= sDataInt) {
//                self.leftBtn.hidden = YES;
//            }
            BOOL getMaxBackCountFlag = [[[Common alloc] init] getMaxBackCountFlag:startDate];
            if (getMaxBackCountFlag == YES) {
                self.leftBtn.hidden = YES;
            }
            self.flex.font = [UIFont systemFontOfSize:15.0f];
            [self.view addSubview:self.flex];
            [Common dismissSVProgressHUD];
        });
    });
}
-(void)diaryAlartSet:(NSString *)eventId{
    [Common showSVProgressHUD:@""];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *diaryDic = [[PHPConnection getDiaryEventId:eventId] objectAtIndex:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *monthStr = [[diaryDic objectForKey:@"ASSAYDATE"] substringWithRange:NSMakeRange(4, 2)];
            NSString *dayStr = [[diaryDic objectForKey:@"ASSAYDATE"] substringWithRange:NSMakeRange(6, 2)];
            NSString *timeStr = [[diaryDic objectForKey:@"ASSAYDATE"] substringWithRange:NSMakeRange(8, 2)];
            if([[monthStr substringWithRange:NSMakeRange(0, 1)]  isEqual: @"0"]){
                monthStr = [monthStr substringWithRange:NSMakeRange(1, 1)];
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
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"日誌"] message:[NSString stringWithFormat:@"\n%@\n%@\n%@\n\n%@",day,name,val,[diaryDic objectForKey:@"MEMO"]] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"閉じる"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        
                                                    }]];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            [Common dismissSVProgressHUD];
        });
    });
    
}
/*
 時間取得
 plusminusStr = 0でマイナス　1でプラス　2で現在の時間取得
*/
-(NSString *)getTargetDataStr:(NSString *)plusminusStr{
    //今の時間と月の前半後半を判別する
    NSString *targetdate = [Common getTimeString];
    int dataInt = [[targetdate substringWithRange:NSMakeRange(6, 2)] intValue];
    NSString *targetStr;//最終的に渡す値
    if ([plusminusStr  isEqual: @"2"]) {
        if (dataInt <= 15) {
            targetStr = [NSString stringWithFormat:@"%@0",[targetdate substringWithRange:NSMakeRange(0, 6)]];
            self.toolLabel.text = [NSString stringWithFormat:@"%@年%@月\n前半",
                                   [targetdate substringWithRange:NSMakeRange(0, 4)],
                                   [targetdate substringWithRange:NSMakeRange(4, 2)]];
        }else{
            targetStr = [NSString stringWithFormat:@"%@1",[targetdate substringWithRange:NSMakeRange(0, 6)]];
            self.toolLabel.text = [NSString stringWithFormat:@"%@年%@月\n後半",
                                   [targetdate substringWithRange:NSMakeRange(0, 4)],
                                   [targetdate substringWithRange:NSMakeRange(4, 2)]];
        }
    }else{
        targetStr = datastr;
    }
    //変更ボタンから変更された場合の処理
    if ([plusminusStr  isEqual: @"2"]) {
    }else{
        if ([plusminusStr  isEqual: @"0"]) {
            int mInt1 = [targetStr intValue];//int型に変換
            //前半か後半かを最後の0と1で判断
            int int1 = [[targetStr substringWithRange:NSMakeRange(6, 1)] intValue];
            if (int1 == 1) {
                int mInt = [targetStr intValue] - 1;
                targetStr = [NSString stringWithFormat:@"%d",mInt];
                
            }else{
                int mInt2 = [[targetStr substringWithRange:NSMakeRange(4, 2)] intValue];
                if (mInt2 == 1) {
                    mInt1 -= 1000;
                    mInt1 += 110;
                    mInt1 += 1;
                }else{
                    //月を減らして後半に
                    mInt1 -= 10;
                    mInt1 += 1;
                }
                targetStr = [NSString stringWithFormat:@"%d",mInt1];
            }
            if ([[targetStr substringWithRange:NSMakeRange(6, 1)]  isEqual: @"0"]) {
                targetStr = [NSString stringWithFormat:@"%@0",[targetStr substringWithRange:NSMakeRange(0, 6)]];
                self.toolLabel.text = [NSString stringWithFormat:@"%@年%@月\n前半",
                                       [targetStr substringWithRange:NSMakeRange(0, 4)],
                                       [targetStr substringWithRange:NSMakeRange(4, 2)]];
            }else{
                targetStr = [NSString stringWithFormat:@"%@1",[targetStr substringWithRange:NSMakeRange(0, 6)]];
                self.toolLabel.text = [NSString stringWithFormat:@"%@年%@月\n後半",
                                       [targetStr substringWithRange:NSMakeRange(0, 4)],
                                       [targetStr substringWithRange:NSMakeRange(4, 2)]];
            }
        }
        if ([plusminusStr  isEqual: @"1"]) {
            int mInt1 = [targetStr intValue];//int型に変換
            //前半か後半かを最後の0と1で判断
            int int1 = [[targetStr substringWithRange:NSMakeRange(6, 1)] intValue];
            if (int1 == 0) {
                int mInt = [targetStr intValue] + 1;
                targetStr = [NSString stringWithFormat:@"%d",mInt];
                
            }else{
                int mInt2 = [[targetStr substringWithRange:NSMakeRange(4, 2)] intValue];
                if (mInt2 == 12) {
                    mInt1 += 1000;
                    mInt1 -= 110;
                    mInt1 -= 1;
                }else{
                    //月を増やして前半に
                    mInt1 += 10;
                    mInt1 -= 1;
                }
                targetStr = [NSString stringWithFormat:@"%d",mInt1];
            }
            if ([[targetStr substringWithRange:NSMakeRange(6, 1)]  isEqual: @"0"]) {
                targetStr = [NSString stringWithFormat:@"%@0",[targetStr substringWithRange:NSMakeRange(0, 6)]];
                self.toolLabel.text = [NSString stringWithFormat:@"%@年%@月\n前半",
                                       [targetStr substringWithRange:NSMakeRange(0, 4)],
                                       [targetStr substringWithRange:NSMakeRange(4, 2)]];
            }else{
                targetStr = [NSString stringWithFormat:@"%@1",[targetStr substringWithRange:NSMakeRange(0, 6)]];
                self.toolLabel.text = [NSString stringWithFormat:@"%@年%@月\n後半",
                                       [targetStr substringWithRange:NSMakeRange(0, 4)],
                                       [targetStr substringWithRange:NSMakeRange(4, 2)]];
            }
        }
    }
    return targetStr;
}


- (IBAction)leftBtn:(id)sender {
    newDataBOOL = NO;
    self.rightBtn.hidden = NO;
    [self setTable:@"0"];
}

- (IBAction)rightBtn:(id)sender {
    self.leftBtn.hidden = NO;
    [self setTable:@"1"];
}

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
- (IBAction)tableDiaryBtn:(id)sender {
    if (self.tableDiaryBtn.on == YES) {
        tableDiaryBool = YES;
        [self setTable:@"3"];
    }else{
        tableDiaryBool = NO;
        [self setTable:@"3"];
    }
}
@end
