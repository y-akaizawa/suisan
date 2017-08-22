//
//  GetArrayObject.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/31.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import "GetArrayObject.h"

@implementation GetArrayObject

+(NSMutableArray *)heikinData{
    NSMutableArray *heikinnAry = [NSMutableArray arrayWithObjects:
                                  @"実測値",
                                  @"25時間平均",
                                  @"24時間平均",
                                  @"18時間平均",
                                  @"12時間平均",
                                  @"9時間平均",
                                  @"6時間平均",
                                  @"3時間平均",
                                  nil];
    return heikinnAry;
}
+(NSMutableArray *)heikinNumData{
    NSMutableArray *heikinnAry = [NSMutableArray arrayWithObjects:
                                  @"0",
                                  @"25",
                                  @"24",
                                  @"18",
                                  @"12",
                                  @"9",
                                  @"6",
                                  @"3",
                                  nil];
    return heikinnAry;
}


+(NSMutableArray *)yearDayData{
    NSMutableArray *yearDayAry = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 365; i++) {
        [yearDayAry addObject:[NSString stringWithFormat:@"%d日前",i+1]];
    }
    return yearDayAry;
}
+(NSMutableArray *)yearDayNumData{
    NSMutableArray *yearDayAry = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 365; i++) {
        [yearDayAry addObject:[NSString stringWithFormat:@"%d",i+1]];
    }
    return yearDayAry;
}


+(NSMutableArray *)allAreaData{
    NSMutableArray *allAreaAry = [PHPConnection getDatasetList2:0];
    NSMutableArray *allAreaNameAry = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * areaDic in allAreaAry) {
        [allAreaNameAry addObject:[NSString stringWithFormat:@"%@ %@ %@",
                                   [areaDic objectForKey:@"AREANM"],
                                   [areaDic objectForKey:@"DATATYPE"],
                                   [areaDic objectForKey:@"POINT"]]];
    }
    return allAreaNameAry;
}

+(NSMutableArray *)allAreaCDData{
    NSMutableArray *allAreaAry = [PHPConnection getDatasetList2:0];
    NSMutableArray *allAreaNameAry = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * areaDic in allAreaAry) {
        [allAreaNameAry addObject:[NSString stringWithFormat:@"%@",
                                   [areaDic objectForKey:@"DATASETCD"]]];
    }
    return allAreaNameAry;
}


@end
