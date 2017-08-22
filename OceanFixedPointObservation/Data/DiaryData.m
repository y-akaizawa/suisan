//
//  DiaryData.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2017/05/23.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import "DiaryData.h"

@implementation DiaryData

- (id)initWithName:(NSString *)name{
    self = [super init];
    if(self){
        _name = name;
    }
    return self;
}

+ (NSMutableArray *)year{
    NSMutableArray *yearArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray *array = @[@"2016",@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023",@"2024",@"2025",@"2026",@"2027",@"2028",@"2029",@"2030"];
    for (int i = 0; i < array.count; i++) {
        DiaryData *data = [[DiaryData alloc]initWithName:array[i]];
        [yearArray addObject:data];
    }
    return yearArray;
}
+ (NSMutableArray *)month{
    NSMutableArray *monthArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 12; i++) {
        DiaryData *data;
        if (i < 9) {
            data = [[DiaryData alloc]initWithName:[NSString stringWithFormat:@"0%d",i+1]];
        }else{
            data = [[DiaryData alloc]initWithName:[NSString stringWithFormat:@"%d",i+1]];
        }
        [monthArray addObject:data];
    }
    return monthArray;
}
+ (NSMutableArray *)day{
    NSMutableArray *dayArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 31; i++) {
        DiaryData *data;
        if (i < 9) {
            data = [[DiaryData alloc]initWithName:[NSString stringWithFormat:@"0%d",i+1]];
        }else{
            data = [[DiaryData alloc]initWithName:[NSString stringWithFormat:@"%d",i+1]];
        }
        [dayArray addObject:data];
    }
    return dayArray;
}
+ (NSMutableArray *)time{
    NSMutableArray *timeArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 24; i++) {
        DiaryData *data;
        if (i < 10) {
            data = [[DiaryData alloc]initWithName:[NSString stringWithFormat:@"0%d",i]];
        }else{
            data = [[DiaryData alloc]initWithName:[NSString stringWithFormat:@"%d",i]];
        }
        [timeArray addObject:data];
    }
    return timeArray;
}
+ (NSMutableArray *)place{
    NSMutableArray *placeArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *allAreaAry = [PHPConnection getDatasetList:0];
    DiaryData *data = [[DiaryData alloc]initWithName:@"指定なし"];
    [placeArray addObject:data];
    for( NSDictionary * areaDic in allAreaAry) {
        NSString *areaStr = [NSString stringWithFormat:@"%@ %@ %@",
                                   [areaDic objectForKey:@"AREANM"],
                                   [areaDic objectForKey:@"DATATYPE"],
                                   [areaDic objectForKey:@"POINT"]];
        DiaryData *data = [[DiaryData alloc]initWithName:areaStr];
        [placeArray addObject:data];
    }
    return placeArray;
}
+ (NSMutableArray *)place2{
    NSMutableArray *placeArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *allAreaAry = [PHPConnection getDatasetList:0];
    for( NSDictionary * areaDic in allAreaAry) {
        NSString *areaStr = [NSString stringWithFormat:@"%@ %@ %@",
                             [areaDic objectForKey:@"AREANM"],
                             [areaDic objectForKey:@"DATATYPE"],
                             [areaDic objectForKey:@"POINT"]];
        DiaryData *data = [[DiaryData alloc]initWithName:areaStr];
        [placeArray addObject:data];
    }
    return placeArray;
}
+ (NSMutableArray *)page{
    NSMutableArray *pageArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 1; i < 11; i++) {
        DiaryData *data;
        data = [[DiaryData alloc]initWithName:[NSString stringWithFormat:@"%d",i]];
        [pageArray addObject:data];
    }
    return pageArray;
}
@end
