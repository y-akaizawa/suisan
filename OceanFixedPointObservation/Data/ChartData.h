//
//  ChartData.h
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChartData : NSObject

@property NSString *name;
@property NSString *name2;

@property NSNumber *panelANum;
@property NSNumber *panelBNum;
@property NSNumber *panelCNum;
@property NSNumber *panelDNum;


- (id)initWithPanelName:(NSString *)name name2:(NSString *)name2 panelANum:(NSNumber *)panelANum panelBNum:(NSNumber *)panelBNum panelCNum:(NSNumber *)panelCNum panelDNum:(NSNumber *)panelDNum;

+(NSMutableArray *)chartData:(NSString *)dataStr heikin:(NSString *)heikin tdflg:(NSString *)tdflg pageCount:(NSString *)pageCount;


@end
