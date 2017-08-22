//
//  IDaySlotTemplate.h
//  XuniCalendar
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#ifndef IDaySlotTemplate_h
#define IDaySlotTemplate_h

/**
*  IDaySlotTemplate プロトコル
*/
@protocol IDaySlotTemplate

/**
*  カスタム日スロットビューを取得します。
*    @param date  日付
*    @param frame カスタム日スロットビューのフレーム
*    @return カスタム日スロットビュー
*/
- (UIView *)getView:(NSDate *)date frame:(CGRect)frame;

@end

#endif /* IDaySlotTemplate_h */
