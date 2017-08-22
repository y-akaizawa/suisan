//
//  TableData1.m
//
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "TableData1.h"

@implementation TableData1

-(id)initWithTableData:(NSString *)dayStr dayStr2:(NSString *)dayStr2 panelAStr:(NSString *)panelAStr panelBStr:(NSString *)panelBStr  panelCStr:(NSString *)panelCStr panelDStr:(NSString *)panelDStr{
    self = [super init];
    if(self){
        _dayStr = dayStr;
        _dayStr2 = dayStr2;
        _panelAStr = panelAStr;
        _panelBStr = panelBStr;
        _panelCStr = panelCStr;
        _panelDStr = panelDStr;
    }
    return self;
}

+(NSMutableArray *) getTableData: (NSMutableArray *) dataAry{
    NSMutableArray *tableDataAry = [[NSMutableArray alloc] initWithCapacity:0];
    for(NSDictionary *dic in dataAry) {
        TableData1 *tabledata = [[TableData1 alloc] init];
        NSString *dateStr = [dic objectForKey:@"DATE"];
        
        NSString *dayStr = [dateStr substringWithRange:NSMakeRange(6, 2)];
        NSString *timeStr = [dateStr substringWithRange:NSMakeRange(8, 2)];
        if([[dayStr substringWithRange:NSMakeRange(0, 1)]  isEqual: @"0"]){
            dayStr = [dayStr substringWithRange:NSMakeRange(1, 1)];
        }
        if([[timeStr substringWithRange:NSMakeRange(0, 1)]  isEqual: @"0"]){
            timeStr = [timeStr substringWithRange:NSMakeRange(1, 1)];
        }
        NSString *dateText = [NSString stringWithFormat:@"%@日%@時",dayStr,timeStr];
//        NSString *dateText = [NSString stringWithFormat:@"%@日%@時",[dateStr substringWithRange:NSMakeRange(6, 2)],[dateStr substringWithRange:NSMakeRange(8, 2)]];
        tabledata.dayStr = dateText;
        tabledata.dayStr2 = dateStr;
        if ([dic objectForKey:@"VAL1"] == [NSNull null]) {
            tabledata.panelAStr = nil;
        }else{
            if([[dic objectForKey:@"VAL1"] rangeOfString:@"."].location != NSNotFound){
                tabledata.panelAStr = [dic objectForKey:@"VAL1"];
            }else{
                tabledata.panelAStr = [NSString stringWithFormat:@"%@%@",[dic objectForKey:@"VAL1"],@".0"];
            }
        }
        if ([dic objectForKey:@"VAL2"] == [NSNull null]) {
            tabledata.panelBStr = nil;
        }else{
            if([[dic objectForKey:@"VAL2"] rangeOfString:@"."].location != NSNotFound){
                tabledata.panelBStr = [dic objectForKey:@"VAL2"];
            }else{
                tabledata.panelBStr = [NSString stringWithFormat:@"%@%@",[dic objectForKey:@"VAL2"],@".0"];
            }
        }
        if ([dic objectForKey:@"VAL3"] == [NSNull null]) {
            tabledata.panelCStr = nil;
        }else{
            if([[dic objectForKey:@"VAL3"] rangeOfString:@"."].location != NSNotFound){
                tabledata.panelCStr = [dic objectForKey:@"VAL3"];
            }else{
                tabledata.panelCStr = [NSString stringWithFormat:@"%@%@",[dic objectForKey:@"VAL3"],@".0"];
            }
        }
        if ([dic objectForKey:@"VAL4"] == [NSNull null]) {
            tabledata.panelDStr = nil;
        }else{
            if([[dic objectForKey:@"VAL4"] rangeOfString:@"."].location != NSNotFound){
                tabledata.panelDStr = [dic objectForKey:@"VAL4"];
            }else{
                tabledata.panelDStr = [NSString stringWithFormat:@"%@%@",[dic objectForKey:@"VAL4"],@".0"];
            }
        }
        [tableDataAry addObject:tabledata];
    }
    
    return tableDataAry;
}


@end
