//
//  GetArrayObject.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/31.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetArrayObject : NSObject

+(NSMutableArray *)heikinData;//表示内容
+(NSMutableArray *)heikinNumData;//取得内容

+(NSMutableArray *)yearDayData;//表示内容
+(NSMutableArray *)yearDayNumData;//取得内容

+(NSMutableArray *)allAreaData;//表示内容
+(NSMutableArray *)allAreaCDData;//表示内容のエリアコード

@end
