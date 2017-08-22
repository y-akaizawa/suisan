//
//  TableData1.h
//  
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableData1 : NSObject
@property NSString *dayStr;
@property NSString *dayStr2;
@property NSString *panelAStr;
@property NSString *panelBStr;
@property NSString *panelCStr;
@property NSString *panelDStr;




-(id)initWithTableData:(NSString *)dayStr dayStr2:(NSString *)dayStr2 panelAStr:(NSString *)panelAStr panelBStr:(NSString *)panelBStr  panelCStr:(NSString *)panelCStr panelDStr:(NSString *)panelDStr;
+(NSMutableArray *) getTableData: (NSMutableArray *) dataAry;


///TODO - remove obsolete properties and constructor


/*@property NSNumber *weight;
@property NSString *first, *last, *father, *brother, *cousin;

@property NSDate *hireDate;*/

@end
