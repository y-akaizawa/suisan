//
//  IDayOfWeekSlotTemplate.h
//  XuniCalendar
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef IDayOfWeekSlotTemplate_h
#define IDayOfWeekSlotTemplate_h

/**
*  IDayOfWeekSlotTemplate プロトコル
*/
@protocol IDayOfWeekSlotTemplate

/**
*  カスタム曜日スロットビューを取得します。
*    @param dayOfWeek 曜日
*    @param frame     カスタム曜日スロットビューのフレーム
*    @return カスタム曜日スロットビュー
*/
- (UIView *)getView:(XuniDayOfWeek)dayOfWeek frame:(CGRect)frame;

@end

#endif /* IDayOfWeekSlotTemplate_h */
