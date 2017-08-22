//
//  IAdjacentDaySlotTemplate.h
//  XuniCalendar
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef IAdjacentDaySlotTemplate_h
#define IAdjacentDaySlotTemplate_h

/**
*  IAdjacentDaySlotTemplate プロトコル
*/
@protocol IAdjacentDaySlotTemplate

/**
*  カスタム隣接日スロットビューを取得します。
*    @param date  日付
*    @param frame カスタム隣接日スロットビューのフレーム
*    @return カスタム隣接日スロットビュー
*/
- (UIView *)getView:(NSDate *)date frame:(CGRect)frame;

@end

#endif /* IAdjacentDaySlotTemplate_h */
