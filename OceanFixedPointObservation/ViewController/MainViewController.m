//
//  MainViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/17.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import "MainViewController.h"
#import "MapViewController.h"
#import "TableViewController.h"
#import "ChartViewController.h"
#import "SettingViewController.h"
#import "LocationDetailViewController.h"
#import "AreaListViewController.h"
#import "DiaryViewController.h"
#import "ThreadViewController.h"
#import "SekisanView.h"

@import XuniGaugeDynamicKit;

#define sViewTag1 1001
#define sViewTag2 1002
#define sViewTag3 1003
#define sViewTag4 1004
#define sViewTag5 1005
#define sViewTag6 1006
#define sViewTag7 1007
#define sViewTag8 1008
#define sViewTag9 1009
#define sViewTag10 1010

MapViewController *mapViewController;
TableViewController *tableViewController;
ChartViewController *chartViewController;
SettingViewController *settingViewController;
LocationDetailViewController *locationDetailViewController;
AreaListViewController *areaListViewController;
DiaryViewController *diaryViewController;
ThreadViewController *threadViewController;

BOOL mapFlag;
int PanelPageCount = 0;

NSMutableArray *userDataAry;//ユーザーデータ格納及び表、グラフへ渡す用

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [self setPanel];
    
    [super viewDidLoad];
    
    //TODO:マップ画面、リスト画面切り替えフラグ
    //YES=マップ画面　NO=リスト画面
    mapFlag = NO;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setScroll];
    [self setPage];
    [self panelCheck];
    NSDate *datetime = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //fmt.dateFormat = @"yyyy年 M月 dd日\nHH時 現在";
    fmt.dateFormat = @"yyyy年 M月 dd日 HH時 現在";
    NSString *result = [fmt stringFromDate:datetime];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.text = result;
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
    self.timeLabel.minimumScaleFactor = 5.f/30.f;
    //self.timeLabel.text = @"2017年 6月 14日 15時 現在";
}


-(void)viewDidAppear:(BOOL)animated{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [[ud objectForKey:@"NewNotification_Key"] mutableCopy];
    if (ary.count > 0) {
        NSMutableString *str = [NSMutableString string];
        for (int i = 0; i < ary.count; i++) {
            [str appendString:[ary objectAtIndex:i]];
            if (ary.count-1 > i) {
                [str appendString:@","];
            }
        }
        NSDictionary *topNon = [PHPConnection getNewNotification:str];
        int count = [[topNon objectForKey:@"COUNT"] intValue];
        if (count > 0) {
            //countが0より上なら画像変更する
            [self.chatBtn setImage:[UIImage imageNamed:@"keijituuti.png"] forState:UIControlStateNormal];
        }else{
            [self.chatBtn setImage:[UIImage imageNamed:@"keiji.png"] forState:UIControlStateNormal];
        }
    }
    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-ページコントロール
- (void)setPage{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDataDic = [ud objectForKey:@"UserData_Key"];
    int pageCount = [[userDataDic objectForKey:@"PageCount"] intValue];
    self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.frame.size.width*pageCount, self.mainScrollView.frame.size.height);
    self.pageControl.numberOfPages = pageCount;
    // 現在のページを0に初期化する。
    self.pageControl.currentPage = PanelPageCount;
}
#pragma mark-スクロール処理
- (void)setScroll{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDataDic = [ud objectForKey:@"UserData_Key"];
    int pageCount = [[userDataDic objectForKey:@"PageCount"] intValue];
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.frame.size.width*pageCount, self.mainScrollView.frame.size.height);
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.scrollsToTop = YES;
    self.mainScrollView.bounces = NO;
    self.mainScrollView.delegate = self;
    
    
}
-(void)setPanel{
    for (int i = 0; 10 > i; i++) {
        SekisanView *sview = [SekisanView SekisanView];
        if (i == 0) {
            sview.tag = sViewTag1;
            sview.panel1.tag = 101;
            sview.panel2.tag = 102;
            sview.panel3.tag = 103;
            sview.panel4.tag = 104;
            sview.frame = CGRectMake(0, 0, sview.frame.size.width, sview.frame.size.height);
        }
        if (i == 1) {
            sview.tag = sViewTag2;
            sview.panel1.tag = 105;
            sview.panel2.tag = 106;
            sview.panel3.tag = 107;
            sview.panel4.tag = 108;
            sview.frame = CGRectMake(sview.frame.size.width, 0, sview.frame.size.width, sview.frame.size.height);
        }
        if (i == 2) {
            sview.tag = sViewTag3;
            sview.panel1.tag = 109;
            sview.panel2.tag = 110;
            sview.panel3.tag = 111;
            sview.panel4.tag = 112;
            sview.frame = CGRectMake(sview.frame.size.width*i, 0, sview.frame.size.width, sview.frame.size.height);
        }
        if (i == 3) {
            sview.tag = sViewTag4;
            sview.panel1.tag = 113;
            sview.panel2.tag = 114;
            sview.panel3.tag = 115;
            sview.panel4.tag = 116;
            sview.frame = CGRectMake(sview.frame.size.width*i, 0, sview.frame.size.width, sview.frame.size.height);
        }
        if (i == 4) {
            sview.tag = sViewTag5;
            sview.panel1.tag = 117;
            sview.panel2.tag = 118;
            sview.panel3.tag = 119;
            sview.panel4.tag = 120;
            sview.frame = CGRectMake(sview.frame.size.width*i, 0, sview.frame.size.width, sview.frame.size.height);
        }
        if (i == 5) {
            sview.tag = sViewTag6;
            sview.panel1.tag = 121;
            sview.panel2.tag = 122;
            sview.panel3.tag = 123;
            sview.panel4.tag = 124;
            sview.frame = CGRectMake(sview.frame.size.width*i, 0, sview.frame.size.width, sview.frame.size.height);
        }
        if (i == 6) {
            sview.tag = sViewTag7;
            sview.panel1.tag = 125;
            sview.panel2.tag = 126;
            sview.panel3.tag = 127;
            sview.panel4.tag = 128;
            sview.frame = CGRectMake(sview.frame.size.width*i, 0, sview.frame.size.width, sview.frame.size.height);
        }
        if (i == 7) {
            sview.tag = sViewTag8;
            sview.panel1.tag = 129;
            sview.panel2.tag = 130;
            sview.panel3.tag = 131;
            sview.panel4.tag = 132;
            sview.frame = CGRectMake(sview.frame.size.width*i, 0, sview.frame.size.width, sview.frame.size.height);
        }
        if (i == 8) {
            sview.tag = sViewTag9;
            sview.panel1.tag = 133;
            sview.panel2.tag = 134;
            sview.panel3.tag = 135;
            sview.panel4.tag = 136;
            sview.frame = CGRectMake(sview.frame.size.width*i, 0, sview.frame.size.width, sview.frame.size.height);
        }
        if (i == 9) {
            sview.tag = sViewTag10;
            sview.panel1.tag = 137;
            sview.panel2.tag = 138;
            sview.panel3.tag = 139;
            sview.panel4.tag = 140;
            sview.frame = CGRectMake(sview.frame.size.width*i, 0, sview.frame.size.width, sview.frame.size.height);
        }
        //各パネルにタップイベントを付与
        UITapGestureRecognizer *tapGesture1 =
        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
        tapGesture1.delegate = self;
        [sview.panel1 addGestureRecognizer:tapGesture1];
        
        UITapGestureRecognizer *tapGesture2 =
        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
        tapGesture2.delegate = self;
        [sview.panel2 addGestureRecognizer:tapGesture2];
        
        UITapGestureRecognizer *tapGesture3 =
        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
        tapGesture3.delegate = self;
        [sview.panel3 addGestureRecognizer:tapGesture3];
        
        UITapGestureRecognizer *tapGesture4 =
        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
        tapGesture4.delegate = self;
        [sview.panel4 addGestureRecognizer:tapGesture4];
        sview.panel1.hidden = YES;
        sview.panel2.hidden = YES;
        sview.panel3.hidden = YES;
        sview.panel4.hidden = YES;
        
        sview.mainViewController = self;
        
        [self.mainScrollView addSubview:sview];
    }
}


#pragma mark-タップ処理
- (void)tapped:(UITapGestureRecognizer *)sender{
    long panelTag = [(UIGestureRecognizer *)sender view].tag;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDataDic = [ud objectForKey:@"UserData_Key"];
    NSString *dataSetCD;
    NSString *panelNo;
    switch (panelTag) {
        case 101:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD1"];
            panelNo = @"1";
            break;
        case 102:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD2"];
            panelNo = @"2";
            break;
        case 103:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD3"];
            panelNo = @"3";
            break;
        case 104:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD4"];
            panelNo = @"4";
            break;
        case 105:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD5"];
            panelNo = @"5";
            break;
        case 106:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD6"];
            panelNo = @"6";
            break;
        case 107:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD7"];
            panelNo = @"7";
            break;
        case 108:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD8"];
            panelNo = @"8";
            break;
        case 109:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD9"];
            panelNo = @"9";
            break;
        case 110:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD10"];
            panelNo = @"10";
            break;
        case 111:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD11"];
            panelNo = @"11";
            break;
        case 112:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD12"];
            panelNo = @"12";
            break;
        case 113:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD13"];
            panelNo = @"13";
            break;
        case 114:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD14"];
            panelNo = @"14";
            break;
        case 115:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD15"];
            panelNo = @"15";
            break;
        case 116:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD16"];
            panelNo = @"16";
            break;
        case 117:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD17"];
            panelNo = @"17";
            break;
        case 118:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD18"];
            panelNo = @"18";
            break;
        case 119:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD19"];
            panelNo = @"19";
            break;
        case 120:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD20"];
            panelNo = @"20";
            break;
        case 121:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD21"];
            panelNo = @"21";
            break;
        case 122:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD22"];
            panelNo = @"22";
            break;
        case 123:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD23"];
            panelNo = @"23";
            break;
        case 124:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD24"];
            panelNo = @"24";
            break;
        case 125:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD25"];
            panelNo = @"25";
            break;
        case 126:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD26"];
            panelNo = @"26";
            break;
        case 127:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD27"];
            panelNo = @"27";
            break;
        case 128:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD28"];
            panelNo = @"28";
            break;
        case 129:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD29"];
            panelNo = @"29";
            break;
        case 130:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD30"];
            panelNo = @"30";
            break;
        case 131:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD31"];
            panelNo = @"31";
            break;
        case 132:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD32"];
            panelNo = @"32";
            break;
        case 133:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD33"];
            panelNo = @"33";
            break;
        case 134:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD34"];
            panelNo = @"34";
            break;
        case 135:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD35"];
            panelNo = @"35";
            break;
        case 136:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD36"];
            panelNo = @"36";
            break;
        case 137:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD37"];
            panelNo = @"37";
            break;
        case 138:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD38"];
            panelNo = @"38";
            break;
        case 139:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD39"];
            panelNo = @"39";
            break;
        case 140:
            dataSetCD = [userDataDic objectForKey:@"DataSetCD40"];
            panelNo = @"40";
            break;
            
        default:
            break;
    }
    locationDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationDetailViewController"];
    locationDetailViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    locationDetailViewController.DataSetCD = dataSetCD;
    locationDetailViewController.panelNo = panelNo;
    [self presentViewController:locationDetailViewController animated:YES completion:nil];
}

