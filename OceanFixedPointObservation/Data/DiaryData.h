//
//  DiaryData.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2017/05/23.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiaryData : NSObject

@property NSString *name;
- (id)initWithName:(NSString *)name;

+ (NSMutableArray *)year;
+ (NSMutableArray *)month;
+ (NSMutableArray *)day;
+ (NSMutableArray *)time;
+ (NSMutableArray *)place;
+ (NSMutableArray *)place2;
+ (NSMutableArray *)page;

@end
