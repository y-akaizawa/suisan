//
//  ChartData.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ChartData.h"

@implementation ChartData

- (id)initWithPanelName:(NSString *)name name2:(NSString *)name2 panelANum:(NSNumber *)panelANum panelBNum:(NSNumber *)panelBNum panelCNum:(NSNumber *)panelCNum panelDNum:(NSNumber *)panelDNum{
    self = [super init];
    if(self){
        _name = name;
        _name2 = name2;
        _panelANum = panelANum;
        _panelBNum = panelBNum;
        _panelCNum = panelCNum;
        _panelDNum = panelDNum;
    }
    return self;
}
+(NSMutableArray *)chartData:(NSString *)dataStr heikin:(NSString *)heikin tdflg:(NSString *)tdflg pageCount:(NSString *)pageCount{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDataDic = [ud objectForKey:@"UserData_Key"];
    //各パネルのデータセットコード取得
    NSString *aDataSetCD = @"";
    NSString *bDataSetCD = @"";
    NSString *cDataSetCD = @"";
    NSString *dDataSetCD = @"";
    
    if ([pageCount  isEqual: @"1"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD1"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD2"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD3"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD4"];
    }
    if ([pageCount  isEqual: @"2"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD5"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD6"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD7"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD8"];
    }
    if ([pageCount  isEqual: @"3"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD9"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD10"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD11"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD12"];
    }
    if ([pageCount  isEqual: @"4"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD13"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD14"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD15"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD16"];
    }
    if ([pageCount  isEqual: @"5"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD17"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD18"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD19"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD20"];
    }
    if ([pageCount  isEqual: @"6"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD21"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD22"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD23"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD24"];
    }
    if ([pageCount  isEqual: @"7"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD25"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD26"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD27"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD28"];
    }
    if ([pageCount  isEqual: @"8"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD29"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD30"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD31"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD32"];
    }
    if ([pageCount  isEqual: @"9"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD33"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD34"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD35"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD36"];
    }
    if ([pageCount  isEqual: @"10"]) {
        aDataSetCD = [userDataDic objectForKey:@"DataSetCD37"];
        bDataSetCD = [userDataDic objectForKey:@"DataSetCD38"];
        cDataSetCD = [userDataDic objectForKey:@"DataSetCD39"];
        dDataSetCD = [userDataDic objectForKey:@"DataSetCD40"];
    }
    
    NSMutableArray *ary;
    if ([heikin  isEqual: @"0"]) {
        //ary = [PHPConnection getTableData14:aDataSetCD dataSetCD2:bDataSetCD dataSetCD3:cDataSetCD dataSetCD4:cd4 targetDate:dataStr targetDateCD4:tCD4 targetDateflg:tdflg];
        ary = [PHPConnection getTableData14_2:aDataSetCD dataSetCD2:bDataSetCD dataSetCD3:cDataSetCD dataSetCD4:dDataSetCD targetDate:dataStr targetDateflg:tdflg];
    }else{
        ary = [PHPConnection getTableHeikinData14_2:aDataSetCD dataSetCD2:bDataSetCD dataSetCD3:cDataSetCD dataSetCD4:dDataSetCD targetDate:dataStr targetDateflg:tdflg heikin:heikin];
        //ary = [PHPConnection getTableHeikinData14:aDataSetCD dataSetCD2:bDataSetCD dataSetCD3:cDataSetCD dataSetCD4:cd4 targetDate:dataStr targetDateCD4:tCD4 targetDateflg:tdflg heikin:heikin];
    }
    NSMutableArray *chartDataAry = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSDictionary *dic in ary) {
        ChartData *chartdata = [[ChartData alloc] init];
        NSString *dateStr = [dic objectForKey:@"DATE"];
        NSString *dateText = [NSString stringWithFormat:@"%@日%@時",
                              [dateStr substringWithRange:NSMakeRange(6, 2)],
                              [dateStr substringWithRange:NSMakeRange(8, 2)]];
        chartdata.name = dateText;
        chartdata.name2 = dateStr;
        if ([aDataSetCD  isEqual: @"0"]) {
        }else{
            if ([dic objectForKey:@"VAL1"] == [NSNull null]) {
                chartdata.panelANum = nil;
            }else{
                chartdata.panelANum = [NSNumber numberWithFloat:[[dic objectForKey:@"VAL1"] floatValue]];
            }
        }
        if ([bDataSetCD  isEqual: @"0"]) {
        }else{
            if ([dic objectForKey:@"VAL2"] == [NSNull null]) {
                chartdata.panelBNum = nil;
            }else{
                chartdata.panelBNum = [NSNumber numberWithFloat:[[dic objectForKey:@"VAL2"] floatValue]];
            }
        }
        if ([cDataSetCD  isEqual: @"0"]) {
        }else{
            if ([dic objectForKey:@"VAL3"] == [NSNull null]) {
                chartdata.panelCNum = nil;
            }else{
                chartdata.panelCNum = [NSNumber numberWithFloat:[[dic objectForKey:@"VAL3"] floatValue]];
            }
        }
        if ([dDataSetCD isEqual: @"0"]) {
        }else{
            if ([dic objectForKey:@"VAL4"] == [NSNull null]) {
                chartdata.panelDNum = nil;
            }else{
                chartdata.panelDNum = [NSNumber numberWithFloat:[[dic objectForKey:@"VAL4"] floatValue]];
            }
        }
        [chartDataAry addObject:chartdata];
    }
    NSMutableArray *dataAry = [[NSMutableArray alloc] initWithCapacity:0];
    for(ChartData *objData in [chartDataAry reverseObjectEnumerator]){
        [dataAry addObject: objData];
    }
    return dataAry;
}
@end