#pragma mark-パネル処理
- (void)panelCheck{
    [Common showSVProgressHUD:@""];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDataDic = [ud objectForKey:@"UserData_Key"];
    //ページ数で取得するデータを絞る
    int pageCount = [[userDataDic objectForKey:@"PageCount"] intValue];
    NSString *DataSetCD1,*DataSetCD2,*DataSetCD3,*DataSetCD4,*DataSetCD5,*DataSetCD6,*DataSetCD7,*DataSetCD8,*DataSetCD9,*DataSetCD10,*DataSetCD11,*DataSetCD12,*DataSetCD13,*DataSetCD14,*DataSetCD15,*DataSetCD16,*DataSetCD17,*DataSetCD18,*DataSetCD19,*DataSetCD20,*DataSetCD21,*DataSetCD22,*DataSetCD23,*DataSetCD24,*DataSetCD25,*DataSetCD26,*DataSetCD27,*DataSetCD28,*DataSetCD29,*DataSetCD30,*DataSetCD31,*DataSetCD32,*DataSetCD33,*DataSetCD34,*DataSetCD35,*DataSetCD36,*DataSetCD37,*DataSetCD38,*DataSetCD39,*DataSetCD40  = @"0";
    
    if(pageCount >= 1){
        DataSetCD1 = [userDataDic objectForKey:@"DataSetCD1"];
        DataSetCD2 = [userDataDic objectForKey:@"DataSetCD2"];
        DataSetCD3 = [userDataDic objectForKey:@"DataSetCD3"];
        DataSetCD4 = [userDataDic objectForKey:@"DataSetCD4"];
    }
    if(pageCount >= 2){
        DataSetCD5 = [userDataDic objectForKey:@"DataSetCD5"];
        DataSetCD6 = [userDataDic objectForKey:@"DataSetCD6"];
        DataSetCD7 = [userDataDic objectForKey:@"DataSetCD7"];
        DataSetCD8 = [userDataDic objectForKey:@"DataSetCD8"];
    }
    if(pageCount >= 3){
        DataSetCD9 = [userDataDic objectForKey:@"DataSetCD9"];
        DataSetCD10 = [userDataDic objectForKey:@"DataSetCD10"];
        DataSetCD11 = [userDataDic objectForKey:@"DataSetCD11"];
        DataSetCD12 = [userDataDic objectForKey:@"DataSetCD12"];
    }
    if(pageCount >= 4){
        DataSetCD13 = [userDataDic objectForKey:@"DataSetCD13"];
        DataSetCD14 = [userDataDic objectForKey:@"DataSetCD14"];
        DataSetCD15 = [userDataDic objectForKey:@"DataSetCD15"];
        DataSetCD16 = [userDataDic objectForKey:@"DataSetCD16"];
    }
    if(pageCount >= 5){
        DataSetCD17 = [userDataDic objectForKey:@"DataSetCD17"];
        DataSetCD18 = [userDataDic objectForKey:@"DataSetCD18"];
        DataSetCD19 = [userDataDic objectForKey:@"DataSetCD19"];
        DataSetCD20 = [userDataDic objectForKey:@"DataSetCD20"];
    }
    if(pageCount >= 6){
        DataSetCD21 = [userDataDic objectForKey:@"DataSetCD21"];
        DataSetCD22 = [userDataDic objectForKey:@"DataSetCD22"];
        DataSetCD23 = [userDataDic objectForKey:@"DataSetCD23"];
        DataSetCD24 = [userDataDic objectForKey:@"DataSetCD24"];
    }
    if(pageCount >= 7){
        DataSetCD25 = [userDataDic objectForKey:@"DataSetCD25"];
        DataSetCD26 = [userDataDic objectForKey:@"DataSetCD26"];
        DataSetCD27 = [userDataDic objectForKey:@"DataSetCD27"];
        DataSetCD28 = [userDataDic objectForKey:@"DataSetCD28"];
    }
    if(pageCount >= 8){
        DataSetCD29 = [userDataDic objectForKey:@"DataSetCD29"];
        DataSetCD30 = [userDataDic objectForKey:@"DataSetCD30"];
        DataSetCD31 = [userDataDic objectForKey:@"DataSetCD31"];
        DataSetCD32 = [userDataDic objectForKey:@"DataSetCD32"];
    }
    if(pageCount >= 9){
        DataSetCD33 = [userDataDic objectForKey:@"DataSetCD33"];
        DataSetCD34 = [userDataDic objectForKey:@"DataSetCD34"];
        DataSetCD35 = [userDataDic objectForKey:@"DataSetCD35"];
        DataSetCD36 = [userDataDic objectForKey:@"DataSetCD36"];
    }
    if(pageCount >= 10){
        DataSetCD37 = [userDataDic objectForKey:@"DataSetCD37"];
        DataSetCD38 = [userDataDic objectForKey:@"DataSetCD38"];
        DataSetCD39 = [userDataDic objectForKey:@"DataSetCD39"];
        DataSetCD40 = [userDataDic objectForKey:@"DataSetCD40"];
    }
    
    NSString *targetdate = [Common getTimeString];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        userDataAry = [PHPConnection getPanelSekisanData40:DataSetCD1 DataSetCD2:DataSetCD2 DataSetCD3:DataSetCD3 DataSetCD4:DataSetCD4 DataSetCD5:DataSetCD5 DataSetCD6:DataSetCD6 DataSetCD7:DataSetCD7 DataSetCD8:DataSetCD8 DataSetCD9:DataSetCD9 DataSetCD10:DataSetCD10 DataSetCD11:DataSetCD11 DataSetCD12:DataSetCD12 DataSetCD13:DataSetCD13 DataSetCD14:DataSetCD14 DataSetCD15:DataSetCD15 DataSetCD16:DataSetCD16 DataSetCD17:DataSetCD17 DataSetCD18:DataSetCD18 DataSetCD19:DataSetCD19 DataSetCD20:DataSetCD20 DataSetCD21:DataSetCD21 DataSetCD22:DataSetCD22 DataSetCD23:DataSetCD23 DataSetCD24:DataSetCD24 DataSetCD25:DataSetCD25 DataSetCD26:DataSetCD26 DataSetCD27:DataSetCD27 DataSetCD28:DataSetCD28 DataSetCD29:DataSetCD29 DataSetCD30:DataSetCD30 DataSetCD31:DataSetCD31 DataSetCD32:DataSetCD32 DataSetCD33:DataSetCD33 DataSetCD34:DataSetCD34 DataSetCD35:DataSetCD35 DataSetCD36:DataSetCD36 DataSetCD37:DataSetCD37 DataSetCD38:DataSetCD38 DataSetCD39:DataSetCD39 DataSetCD40:DataSetCD40 targetDate:targetdate];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            SekisanView *sview1,*sview2,*sview3,*sview4,*sview5,*sview6,*sview7,*sview8,*sview9,*sview10 = nil;
            if(pageCount >= 1){
                sview1 = [self.mainScrollView viewWithTag:sViewTag1];
            }
            if(pageCount >= 2){
                sview2 = [self.mainScrollView viewWithTag:sViewTag2];
            }
            if(pageCount >= 3){
                sview3 = [self.mainScrollView viewWithTag:sViewTag3];
            }
            if(pageCount >= 4){
                sview4 = [self.mainScrollView viewWithTag:sViewTag4];
            }
            if(pageCount >= 5){
                sview5 = [self.mainScrollView viewWithTag:sViewTag5];
            }
            if(pageCount >= 6){
                sview6 = [self.mainScrollView viewWithTag:sViewTag6];
            }
            if(pageCount >= 7){
                sview7 = [self.mainScrollView viewWithTag:sViewTag7];
            }
            if(pageCount >= 8){
                sview8 = [self.mainScrollView viewWithTag:sViewTag8];
            }
            if(pageCount >= 9){
                sview9 = [self.mainScrollView viewWithTag:sViewTag9];
            }
            if(pageCount >= 10){
                sview10 = [self.mainScrollView viewWithTag:sViewTag10];
            }
            
            for( NSDictionary * userDataDic in userDataAry) {
                //DATASETCDとPANEL番号を取得
                NSString *dataSetCD = [userDataDic objectForKey:@"DATASETCD"];
                NSString *panelNum = [userDataDic objectForKey:@"PANEL"];
                NSString *panelPage = [userDataDic objectForKey:@"PAGE"];
                
                //APIから帰ってくるPAGEにより分岐
                if ([panelPage  isEqual: @"1"]) {
                    //バネル番号により分岐
                    //DATASETCDが0なら非表示そうでなければデータを表示
                    if ([panelNum  isEqual: @"1"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview1.panel1.hidden = YES;
                        }else{
                            sview1.panel1.hidden = NO;
                            sview1.panel1_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview1.panel1_AreaNameLabel = [Common getMoziSizeSetting:sview1.panel1_AreaNameLabel];
                            sview1.panel1_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview1.panel1_DataTypeLabel = [Common getMoziSizeSetting:sview1.panel1_DataTypeLabel];
                            sview1.panel1_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview1.panel1_PointLabel = [Common getMoziSizeSetting:sview1.panel1_PointLabel];
                            sview1.panel1_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview1.panel1_UnitLabel1 = [Common getMoziSizeSetting:sview1.panel1_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview1.panel1_AssayVal1.text = @"--";
                                sview1.panel1_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview1.panel1_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview1.panel1_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview1.panel1_MaxValLabel.text = @"--";
                            }else{
                                sview1.panel1_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview1.panel1_MinValLabel.text = @"--";
                            }else{
                                sview1.panel1_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview1.panel1_View3.hidden = YES;
                            }else{
                                sview1.panel1_View3.hidden = NO;
                                sview1.panel1_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"2"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview1.panel2.hidden = YES;
                        }else{
                            sview1.panel2.hidden = NO;
                            sview1.panel2_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview1.panel2_AreaNameLabel = [Common getMoziSizeSetting:sview1.panel2_AreaNameLabel];
                            sview1.panel2_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview1.panel2_DataTypeLabel = [Common getMoziSizeSetting:sview1.panel2_DataTypeLabel];
                            sview1.panel2_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview1.panel2_PointLabel = [Common getMoziSizeSetting:sview1.panel2_PointLabel];
                            sview1.panel2_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview1.panel2_UnitLabel1 = [Common getMoziSizeSetting:sview1.panel2_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview1.panel2_AssayVal1.text = @"--";
                                sview1.panel2_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview1.panel2_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview1.panel2_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview1.panel2_MaxValLabel.text = @"--";
                            }else{
                                sview1.panel2_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview1.panel2_MinValLabel.text = @"--";
                            }else{
                                sview1.panel2_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview1.panel2_View3.hidden = YES;
                            }else{
                                sview1.panel2_View3.hidden = NO;
                                sview1.panel2_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"3"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview1.panel3.hidden = YES;
                        }else{
                            sview1.panel3.hidden = NO;
                            sview1.panel3_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview1.panel3_AreaNameLabel = [Common getMoziSizeSetting:sview1.panel3_AreaNameLabel];
                            sview1.panel3_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview1.panel3_DataTypeLabel = [Common getMoziSizeSetting:sview1.panel3_DataTypeLabel];
                            sview1.panel3_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview1.panel3_PointLabel = [Common getMoziSizeSetting:sview1.panel3_PointLabel];
                            sview1.panel3_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview1.panel3_UnitLabel1 = [Common getMoziSizeSetting:sview1.panel3_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview1.panel3_AssayVal1.text = @"--";
                                sview1.panel3_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview1.panel3_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview1.panel3_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview1.panel3_MaxValLabel.text = @"--";
                            }else{
                                sview1.panel3_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview1.panel3_MinValLabel.text = @"--";
                            }else{
                                sview1.panel3_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview1.panel3_View3.hidden = YES;
                            }else{
                                sview1.panel3_View3.hidden = NO;
                                sview1.panel3_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"4"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview1.panel4.hidden = YES;
                        }else{
                            sview1.panel4.hidden = NO;
                            sview1.panel4_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview1.panel4_AreaNameLabel = [Common getMoziSizeSetting:sview1.panel4_AreaNameLabel];
                            sview1.panel4_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview1.panel4_DataTypeLabel = [Common getMoziSizeSetting:sview1.panel4_DataTypeLabel];
                            sview1.panel4_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview1.panel4_PointLabel = [Common getMoziSizeSetting:sview1.panel4_PointLabel];
                            sview1.panel4_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview1.panel4_UnitLabel1 = [Common getMoziSizeSetting:sview1.panel4_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview1.panel4_AssayVal1.text = @"--";
                                sview1.panel4_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview1.panel4_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview1.panel4_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview1.panel4_MaxValLabel.text = @"--";
                            }else{
                                sview1.panel4_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview1.panel4_MinValLabel.text = @"--";
                            }else{
                                sview1.panel4_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview1.panel4_View3.hidden = YES;
                            }else{
                                sview1.panel4_View3.hidden = NO;
                                sview1.panel4_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                }
                if ([panelPage  isEqual: @"2"]) {
                    //バネル番号により分岐
                    //DATASETCDが0なら非表示そうでなければデータを表示
                    if ([panelNum  isEqual: @"5"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview2.panel1.hidden = YES;
                        }else{
                            sview2.panel1.hidden = NO;
                            sview2.panel1_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview2.panel1_AreaNameLabel = [Common getMoziSizeSetting:sview2.panel1_AreaNameLabel];
                            sview2.panel1_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview2.panel1_DataTypeLabel = [Common getMoziSizeSetting:sview2.panel1_DataTypeLabel];
                            sview2.panel1_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview2.panel1_PointLabel = [Common getMoziSizeSetting:sview2.panel1_PointLabel];
                            sview2.panel1_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview2.panel1_UnitLabel1 = [Common getMoziSizeSetting:sview2.panel1_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview2.panel1_AssayVal1.text = @"--";
                                sview2.panel1_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview2.panel1_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview2.panel1_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview2.panel1_MaxValLabel.text = @"--";
                            }else{
                                sview2.panel1_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview2.panel1_MinValLabel.text = @"--";
                            }else{
                                sview2.panel1_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview2.panel1_View3.hidden = YES;
                            }else{
                                sview2.panel1_View3.hidden = NO;
                                sview2.panel1_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"6"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview2.panel2.hidden = YES;
                        }else{
                            sview2.panel2.hidden = NO;
                            sview2.panel2_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview2.panel2_AreaNameLabel = [Common getMoziSizeSetting:sview2.panel2_AreaNameLabel];
                            sview2.panel2_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview2.panel2_DataTypeLabel = [Common getMoziSizeSetting:sview2.panel2_DataTypeLabel];
                            sview2.panel2_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview2.panel2_PointLabel = [Common getMoziSizeSetting:sview2.panel2_PointLabel];
                            sview2.panel2_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview2.panel2_UnitLabel1 = [Common getMoziSizeSetting:sview2.panel2_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview2.panel2_AssayVal1.text = @"--";
                                sview2.panel2_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview2.panel2_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview2.panel2_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview2.panel2_MaxValLabel.text = @"--";
                            }else{
                                sview2.panel2_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview2.panel2_MinValLabel.text = @"--";
                            }else{
                                sview2.panel2_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview2.panel2_View3.hidden = YES;
                            }else{
                                sview2.panel2_View3.hidden = NO;
                                sview2.panel2_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"7"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview2.panel3.hidden = YES;
                        }else{
                            sview2.panel3.hidden = NO;
                            sview2.panel3_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview2.panel3_AreaNameLabel = [Common getMoziSizeSetting:sview2.panel3_AreaNameLabel];
                            sview2.panel3_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview2.panel3_DataTypeLabel = [Common getMoziSizeSetting:sview2.panel3_DataTypeLabel];
                            sview2.panel3_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview2.panel3_PointLabel = [Common getMoziSizeSetting:sview2.panel3_PointLabel];
                            sview2.panel3_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview2.panel3_UnitLabel1 = [Common getMoziSizeSetting:sview2.panel3_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview2.panel3_AssayVal1.text = @"--";
                                sview2.panel3_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview2.panel3_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview2.panel3_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview2.panel3_MaxValLabel.text = @"--";
                            }else{
                                sview2.panel3_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview2.panel3_MinValLabel.text = @"--";
                            }else{
                                sview2.panel3_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview2.panel3_View3.hidden = YES;
                            }else{
                                sview2.panel3_View3.hidden = NO;
                                sview2.panel3_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"8"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview2.panel4.hidden = YES;
                        }else{
                            sview2.panel4.hidden = NO;
                            sview2.panel4_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview2.panel4_AreaNameLabel = [Common getMoziSizeSetting:sview2.panel4_AreaNameLabel];
                            sview2.panel4_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview2.panel4_DataTypeLabel = [Common getMoziSizeSetting:sview2.panel4_DataTypeLabel];
                            sview2.panel4_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview2.panel4_PointLabel = [Common getMoziSizeSetting:sview2.panel4_PointLabel];
                            sview2.panel4_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview2.panel4_UnitLabel1 = [Common getMoziSizeSetting:sview2.panel4_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview2.panel4_AssayVal1.text = @"--";
                                sview2.panel4_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview2.panel4_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview2.panel4_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview2.panel4_MaxValLabel.text = @"--";
                            }else{
                                sview2.panel4_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview2.panel4_MinValLabel.text = @"--";
                            }else{
                                sview2.panel4_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview2.panel4_View3.hidden = YES;
                            }else{
                                sview2.panel4_View3.hidden = NO;
                                sview2.panel4_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                }
                if ([panelPage  isEqual: @"3"]) {
                    //バネル番号により分岐
                    //DATASETCDが0なら非表示そうでなければデータを表示
                    if ([panelNum  isEqual: @"9"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview3.panel1.hidden = YES;
                        }else{
                            sview3.panel1.hidden = NO;
                            sview3.panel1_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview3.panel1_AreaNameLabel = [Common getMoziSizeSetting:sview3.panel1_AreaNameLabel];
                            sview3.panel1_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview3.panel1_DataTypeLabel = [Common getMoziSizeSetting:sview3.panel1_DataTypeLabel];
                            sview3.panel1_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview3.panel1_PointLabel = [Common getMoziSizeSetting:sview3.panel1_PointLabel];
                            sview3.panel1_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview3.panel1_UnitLabel1 = [Common getMoziSizeSetting:sview3.panel1_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview3.panel1_AssayVal1.text = @"--";
                                sview3.panel1_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview3.panel1_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview3.panel1_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview3.panel1_MaxValLabel.text = @"--";
                            }else{
                                sview3.panel1_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview3.panel1_MinValLabel.text = @"--";
                            }else{
                                sview3.panel1_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview3.panel1_View3.hidden = YES;
                            }else{
                                sview3.panel1_View3.hidden = NO;
                                sview3.panel1_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"10"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview3.panel2.hidden = YES;
                        }else{
                            sview3.panel2.hidden = NO;
                            sview3.panel2_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview3.panel2_AreaNameLabel = [Common getMoziSizeSetting:sview3.panel2_AreaNameLabel];
                            sview3.panel2_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview3.panel2_DataTypeLabel = [Common getMoziSizeSetting:sview3.panel2_DataTypeLabel];
                            sview3.panel2_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview3.panel2_PointLabel = [Common getMoziSizeSetting:sview3.panel2_PointLabel];
                            sview3.panel2_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview3.panel2_UnitLabel1 = [Common getMoziSizeSetting:sview3.panel2_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview3.panel2_AssayVal1.text = @"--";
                                sview3.panel2_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview3.panel2_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview3.panel2_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview3.panel2_MaxValLabel.text = @"--";
                            }else{
                                sview3.panel2_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview3.panel2_MinValLabel.text = @"--";
                            }else{
                                sview3.panel2_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview3.panel2_View3.hidden = YES;
                            }else{
                                sview3.panel2_View3.hidden = NO;
                                sview3.panel2_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"11"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview3.panel3.hidden = YES;
                        }else{
                            sview3.panel3.hidden = NO;
                            sview3.panel3_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview3.panel3_AreaNameLabel = [Common getMoziSizeSetting:sview3.panel3_AreaNameLabel];
                            sview3.panel3_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview3.panel3_DataTypeLabel = [Common getMoziSizeSetting:sview3.panel3_DataTypeLabel];
                            sview3.panel3_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview3.panel3_PointLabel = [Common getMoziSizeSetting:sview3.panel3_PointLabel];
                            sview3.panel3_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview3.panel3_UnitLabel1 = [Common getMoziSizeSetting:sview3.panel3_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview3.panel3_AssayVal1.text = @"--";
                                sview3.panel3_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview3.panel3_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview3.panel3_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview3.panel3_MaxValLabel.text = @"--";
                            }else{
                                sview3.panel3_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview3.panel3_MinValLabel.text = @"--";
                            }else{
                                sview3.panel3_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview3.panel3_View3.hidden = YES;
                            }else{
                                sview3.panel3_View3.hidden = NO;
                                sview3.panel3_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"12"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview3.panel4.hidden = YES;
                        }else{
                            sview3.panel4.hidden = NO;
                            sview3.panel4_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview3.panel4_AreaNameLabel = [Common getMoziSizeSetting:sview3.panel4_AreaNameLabel];
                            sview3.panel4_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview3.panel4_DataTypeLabel = [Common getMoziSizeSetting:sview3.panel4_DataTypeLabel];
                            sview3.panel4_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview3.panel4_PointLabel = [Common getMoziSizeSetting:sview3.panel4_PointLabel];
                            sview3.panel4_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview3.panel4_UnitLabel1 = [Common getMoziSizeSetting:sview3.panel4_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview3.panel4_AssayVal1.text = @"--";
                                sview3.panel4_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview3.panel4_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview3.panel4_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview3.panel4_MaxValLabel.text = @"--";
                            }else{
                                sview3.panel4_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview3.panel4_MinValLabel.text = @"--";
                            }else{
                                sview3.panel4_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview3.panel4_View3.hidden = YES;
                            }else{
                                sview3.panel4_View3.hidden = NO;
                                sview3.panel4_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                }
                if ([panelPage  isEqual: @"4"]) {
                    //バネル番号により分岐
                    //DATASETCDが0なら非表示そうでなければデータを表示
                    if ([panelNum  isEqual: @"13"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview4.panel1.hidden = YES;
                        }else{
                            sview4.panel1.hidden = NO;
                            sview4.panel1_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview4.panel1_AreaNameLabel = [Common getMoziSizeSetting:sview4.panel1_AreaNameLabel];
                            sview4.panel1_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview4.panel1_DataTypeLabel = [Common getMoziSizeSetting:sview4.panel1_DataTypeLabel];
                            sview4.panel1_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview4.panel1_PointLabel = [Common getMoziSizeSetting:sview4.panel1_PointLabel];
                            sview4.panel1_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview4.panel1_UnitLabel1 = [Common getMoziSizeSetting:sview4.panel1_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview4.panel1_AssayVal1.text = @"--";
                                sview4.panel1_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview4.panel1_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview4.panel1_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview4.panel1_MaxValLabel.text = @"--";
                            }else{
                                sview4.panel1_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview4.panel1_MinValLabel.text = @"--";
                            }else{
                                sview4.panel1_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview4.panel1_View3.hidden = YES;
                            }else{
                                sview4.panel1_View3.hidden = NO;
                                sview4.panel1_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"14"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview4.panel2.hidden = YES;
                        }else{
                            sview4.panel2.hidden = NO;
                            sview4.panel2_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview4.panel2_AreaNameLabel = [Common getMoziSizeSetting:sview4.panel2_AreaNameLabel];
                            sview4.panel2_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview4.panel2_DataTypeLabel = [Common getMoziSizeSetting:sview4.panel2_DataTypeLabel];
                            sview4.panel2_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview4.panel2_PointLabel = [Common getMoziSizeSetting:sview4.panel2_PointLabel];
                            sview4.panel2_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview4.panel2_UnitLabel1 = [Common getMoziSizeSetting:sview4.panel2_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview4.panel2_AssayVal1.text = @"--";
                                sview4.panel2_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview4.panel2_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview4.panel2_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview4.panel2_MaxValLabel.text = @"--";
                            }else{
                                sview4.panel2_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview4.panel2_MinValLabel.text = @"--";
                            }else{
                                sview4.panel2_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview4.panel2_View3.hidden = YES;
                            }else{
                                sview4.panel2_View3.hidden = NO;
                                sview4.panel2_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"15"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview4.panel3.hidden = YES;
                        }else{
                            sview4.panel3.hidden = NO;
                            sview4.panel3_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview4.panel3_AreaNameLabel = [Common getMoziSizeSetting:sview4.panel3_AreaNameLabel];
                            sview4.panel3_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview4.panel3_DataTypeLabel = [Common getMoziSizeSetting:sview4.panel3_DataTypeLabel];
                            sview4.panel3_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview4.panel3_PointLabel = [Common getMoziSizeSetting:sview4.panel3_PointLabel];
                            sview4.panel3_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview4.panel3_UnitLabel1 = [Common getMoziSizeSetting:sview4.panel3_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview4.panel3_AssayVal1.text = @"--";
                                sview4.panel3_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview4.panel3_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview4.panel3_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview4.panel3_MaxValLabel.text = @"--";
                            }else{
                                sview4.panel3_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview4.panel3_MinValLabel.text = @"--";
                            }else{
                                sview4.panel3_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview4.panel3_View3.hidden = YES;
                            }else{
                                sview4.panel3_View3.hidden = NO;
                                sview4.panel3_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"16"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview4.panel4.hidden = YES;
                        }else{
                            sview4.panel4.hidden = NO;
                            sview4.panel4_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview4.panel4_AreaNameLabel = [Common getMoziSizeSetting:sview4.panel4_AreaNameLabel];
                            sview4.panel4_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview4.panel4_DataTypeLabel = [Common getMoziSizeSetting:sview4.panel4_DataTypeLabel];
                            sview4.panel4_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview4.panel4_PointLabel = [Common getMoziSizeSetting:sview4.panel4_PointLabel];
                            sview4.panel4_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview4.panel4_UnitLabel1 = [Common getMoziSizeSetting:sview4.panel4_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview4.panel4_AssayVal1.text = @"--";
                                sview4.panel4_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview4.panel4_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview4.panel4_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview4.panel4_MaxValLabel.text = @"--";
                            }else{
                                sview4.panel4_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview4.panel4_MinValLabel.text = @"--";
                            }else{
                                sview4.panel4_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview4.panel4_View3.hidden = YES;
                            }else{
                                sview4.panel4_View3.hidden = NO;
                                sview4.panel4_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                }
                if ([panelPage  isEqual: @"5"]) {
                    //バネル番号により分岐
                    //DATASETCDが0なら非表示そうでなければデータを表示
                    if ([panelNum  isEqual: @"17"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview5.panel1.hidden = YES;
                        }else{
                            sview5.panel1.hidden = NO;
                            sview5.panel1_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview5.panel1_AreaNameLabel = [Common getMoziSizeSetting:sview5.panel1_AreaNameLabel];
                            sview5.panel1_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview5.panel1_DataTypeLabel = [Common getMoziSizeSetting:sview5.panel1_DataTypeLabel];
                            sview5.panel1_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview5.panel1_PointLabel = [Common getMoziSizeSetting:sview5.panel1_PointLabel];
                            sview5.panel1_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview5.panel1_UnitLabel1 = [Common getMoziSizeSetting:sview5.panel1_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview5.panel1_AssayVal1.text = @"--";
                                sview5.panel1_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview5.panel1_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview5.panel1_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview5.panel1_MaxValLabel.text = @"--";
                            }else{
                                sview5.panel1_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview5.panel1_MinValLabel.text = @"--";
                            }else{
                                sview5.panel1_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview5.panel1_View3.hidden = YES;
                            }else{
                                sview5.panel1_View3.hidden = NO;
                                sview5.panel1_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"18"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview5.panel2.hidden = YES;
                        }else{
                            sview5.panel2.hidden = NO;
                            sview5.panel2_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview5.panel2_AreaNameLabel = [Common getMoziSizeSetting:sview5.panel2_AreaNameLabel];
                            sview5.panel2_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview5.panel2_DataTypeLabel = [Common getMoziSizeSetting:sview5.panel2_DataTypeLabel];
                            sview5.panel2_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview5.panel2_PointLabel = [Common getMoziSizeSetting:sview5.panel2_PointLabel];
                            sview5.panel2_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview5.panel2_UnitLabel1 = [Common getMoziSizeSetting:sview5.panel2_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview5.panel2_AssayVal1.text = @"--";
                                sview5.panel2_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview5.panel2_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview5.panel2_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview5.panel2_MaxValLabel.text = @"--";
                            }else{
                                sview5.panel2_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview5.panel2_MinValLabel.text = @"--";
                            }else{
                                sview5.panel2_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview5.panel2_View3.hidden = YES;
                            }else{
                                sview5.panel2_View3.hidden = NO;
                                sview5.panel2_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"19"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview5.panel3.hidden = YES;
                        }else{
                            sview5.panel3.hidden = NO;
                            sview5.panel3_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview5.panel3_AreaNameLabel = [Common getMoziSizeSetting:sview5.panel3_AreaNameLabel];
                            sview5.panel3_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview5.panel3_DataTypeLabel = [Common getMoziSizeSetting:sview5.panel3_DataTypeLabel];
                            sview5.panel3_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview5.panel3_PointLabel = [Common getMoziSizeSetting:sview5.panel3_PointLabel];
                            sview5.panel3_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview5.panel3_UnitLabel1 = [Common getMoziSizeSetting:sview5.panel3_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview5.panel3_AssayVal1.text = @"--";
                                sview5.panel3_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview5.panel3_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview5.panel3_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview5.panel3_MaxValLabel.text = @"--";
                            }else{
                                sview5.panel3_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview5.panel3_MinValLabel.text = @"--";
                            }else{
                                sview5.panel3_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview5.panel3_View3.hidden = YES;
                            }else{
                                sview5.panel3_View3.hidden = NO;
                                sview5.panel3_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"20"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview5.panel4.hidden = YES;
                        }else{
                            sview5.panel4.hidden = NO;
                            sview5.panel4_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview5.panel4_AreaNameLabel = [Common getMoziSizeSetting:sview5.panel4_AreaNameLabel];
                            sview5.panel4_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview5.panel4_DataTypeLabel = [Common getMoziSizeSetting:sview5.panel4_DataTypeLabel];
                            sview5.panel4_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview5.panel4_PointLabel = [Common getMoziSizeSetting:sview5.panel4_PointLabel];
                            sview5.panel4_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview5.panel4_UnitLabel1 = [Common getMoziSizeSetting:sview5.panel4_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview5.panel4_AssayVal1.text = @"--";
                                sview5.panel4_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview5.panel4_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview5.panel4_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview5.panel4_MaxValLabel.text = @"--";
                            }else{
                                sview5.panel4_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview5.panel4_MinValLabel.text = @"--";
                            }else{
                                sview5.panel4_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview5.panel4_View3.hidden = YES;
                            }else{
                                sview5.panel4_View3.hidden = NO;
                                sview5.panel4_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                }
                if ([panelPage  isEqual: @"6"]) {
                    //バネル番号により分岐
                    //DATASETCDが0なら非表示そうでなければデータを表示
                    if ([panelNum  isEqual: @"21"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview6.panel1.hidden = YES;
                        }else{
                            sview6.panel1.hidden = NO;
                            sview6.panel1_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview6.panel1_AreaNameLabel = [Common getMoziSizeSetting:sview6.panel1_AreaNameLabel];
                            sview6.panel1_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview6.panel1_DataTypeLabel = [Common getMoziSizeSetting:sview6.panel1_DataTypeLabel];
                            sview6.panel1_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview6.panel1_PointLabel = [Common getMoziSizeSetting:sview6.panel1_PointLabel];
                            sview6.panel1_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview6.panel1_UnitLabel1 = [Common getMoziSizeSetting:sview6.panel1_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview6.panel1_AssayVal1.text = @"--";
                                sview6.panel1_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview6.panel1_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview6.panel1_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview6.panel1_MaxValLabel.text = @"--";
                            }else{
                                sview6.panel1_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview6.panel1_MinValLabel.text = @"--";
                            }else{
                                sview6.panel1_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview6.panel1_View3.hidden = YES;
                            }else{
                                sview6.panel1_View3.hidden = NO;
                                sview6.panel1_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"22"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview6.panel2.hidden = YES;
                        }else{
                            sview6.panel2.hidden = NO;
                            sview6.panel2_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview6.panel2_AreaNameLabel = [Common getMoziSizeSetting:sview6.panel2_AreaNameLabel];
                            sview6.panel2_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview6.panel2_DataTypeLabel = [Common getMoziSizeSetting:sview6.panel2_DataTypeLabel];
                            sview6.panel2_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview6.panel2_PointLabel = [Common getMoziSizeSetting:sview6.panel2_PointLabel];
                            sview6.panel2_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview6.panel2_UnitLabel1 = [Common getMoziSizeSetting:sview6.panel2_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview6.panel2_AssayVal1.text = @"--";
                                sview6.panel2_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview6.panel2_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview6.panel2_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview6.panel2_MaxValLabel.text = @"--";
                            }else{
                                sview6.panel2_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview6.panel2_MinValLabel.text = @"--";
                            }else{
                                sview6.panel2_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview6.panel2_View3.hidden = YES;
                            }else{
                                sview6.panel2_View3.hidden = NO;
                                sview6.panel2_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"23"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview6.panel3.hidden = YES;
                        }else{
                            sview6.panel3.hidden = NO;
                            sview6.panel3_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview6.panel3_AreaNameLabel = [Common getMoziSizeSetting:sview6.panel3_AreaNameLabel];
                            sview6.panel3_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview6.panel3_DataTypeLabel = [Common getMoziSizeSetting:sview6.panel3_DataTypeLabel];
                            sview6.panel3_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview6.panel3_PointLabel = [Common getMoziSizeSetting:sview6.panel3_PointLabel];
                            sview6.panel3_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview6.panel3_UnitLabel1 = [Common getMoziSizeSetting:sview6.panel3_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview6.panel3_AssayVal1.text = @"--";
                                sview6.panel3_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview6.panel3_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview6.panel3_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview6.panel3_MaxValLabel.text = @"--";
                            }else{
                                sview6.panel3_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview6.panel3_MinValLabel.text = @"--";
                            }else{
                                sview6.panel3_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview6.panel3_View3.hidden = YES;
                            }else{
                                sview6.panel3_View3.hidden = NO;
                                sview6.panel3_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"24"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview6.panel4.hidden = YES;
                        }else{
                            sview6.panel4.hidden = NO;
                            sview6.panel4_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview6.panel4_AreaNameLabel = [Common getMoziSizeSetting:sview6.panel4_AreaNameLabel];
                            sview6.panel4_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview6.panel4_DataTypeLabel = [Common getMoziSizeSetting:sview6.panel4_DataTypeLabel];
                            sview6.panel4_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview6.panel4_PointLabel = [Common getMoziSizeSetting:sview6.panel4_PointLabel];
                            sview6.panel4_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview6.panel4_UnitLabel1 = [Common getMoziSizeSetting:sview6.panel4_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview6.panel4_AssayVal1.text = @"--";
                                sview6.panel4_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview6.panel4_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview6.panel4_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview6.panel4_MaxValLabel.text = @"--";
                            }else{
                                sview6.panel4_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview6.panel4_MinValLabel.text = @"--";
                            }else{
                                sview6.panel4_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview6.panel4_View3.hidden = YES;
                            }else{
                                sview6.panel4_View3.hidden = NO;
                                sview6.panel4_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                }
                if ([panelPage  isEqual: @"7"]) {
                    //バネル番号により分岐
                    //DATASETCDが0なら非表示そうでなければデータを表示
                    if ([panelNum  isEqual: @"25"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview7.panel1.hidden = YES;
                        }else{
                            sview7.panel1.hidden = NO;
                            sview7.panel1_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview7.panel1_AreaNameLabel = [Common getMoziSizeSetting:sview7.panel1_AreaNameLabel];
                            sview7.panel1_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview7.panel1_DataTypeLabel = [Common getMoziSizeSetting:sview7.panel1_DataTypeLabel];
                            sview7.panel1_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview7.panel1_PointLabel = [Common getMoziSizeSetting:sview7.panel1_PointLabel];
                            sview7.panel1_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview7.panel1_UnitLabel1 = [Common getMoziSizeSetting:sview7.panel1_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview7.panel1_AssayVal1.text = @"--";
                                sview7.panel1_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview7.panel1_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview7.panel1_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview7.panel1_MaxValLabel.text = @"--";
                            }else{
                                sview7.panel1_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview7.panel1_MinValLabel.text = @"--";
                            }else{
                                sview7.panel1_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview7.panel1_View3.hidden = YES;
                            }else{
                                sview7.panel1_View3.hidden = NO;
                                sview7.panel1_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"26"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview7.panel2.hidden = YES;
                        }else{
                            sview7.panel2.hidden = NO;
                            sview7.panel2_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview7.panel2_AreaNameLabel = [Common getMoziSizeSetting:sview7.panel2_AreaNameLabel];
                            sview7.panel2_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview7.panel2_DataTypeLabel = [Common getMoziSizeSetting:sview7.panel2_DataTypeLabel];
                            sview7.panel2_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview7.panel2_PointLabel = [Common getMoziSizeSetting:sview7.panel2_PointLabel];
                            sview7.panel2_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview7.panel2_UnitLabel1 = [Common getMoziSizeSetting:sview7.panel2_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview7.panel2_AssayVal1.text = @"--";
                                sview7.panel2_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview7.panel2_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview7.panel2_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview7.panel2_MaxValLabel.text = @"--";
                            }else{
                                sview7.panel2_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview7.panel2_MinValLabel.text = @"--";
                            }else{
                                sview7.panel2_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview7.panel2_View3.hidden = YES;
                            }else{
                                sview7.panel2_View3.hidden = NO;
                                sview7.panel2_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"27"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview7.panel3.hidden = YES;
                        }else{
                            sview7.panel3.hidden = NO;
                            sview7.panel3_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview7.panel3_AreaNameLabel = [Common getMoziSizeSetting:sview7.panel3_AreaNameLabel];
                            sview7.panel3_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview7.panel3_DataTypeLabel = [Common getMoziSizeSetting:sview7.panel3_DataTypeLabel];
                            sview7.panel3_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview7.panel3_PointLabel = [Common getMoziSizeSetting:sview7.panel3_PointLabel];
                            sview7.panel3_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview7.panel3_UnitLabel1 = [Common getMoziSizeSetting:sview7.panel3_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview7.panel3_AssayVal1.text = @"--";
                                sview7.panel3_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview7.panel3_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview7.panel3_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview7.panel3_MaxValLabel.text = @"--";
                            }else{
                                sview7.panel3_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview7.panel3_MinValLabel.text = @"--";
                            }else{
                                sview7.panel3_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview7.panel3_View3.hidden = YES;
                            }else{
                                sview7.panel3_View3.hidden = NO;
                                sview7.panel3_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"28"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview7.panel4.hidden = YES;
                        }else{
                            sview7.panel4.hidden = NO;
                            sview7.panel4_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview7.panel4_AreaNameLabel = [Common getMoziSizeSetting:sview7.panel4_AreaNameLabel];
                            sview7.panel4_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview7.panel4_DataTypeLabel = [Common getMoziSizeSetting:sview7.panel4_DataTypeLabel];
                            sview7.panel4_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview7.panel4_PointLabel = [Common getMoziSizeSetting:sview7.panel4_PointLabel];
                            sview7.panel4_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview7.panel4_UnitLabel1 = [Common getMoziSizeSetting:sview7.panel4_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview7.panel4_AssayVal1.text = @"--";
                                sview7.panel4_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview7.panel4_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview7.panel4_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview7.panel4_MaxValLabel.text = @"--";
                            }else{
                                sview7.panel4_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview7.panel4_MinValLabel.text = @"--";
                            }else{
                                sview7.panel4_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview7.panel4_View3.hidden = YES;
                            }else{
                                sview7.panel4_View3.hidden = NO;
                                sview7.panel4_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                }
                if ([panelPage  isEqual: @"8"]) {
                    //バネル番号により分岐
                    //DATASETCDが0なら非表示そうでなければデータを表示
                    if ([panelNum  isEqual: @"29"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview8.panel1.hidden = YES;
                        }else{
                            sview8.panel1.hidden = NO;
                            sview8.panel1_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview8.panel1_AreaNameLabel = [Common getMoziSizeSetting:sview8.panel1_AreaNameLabel];
                            sview8.panel1_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview8.panel1_DataTypeLabel = [Common getMoziSizeSetting:sview8.panel1_DataTypeLabel];
                            sview8.panel1_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview8.panel1_PointLabel = [Common getMoziSizeSetting:sview8.panel1_PointLabel];
                            sview8.panel1_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview8.panel1_UnitLabel1 = [Common getMoziSizeSetting:sview8.panel1_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview8.panel1_AssayVal1.text = @"--";
                                sview8.panel1_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview8.panel1_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview8.panel1_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview8.panel1_MaxValLabel.text = @"--";
                            }else{
                                sview8.panel1_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview8.panel1_MinValLabel.text = @"--";
                            }else{
                                sview8.panel1_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview8.panel1_View3.hidden = YES;
                            }else{
                                sview8.panel1_View3.hidden = NO;
                                sview8.panel1_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"30"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview8.panel2.hidden = YES;
                        }else{
                            sview8.panel2.hidden = NO;
                            sview8.panel2_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview8.panel2_AreaNameLabel = [Common getMoziSizeSetting:sview8.panel2_AreaNameLabel];
                            sview8.panel2_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview8.panel2_DataTypeLabel = [Common getMoziSizeSetting:sview8.panel2_DataTypeLabel];
                            sview8.panel2_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview8.panel2_PointLabel = [Common getMoziSizeSetting:sview8.panel2_PointLabel];
                            sview8.panel2_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview8.panel2_UnitLabel1 = [Common getMoziSizeSetting:sview8.panel2_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview8.panel2_AssayVal1.text = @"--";
                                sview8.panel2_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview8.panel2_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview8.panel2_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview8.panel2_MaxValLabel.text = @"--";
                            }else{
                                sview8.panel2_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview8.panel2_MinValLabel.text = @"--";
                            }else{
                                sview8.panel2_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview8.panel2_View3.hidden = YES;
                            }else{
                                sview8.panel2_View3.hidden = NO;
                                sview8.panel2_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"31"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview8.panel3.hidden = YES;
                        }else{
                            sview8.panel3.hidden = NO;
                            sview8.panel3_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview8.panel3_AreaNameLabel = [Common getMoziSizeSetting:sview8.panel3_AreaNameLabel];
                            sview8.panel3_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview8.panel3_DataTypeLabel = [Common getMoziSizeSetting:sview8.panel3_DataTypeLabel];
                            sview8.panel3_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview8.panel3_PointLabel = [Common getMoziSizeSetting:sview8.panel3_PointLabel];
                            sview8.panel3_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview8.panel3_UnitLabel1 = [Common getMoziSizeSetting:sview8.panel3_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview8.panel3_AssayVal1.text = @"--";
                                sview8.panel3_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview8.panel3_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview8.panel3_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview8.panel3_MaxValLabel.text = @"--";
                            }else{
                                sview8.panel3_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview8.panel3_MinValLabel.text = @"--";
                            }else{
                                sview8.panel3_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview8.panel3_View3.hidden = YES;
                            }else{
                                sview8.panel3_View3.hidden = NO;
                                sview8.panel3_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"32"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview8.panel4.hidden = YES;
                        }else{
                            sview8.panel4.hidden = NO;
                            sview8.panel4_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview8.panel4_AreaNameLabel = [Common getMoziSizeSetting:sview8.panel4_AreaNameLabel];
                            sview8.panel4_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview8.panel4_DataTypeLabel = [Common getMoziSizeSetting:sview8.panel4_DataTypeLabel];
                            sview8.panel4_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview8.panel4_PointLabel = [Common getMoziSizeSetting:sview8.panel4_PointLabel];
                            sview8.panel4_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview8.panel4_UnitLabel1 = [Common getMoziSizeSetting:sview8.panel4_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview8.panel4_AssayVal1.text = @"--";
                                sview8.panel4_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview8.panel4_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview8.panel4_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview8.panel4_MaxValLabel.text = @"--";
                            }else{
                                sview8.panel4_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview8.panel4_MinValLabel.text = @"--";
                            }else{
                                sview8.panel4_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview8.panel4_View3.hidden = YES;
                            }else{
                                sview8.panel4_View3.hidden = NO;
                                sview8.panel4_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                }
                if ([panelPage  isEqual: @"9"]) {
                    //バネル番号により分岐
                    //DATASETCDが0なら非表示そうでなければデータを表示
                    if ([panelNum  isEqual: @"33"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview9.panel1.hidden = YES;
                        }else{
                            sview9.panel1.hidden = NO;
                            sview9.panel1_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview9.panel1_AreaNameLabel = [Common getMoziSizeSetting:sview9.panel1_AreaNameLabel];
                            sview9.panel1_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview9.panel1_DataTypeLabel = [Common getMoziSizeSetting:sview9.panel1_DataTypeLabel];
                            sview9.panel1_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview9.panel1_PointLabel = [Common getMoziSizeSetting:sview9.panel1_PointLabel];
                            sview9.panel1_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview9.panel1_UnitLabel1 = [Common getMoziSizeSetting:sview9.panel1_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview9.panel1_AssayVal1.text = @"--";
                                sview9.panel1_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview9.panel1_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview9.panel1_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview9.panel1_MaxValLabel.text = @"--";
                            }else{
                                sview9.panel1_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview9.panel1_MinValLabel.text = @"--";
                            }else{
                                sview9.panel1_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview9.panel1_View3.hidden = YES;
                            }else{
                                sview9.panel1_View3.hidden = NO;
                                sview9.panel1_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"34"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview9.panel2.hidden = YES;
                        }else{
                            sview9.panel2.hidden = NO;
                            sview9.panel2_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview9.panel2_AreaNameLabel = [Common getMoziSizeSetting:sview9.panel2_AreaNameLabel];
                            sview9.panel2_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview9.panel2_DataTypeLabel = [Common getMoziSizeSetting:sview9.panel2_DataTypeLabel];
                            sview9.panel2_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview9.panel2_PointLabel = [Common getMoziSizeSetting:sview9.panel2_PointLabel];
                            sview9.panel2_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview9.panel2_UnitLabel1 = [Common getMoziSizeSetting:sview9.panel2_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview9.panel2_AssayVal1.text = @"--";
                                sview9.panel2_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview9.panel2_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview9.panel2_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview9.panel2_MaxValLabel.text = @"--";
                            }else{
                                sview9.panel2_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview9.panel2_MinValLabel.text = @"--";
                            }else{
                                sview9.panel2_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview9.panel2_View3.hidden = YES;
                            }else{
                                sview9.panel2_View3.hidden = NO;
                                sview9.panel2_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"35"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview9.panel3.hidden = YES;
                        }else{
                            sview9.panel3.hidden = NO;
                            sview9.panel3_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview9.panel3_AreaNameLabel = [Common getMoziSizeSetting:sview9.panel3_AreaNameLabel];
                            sview9.panel3_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview9.panel3_DataTypeLabel = [Common getMoziSizeSetting:sview9.panel3_DataTypeLabel];
                            sview9.panel3_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview9.panel3_PointLabel = [Common getMoziSizeSetting:sview9.panel3_PointLabel];
                            sview9.panel3_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview9.panel3_UnitLabel1 = [Common getMoziSizeSetting:sview9.panel3_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview9.panel3_AssayVal1.text = @"--";
                                sview9.panel3_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview9.panel3_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview9.panel3_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview9.panel3_MaxValLabel.text = @"--";
                            }else{
                                sview9.panel3_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview9.panel3_MinValLabel.text = @"--";
                            }else{
                                sview9.panel3_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview9.panel3_View3.hidden = YES;
                            }else{
                                sview9.panel3_View3.hidden = NO;
                                sview9.panel3_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"36"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview9.panel4.hidden = YES;
                        }else{
                            sview9.panel4.hidden = NO;
                            sview9.panel4_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview9.panel4_AreaNameLabel = [Common getMoziSizeSetting:sview9.panel4_AreaNameLabel];
                            sview9.panel4_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview9.panel4_DataTypeLabel = [Common getMoziSizeSetting:sview9.panel4_DataTypeLabel];
                            sview9.panel4_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview9.panel4_PointLabel = [Common getMoziSizeSetting:sview9.panel4_PointLabel];
                            sview9.panel4_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview9.panel4_UnitLabel1 = [Common getMoziSizeSetting:sview9.panel4_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview9.panel4_AssayVal1.text = @"--";
                                sview9.panel4_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview9.panel4_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview9.panel4_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview9.panel4_MaxValLabel.text = @"--";
                            }else{
                                sview9.panel4_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview9.panel4_MinValLabel.text = @"--";
                            }else{
                                sview9.panel4_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview9.panel4_View3.hidden = YES;
                            }else{
                                sview9.panel4_View3.hidden = NO;
                                sview9.panel4_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                }
                if ([panelPage  isEqual: @"10"]) {
                    //バネル番号により分岐
                    //DATASETCDが0なら非表示そうでなければデータを表示
                    if ([panelNum  isEqual: @"37"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview10.panel1.hidden = YES;
                        }else{
                            sview10.panel1.hidden = NO;
                            sview10.panel1_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview10.panel1_AreaNameLabel = [Common getMoziSizeSetting:sview10.panel1_AreaNameLabel];
                            sview10.panel1_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview10.panel1_DataTypeLabel = [Common getMoziSizeSetting:sview10.panel1_DataTypeLabel];
                            sview10.panel1_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview10.panel1_PointLabel = [Common getMoziSizeSetting:sview10.panel1_PointLabel];
                            sview10.panel1_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview10.panel1_UnitLabel1 = [Common getMoziSizeSetting:sview10.panel1_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview10.panel1_AssayVal1.text = @"--";
                                sview10.panel1_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview10.panel1_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview10.panel1_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview10.panel1_MaxValLabel.text = @"--";
                            }else{
                                sview10.panel1_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview10.panel1_MinValLabel.text = @"--";
                            }else{
                                sview10.panel1_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview10.panel1_View3.hidden = YES;
                            }else{
                                sview10.panel1_View3.hidden = NO;
                                sview10.panel1_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"38"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview10.panel2.hidden = YES;
                        }else{
                            sview10.panel2.hidden = NO;
                            sview10.panel2_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview10.panel2_AreaNameLabel = [Common getMoziSizeSetting:sview10.panel2_AreaNameLabel];
                            sview10.panel2_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview10.panel2_DataTypeLabel = [Common getMoziSizeSetting:sview10.panel2_DataTypeLabel];
                            sview10.panel2_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview10.panel2_PointLabel = [Common getMoziSizeSetting:sview10.panel2_PointLabel];
                            sview10.panel2_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview10.panel2_UnitLabel1 = [Common getMoziSizeSetting:sview10.panel2_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview10.panel2_AssayVal1.text = @"--";
                                sview10.panel2_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview10.panel2_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview10.panel2_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview10.panel2_MaxValLabel.text = @"--";
                            }else{
                                sview10.panel2_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview10.panel2_MinValLabel.text = @"--";
                            }else{
                                sview10.panel2_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview10.panel2_View3.hidden = YES;
                            }else{
                                sview10.panel2_View3.hidden = NO;
                                sview10.panel2_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"39"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview10.panel3.hidden = YES;
                        }else{
                            sview10.panel3.hidden = NO;
                            sview10.panel3_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview10.panel3_AreaNameLabel = [Common getMoziSizeSetting:sview10.panel3_AreaNameLabel];
                            sview10.panel3_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview10.panel3_DataTypeLabel = [Common getMoziSizeSetting:sview10.panel3_DataTypeLabel];
                            sview10.panel3_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview10.panel3_PointLabel = [Common getMoziSizeSetting:sview10.panel3_PointLabel];
                            sview10.panel3_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview10.panel3_UnitLabel1 = [Common getMoziSizeSetting:sview10.panel3_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview10.panel3_AssayVal1.text = @"--";
                                sview10.panel3_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview10.panel3_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview10.panel3_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview10.panel3_MaxValLabel.text = @"--";
                            }else{
                                sview10.panel3_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview10.panel3_MinValLabel.text = @"--";
                            }else{
                                sview10.panel3_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview10.panel3_View3.hidden = YES;
                            }else{
                                sview10.panel3_View3.hidden = NO;
                                sview10.panel3_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                    if ([panelNum  isEqual: @"40"]) {
                        if ([dataSetCD  isEqual: @"0"]) {
                            sview10.panel4.hidden = YES;
                        }else{
                            sview10.panel4.hidden = NO;
                            sview10.panel4_AreaNameLabel.text = [userDataDic objectForKey:@"AREANM"];
                            sview10.panel4_AreaNameLabel = [Common getMoziSizeSetting:sview10.panel4_AreaNameLabel];
                            sview10.panel4_DataTypeLabel.text = [userDataDic objectForKey:@"DATATYPE"];
                            sview10.panel4_DataTypeLabel = [Common getMoziSizeSetting:sview10.panel4_DataTypeLabel];
                            sview10.panel4_PointLabel.text = [userDataDic objectForKey:@"POINT"];
                            sview10.panel4_PointLabel = [Common getMoziSizeSetting:sview10.panel4_PointLabel];
                            sview10.panel4_UnitLabel1.text = [userDataDic objectForKey:@"UNIT"];
                            sview10.panel4_UnitLabel1 = [Common getMoziSizeSetting:sview10.panel4_UnitLabel1];
                            if ([userDataDic objectForKey:@"ASSAYVAL"] == [NSNull null]) {
                                sview10.panel4_AssayVal1.text = @"--";
                                sview10.panel4_AssayVal2.text = @"";
                            }else{
                                NSArray *AssayValAry = [[userDataDic objectForKey:@"ASSAYVAL"] componentsSeparatedByString:@"."];
                                sview10.panel4_AssayVal1.text = [AssayValAry objectAtIndex:0];
                                sview10.panel4_AssayVal2.text = [NSString stringWithFormat:@".%@",[AssayValAry objectAtIndex:1]];
                            }
                            if ([userDataDic objectForKey:@"MAXVAL"] == [NSNull null]) {
                                sview10.panel4_MaxValLabel.text = @"--";
                            }else{
                                sview10.panel4_MaxValLabel.text = [userDataDic objectForKey:@"MAXVAL"];
                            }
                            if ([userDataDic objectForKey:@"MINVAL"] == [NSNull null]) {
                                sview10.panel4_MinValLabel.text = @"--";
                            }else{
                                sview10.panel4_MinValLabel.text = [userDataDic objectForKey:@"MINVAL"];
                            }
                            if ([userDataDic objectForKey:@"VAL"] == [NSNull null]) {
                                sview10.panel4_View3.hidden = YES;
                            }else{
                                sview10.panel4_View3.hidden = NO;
                                sview10.panel4_UnitLabel.text = [userDataDic objectForKey:@"UNIT"];
                                [self sekisanChrck:panelNum val:[userDataDic objectForKey:@"VAL"] std:[userDataDic objectForKey:@"STD"]];
                            }
                        }
                    }
                }
            }
            [Common dismissSVProgressHUD];
        });
    });
    
    
}
#pragma mark-積算ゲージ処理
-(void)sekisanChrck:(NSString *)panelNam val:(NSString *)val std:(NSString *)std{
    int panelTag = [panelNam intValue];
    int sekisaiVal = [val intValue];
    int sekisaiStd = [std intValue];
    XuniRadialGauge *radialGauge;
    radialGauge = [[XuniRadialGauge alloc] initWithFrame:CGRectMake(3, 3, 64, 64)];
    radialGauge.tag = panelTag;
    radialGauge.backgroundColor = [UIColor clearColor];
    radialGauge.showText = XuniShowTextValue;
    radialGauge.valueFontColor = RGB(30, 144, 255);
    radialGauge.valueFont = [UIFont boldSystemFontOfSize:50];
    radialGauge.thickness = 0.1;
    radialGauge.min = 0;
    if (sekisaiVal >= 9999) {
        radialGauge.max = 9999;
        radialGauge.value = sekisaiVal;
    }else{
        if (sekisaiVal < sekisaiStd) {
            radialGauge.max = sekisaiStd;
            radialGauge.value = sekisaiVal;
        }else{
            radialGauge.max = sekisaiVal;
            radialGauge.value = sekisaiVal;
        }
    }
    
    radialGauge.showRanges = false;
    radialGauge.pointerColor = RGB(30, 144, 255);
    radialGauge.startAngle = 90;
    radialGauge.sweepAngle = 360;
    radialGauge.loadAnimation.duration = 2;
    radialGauge.updateAnimation.duration = 2;
    
    // 範囲を作成してカスタマイズします。
    XuniGaugeRange* lower = [[XuniGaugeRange alloc] initWithGauge:radialGauge];
    lower.min = 0;
    lower.max = 100;
    lower.color = RGB(0, 191, 255);;
    
    // 範囲を追加します
    [radialGauge.ranges addObject:lower];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDataDic = [ud objectForKey:@"UserData_Key"];
    //ページ数で取得するデータを絞る
    int pageCount = [[userDataDic objectForKey:@"PageCount"] intValue];
    SekisanView *sview1,*sview2,*sview3,*sview4,*sview5,*sview6,*sview7,*sview8,*sview9,*sview10 = nil;
    if(pageCount >= 1){
        sview1 = [self.mainScrollView viewWithTag:sViewTag1];
        if ([panelNam  isEqual: @"1"]) {
            UIView *xuniView = [sview1.panel1_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview1.panel1_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview1.panel1_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"2"]) {
            UIView *xuniView = [sview1.panel2_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview1.panel2_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview1.panel2_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"3"]) {
            UIView *xuniView = [sview1.panel3_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview1.panel3_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview1.panel3_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"4"]) {
            UIView *xuniView = [sview1.panel4_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview1.panel4_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview1.panel4_View3 addSubview:radialGauge];
        }
    }
    if(pageCount >= 2){
        sview2 = [self.mainScrollView viewWithTag:sViewTag2];
        if ([panelNam  isEqual: @"5"]) {
            UIView *xuniView = [sview2.panel1_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview2.panel1_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview2.panel1_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"6"]) {
            UIView *xuniView = [sview2.panel2_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview2.panel2_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview2.panel2_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"7"]) {
            UIView *xuniView = [sview2.panel3_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview2.panel3_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview2.panel3_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"8"]) {
            UIView *xuniView = [sview2.panel4_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview2.panel4_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview2.panel4_View3 addSubview:radialGauge];
        }
    }
    if(pageCount >= 3){
        sview3 = [self.mainScrollView viewWithTag:sViewTag3];
        if ([panelNam  isEqual: @"9"]) {
            UIView *xuniView = [sview3.panel1_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview3.panel1_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview3.panel1_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"10"]) {
            UIView *xuniView = [sview3.panel2_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview3.panel2_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview3.panel2_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"11"]) {
            UIView *xuniView = [sview3.panel3_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview3.panel3_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview3.panel3_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"12"]) {
            UIView *xuniView = [sview3.panel4_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview3.panel4_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview3.panel4_View3 addSubview:radialGauge];
        }
    }
    if(pageCount >= 4){
        sview4 = [self.mainScrollView viewWithTag:sViewTag4];
        if ([panelNam  isEqual: @"13"]) {
            UIView *xuniView = [sview4.panel1_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview4.panel1_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview4.panel1_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"14"]) {
            UIView *xuniView = [sview4.panel2_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview4.panel2_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview4.panel2_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"15"]) {
            UIView *xuniView = [sview4.panel3_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview4.panel3_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview4.panel3_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"16"]) {
            UIView *xuniView = [sview4.panel4_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview4.panel4_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview4.panel4_View3 addSubview:radialGauge];
        }
    }
    if(pageCount >= 5){
        sview5 = [self.mainScrollView viewWithTag:sViewTag5];
        if ([panelNam  isEqual: @"17"]) {
            UIView *xuniView = [sview5.panel1_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview5.panel1_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview5.panel1_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"18"]) {
            UIView *xuniView = [sview5.panel2_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview5.panel2_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview5.panel2_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"19"]) {
            UIView *xuniView = [sview5.panel3_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview5.panel3_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview5.panel3_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"20"]) {
            UIView *xuniView = [sview5.panel4_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview5.panel4_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview5.panel4_View3 addSubview:radialGauge];
        }
    }
    if(pageCount >= 6){
        sview6 = [self.mainScrollView viewWithTag:sViewTag6];
        if ([panelNam  isEqual: @"11"]) {
            UIView *xuniView = [sview6.panel1_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview6.panel1_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview6.panel1_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"22"]) {
            UIView *xuniView = [sview6.panel2_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview6.panel2_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview6.panel2_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"23"]) {
            UIView *xuniView = [sview6.panel3_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview6.panel3_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview6.panel3_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"24"]) {
            UIView *xuniView = [sview6.panel4_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview6.panel4_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview6.panel4_View3 addSubview:radialGauge];
        }
    }
    if(pageCount >= 7){
        sview7 = [self.mainScrollView viewWithTag:sViewTag7];
        if ([panelNam  isEqual: @"25"]) {
            UIView *xuniView = [sview7.panel1_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview7.panel1_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview7.panel1_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"26"]) {
            UIView *xuniView = [sview7.panel2_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview7.panel2_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview7.panel2_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"27"]) {
            UIView *xuniView = [sview7.panel3_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview7.panel3_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview7.panel3_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"28"]) {
            UIView *xuniView = [sview7.panel4_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview7.panel4_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview7.panel4_View3 addSubview:radialGauge];
        }
    }
    if(pageCount >= 8){
        sview8 = [self.mainScrollView viewWithTag:sViewTag8];
        if ([panelNam  isEqual: @"29"]) {
            UIView *xuniView = [sview8.panel1_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview8.panel1_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview8.panel1_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"30"]) {
            UIView *xuniView = [sview8.panel2_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview8.panel2_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview8.panel2_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"31"]) {
            UIView *xuniView = [sview8.panel3_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview8.panel3_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview8.panel3_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"32"]) {
            UIView *xuniView = [sview8.panel4_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview8.panel4_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview8.panel4_View3 addSubview:radialGauge];
        }
    }
    if(pageCount >= 9){
        sview9 = [self.mainScrollView viewWithTag:sViewTag9];
        if ([panelNam  isEqual: @"33"]) {
            UIView *xuniView = [sview9.panel1_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview9.panel1_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview9.panel1_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"34"]) {
            UIView *xuniView = [sview9.panel2_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview9.panel2_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview9.panel2_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"35"]) {
            UIView *xuniView = [sview9.panel3_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview9.panel3_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview9.panel3_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"36"]) {
            UIView *xuniView = [sview9.panel4_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview9.panel4_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview9.panel4_View3 addSubview:radialGauge];
        }
    }
    if(pageCount >= 10){
        sview10 = [self.mainScrollView viewWithTag:sViewTag10];
        if ([panelNam  isEqual: @"37"]) {
            UIView *xuniView = [sview10.panel1_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview10.panel1_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview10.panel1_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"38"]) {
            UIView *xuniView = [sview10.panel2_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview10.panel2_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview10.panel2_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"39"]) {
            UIView *xuniView = [sview10.panel3_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview10.panel3_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview10.panel3_View3 addSubview:radialGauge];
        }
        if ([panelNam  isEqual: @"40"]) {
            UIView *xuniView = [sview10.panel4_View3 viewWithTag: panelTag];
            [xuniView removeFromSuperview];
            sview10.panel4_StdLabel.text = [NSString stringWithFormat:@"/%@",std];
            [sview10.panel4_View3 addSubview:radialGauge];
        }
    }
}

#pragma mark-各ボタン処理

-(void)goList:(int)pageCn{
    int page = pageCn+(PanelPageCount*4);
    areaListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AreaListViewController"];
    areaListViewController.areaPanelNo = page;
    areaListViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:areaListViewController animated:YES completion:nil];
}

- (IBAction)tableBtn:(id)sender {
    BOOL panelChk = NO;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDataDic = [ud objectForKey:@"UserData_Key"];
    //ページ数で取得するデータを絞る
    int pageCount = [[userDataDic objectForKey:@"PageCount"] intValue];
    SekisanView *sview1,*sview2,*sview3,*sview4,*sview5,*sview6,*sview7,*sview8,*sview9,*sview10 = nil;
    if(pageCount >= 1){
        sview1 = [self.mainScrollView viewWithTag:sViewTag1];
    }
    if(pageCount >= 2){
        sview2 = [self.mainScrollView viewWithTag:sViewTag2];
    }
    if(pageCount >= 3){
        sview3 = [self.mainScrollView viewWithTag:sViewTag3];
    }
    if(pageCount >= 4){
        sview4 = [self.mainScrollView viewWithTag:sViewTag4];
    }
    if(pageCount >= 5){
        sview5 = [self.mainScrollView viewWithTag:sViewTag5];
    }
    if(pageCount >= 6){
        sview6 = [self.mainScrollView viewWithTag:sViewTag6];
    }
    if(pageCount >= 7){
        sview7 = [self.mainScrollView viewWithTag:sViewTag7];
    }
    if(pageCount >= 8){
        sview8 = [self.mainScrollView viewWithTag:sViewTag8];
    }
    if(pageCount >= 9){
        sview9 = [self.mainScrollView viewWithTag:sViewTag9];
    }
    if(pageCount >= 10){
        sview10 = [self.mainScrollView viewWithTag:sViewTag10];
    }
    //現在のページで切り分け
    int page = PanelPageCount+1;
    if (page == 1) {
        if ((sview1.panel1.hidden == YES) && (sview1.panel2.hidden == YES) && (sview1.panel3.hidden == YES) &&(sview1.panel4.hidden == YES)) {
            panelChk = YES;
        }
        
    }
    if (page == 2) {
        if ((sview2.panel1.hidden == YES) && (sview2.panel2.hidden == YES) && (sview2.panel3.hidden == YES) &&(sview2.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (page == 3) {
        if ((sview3.panel1.hidden == YES) && (sview3.panel2.hidden == YES) && (sview3.panel3.hidden == YES) &&(sview3.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (page == 4) {
        if ((sview4.panel1.hidden == YES) && (sview4.panel2.hidden == YES) && (sview4.panel3.hidden == YES) &&(sview4.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (page == 5) {
        if ((sview5.panel1.hidden == YES) && (sview5.panel2.hidden == YES) && (sview5.panel3.hidden == YES) &&(sview5.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (page == 6) {
        if ((sview6.panel1.hidden == YES) && (sview6.panel2.hidden == YES) && (sview6.panel3.hidden == YES) &&(sview6.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (page == 7) {
        if ((sview7.panel1.hidden == YES) && (sview7.panel2.hidden == YES) && (sview7.panel3.hidden == YES) &&(sview7.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (page == 8) {
        if ((sview8.panel1.hidden == YES) && (sview8.panel2.hidden == YES) && (sview8.panel3.hidden == YES) &&(sview8.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (page == 9) {
        if ((sview9.panel1.hidden == YES) && (sview9.panel2.hidden == YES) && (sview9.panel3.hidden == YES) &&(sview9.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (page == 10) {
        if ((sview10.panel1.hidden == YES) && (sview10.panel2.hidden == YES) && (sview10.panel3.hidden == YES) &&(sview10.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (panelChk == YES) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"確認" message:@"このページのパネルが設定されていません、＋ボタンから追加したいエリアを選択してください。" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // cancelボタンが押された時の処理
            [self cancelButtonPushed];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
        tableViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        tableViewController.userDataAry = userDataAry;
        tableViewController.pageCount = [NSString stringWithFormat:@"%d",PanelPageCount+1];
        [self presentViewController:tableViewController animated:YES completion:nil];
    }
    
}

- (IBAction)chartBtn:(id)sender {
    BOOL panelChk = NO;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDataDic = [ud objectForKey:@"UserData_Key"];
    //ページ数で取得するデータを絞る
    int pageCount = [[userDataDic objectForKey:@"PageCount"] intValue];
    SekisanView *sview1,*sview2,*sview3,*sview4,*sview5,*sview6,*sview7,*sview8,*sview9,*sview10 = nil;
    if(pageCount >= 1){
        sview1 = [self.mainScrollView viewWithTag:sViewTag1];
    }
    if(pageCount >= 2){
        sview2 = [self.mainScrollView viewWithTag:sViewTag2];
    }
    if(pageCount >= 3){
        sview3 = [self.mainScrollView viewWithTag:sViewTag3];
    }
    if(pageCount >= 4){
        sview4 = [self.mainScrollView viewWithTag:sViewTag4];
    }
    if(pageCount >= 5){
        sview5 = [self.mainScrollView viewWithTag:sViewTag5];
    }
    if(pageCount >= 6){
        sview6 = [self.mainScrollView viewWithTag:sViewTag6];
    }
    if(pageCount >= 7){
        sview7 = [self.mainScrollView viewWithTag:sViewTag7];
    }
    if(pageCount >= 8){
        sview8 = [self.mainScrollView viewWithTag:sViewTag8];
    }
    if(pageCount >= 9){
        sview9 = [self.mainScrollView viewWithTag:sViewTag9];
    }
    if(pageCount >= 10){
        sview10 = [self.mainScrollView viewWithTag:sViewTag10];
    }
    //現在のページで切り分け
    int page = PanelPageCount+1;
    if (page == 1) {
        if ((sview1.panel1.hidden == YES) && (sview1.panel2.hidden == YES) && (sview1.panel3.hidden == YES) &&(sview1.panel4.hidden == YES)) {
            panelChk = YES;
        }
        
    }
    if (page == 2) {
        if ((sview2.panel1.hidden == YES) && (sview2.panel2.hidden == YES) && (sview2.panel3.hidden == YES) &&(sview2.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (page == 3) {
        if ((sview3.panel1.hidden == YES) && (sview3.panel2.hidden == YES) && (sview3.panel3.hidden == YES) &&(sview3.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (page == 4) {
        if ((sview4.panel1.hidden == YES) && (sview4.panel2.hidden == YES) && (sview4.panel3.hidden == YES) &&(sview4.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (page == 5) {
        if ((sview5.panel1.hidden == YES) && (sview5.panel2.hidden == YES) && (sview5.panel3.hidden == YES) &&(sview5.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (page == 6) {
        if ((sview6.panel1.hidden == YES) && (sview6.panel2.hidden == YES) && (sview6.panel3.hidden == YES) &&(sview6.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (page == 7) {
        if ((sview7.panel1.hidden == YES) && (sview7.panel2.hidden == YES) && (sview7.panel3.hidden == YES) &&(sview7.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (page == 8) {
        if ((sview8.panel1.hidden == YES) && (sview8.panel2.hidden == YES) && (sview8.panel3.hidden == YES) &&(sview8.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (page == 9) {
        if ((sview9.panel1.hidden == YES) && (sview9.panel2.hidden == YES) && (sview9.panel3.hidden == YES) &&(sview9.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (page == 10) {
        if ((sview10.panel1.hidden == YES) && (sview10.panel2.hidden == YES) && (sview10.panel3.hidden == YES) &&(sview10.panel4.hidden == YES)) {
            panelChk = YES;
        }
    }
    if (panelChk == YES) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"確認" message:@"このページのパネルが設定されていません、＋ボタンから追加したいエリアを選択してください。" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // cancelボタンが押された時の処理
            [self cancelButtonPushed];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        chartViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ChartViewController"];
        chartViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        chartViewController.userDataAry = userDataAry;
        chartViewController.pageCount = [NSString stringWithFormat:@"%d",PanelPageCount+1];
        [self presentViewController:chartViewController animated:YES completion:nil];
    }
    
}

- (IBAction)settingBtn:(id)sender {
    settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    settingViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:settingViewController animated:YES completion:nil];
}

- (IBAction)linkBtn:(id)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"確認" message:@"「全国港湾海洋波浪情報網（ナウファス）」ページへ移動します。\nよろしいですか？" preferredStyle:UIAlertControllerStyleAlert];
    
    // addActionした順に左から右にボタンが配置されます
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // otherボタンが押された時の処理
        [self otherButtonPushed];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"キャンセル" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // cancelボタンが押された時の処理
        [self cancelButtonPushed];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)diaryBtn:(id)sender{
    diaryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DiaryViewController"];
    diaryViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:diaryViewController animated:YES completion:nil];
}
- (IBAction)chatBtn:(id)sender{
    threadViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ThreadViewController"];
    threadViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:threadViewController animated:YES completion:nil];
}

- (void)cancelButtonPushed{
    
}
- (void)otherButtonPushed{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.mlit.go.jp/kowan/nowphas/"]];
}

#pragma mark-ページング処理
- (IBAction)pageControl:(id)sender {
    // スクロールビューのframeを取得
    CGRect frame = self.mainScrollView.frame;
    // _scrollViewのフレームを現在のpageControlの値に合わせる
    frame.origin.x = frame.size.width * _pageControl.currentPage;
    frame.origin.y = 0;
    // スクロールビューを現在の可視領域にスクロールさせる
    [self.mainScrollView scrollRectToVisible:frame animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = self.mainScrollView.frame.size.width;
    self.pageControl.currentPage = floor((self.mainScrollView.contentOffset.x - pageWidth / 2) / pageWidth ) + 1;
    PanelPageCount = (int)self.pageControl.currentPage;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}
@end
