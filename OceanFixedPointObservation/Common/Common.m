//
//  Common.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/22.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import "Common.h"

@implementation Common

NSString *const maxBackCount = @"2016010100";//戻れる最大;

+(CGRect)getScreenSize{
    UIScreen *sc = [UIScreen mainScreen];
    CGRect rect = sc.bounds;
    return rect;
}

+(int)getScreenSizeInt{
    UIScreen *sc = [UIScreen mainScreen];
    CGRect rect = sc.bounds;
    int screenInt = 0;
    if (rect.size.width == 320) {
        screenInt = 1;
    }
    if (rect.size.width == 375) {
        screenInt = 2;
    }
    if (rect.size.width == 414) {
        screenInt = 3;
    }
    return screenInt;
}

+(CGRect)getCenterFrameWithView:(UIView*)argView parent:(UIView*)argParentView
{
    CGFloat x;
    CGFloat y;
    CGFloat width;
    CGFloat height;
    
    CGFloat margin_x;
    CGFloat margin_y;
    
    width = argView.frame.size.width;
    height = argView.frame.size.height;
    
    margin_x = argParentView.frame.size.width - width;
    margin_y = argParentView.frame.size.height - height;
    
    x = margin_x / 2.0f;
    y = margin_y / 2.0f;
    
    return CGRectMake(x, y, width, height);
}
//現在時刻年月日時
+(NSString *)getTimeStringS{
    NSDate *datetime = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMddHHmmss";
    NSString *time = [fmt stringFromDate:datetime];
    return time;
}
+(NSString *)getTimeString{
    NSDate *datetime = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMddHH";
    NSString *time = [fmt stringFromDate:datetime];
    return time;
}
+(NSString *)getMinus14TimeString:(NSString *)dateStr{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    if (dateStr.length == 10) {
        [formatter setDateFormat:@"yyyyMMddHH"];
    }else{
        [formatter setDateFormat:@"yyyyMMdd"];
    }
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:60 * 60 * 9]];
    NSDate *datetime = [formatter dateFromString:dateStr];
    NSDate *futerDate = [datetime initWithTimeInterval:-(13*60*60*24) sinceDate:datetime];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMddHH";
    NSString *time = [fmt stringFromDate:futerDate];
    return time;
}
+(NSString *)getPlus14TimeString:(NSString *)dateStr{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    if (dateStr.length == 10) {
        [formatter setDateFormat:@"yyyyMMddHH"];
    }else{
        [formatter setDateFormat:@"yyyyMMdd"];
    }
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:60 * 60 * 9]];
    NSDate *datetime = [formatter dateFromString:dateStr];
    NSDate *futerDate = [datetime initWithTimeInterval:(13*60*60*24) sinceDate:datetime];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMddHH";
    NSString *time = [fmt stringFromDate:futerDate];
    return time;
}

+(NSString *)getPlus1TimeString:(NSString *)dateStr{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    if (dateStr.length == 10) {
        [formatter setDateFormat:@"yyyyMMddHH"];
    }else{
        [formatter setDateFormat:@"yyyyMMdd"];
    }
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:60 * 60 * 9]];
    NSDate *datetime = [formatter dateFromString:dateStr];
    NSDate *futerDate = [datetime initWithTimeInterval:(1*60*60*24) sinceDate:datetime];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMddHH";
    NSString *time = [fmt stringFromDate:futerDate];
    return time;
}

+(NSDate *)minTimeString{
    // NSCalendar を取得します。
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    // NSDateComponents を作成して、そこに作成したい情報をセットします。
    NSDateComponents* components = [[NSDateComponents alloc] init];
    components.year = 2016;
    components.month = 1;
    components.day = 1;
    
    // NSCalendar を使って、NSDateComponents を NSDate に変換します。
    NSDate* date = [calendar dateFromComponents:components];
    return date;

}

-(BOOL)getMaxBackCountFlag:(NSString *)dateStr{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    //渡されてきた現在表示中の表、グラフの最初の日にちの桁数に合わせてNSDateFormatterを作成
    if (dateStr.length == 10) {
        [formatter setDateFormat:@"yyyyMMddHH"];
    }else{
        [formatter setDateFormat:@"yyyyMMdd"];
    }
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:60 * 60 * 9]];
    //渡されてきた日付をNSDateに変換する
    NSDate *datetime = [formatter dateFromString:dateStr];
    //渡されてきた日付から14日前の日付を取得
    NSDate *futerDate = [datetime initWithTimeInterval:-(14*60*60*24) sinceDate:datetime];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMddHH";
    //取得した14日前の日付をStringに変換
    NSString *time = [fmt stringFromDate:futerDate];
    
    //戻れる日にち
    NSDate *maxBackTime = [fmt dateFromString:maxBackCount];
    //現在選択している日にち
    NSDate *nowtime = [fmt dateFromString:time];
    //取得した14日前の日付がmaxBackCountよりも前かどうかを比較
    NSComparisonResult result = [maxBackTime compare:nowtime];
    //maxBackCountFkag = YES = 14日前がmaxBackCountよりも前、または同一時刻
    //maxBackCountFkag = NO  = 14日前がmaxBackCountよりもあと
    BOOL maxBackCountFkag = NO;
    switch (result) {
        case NSOrderedSame:
            // 同一時刻
            maxBackCountFkag = YES;
            break;
        case NSOrderedAscending:
            // nowよりotherDateのほうが未来
            break;
        case NSOrderedDescending:
            // nowよりotherDateのほうが過去
            maxBackCountFkag = YES;
            break;
    }
    
    return maxBackCountFkag;
}

+ (UILabel *)getLabelSize:(UILabel *)label
                     text:(NSString *)text
               labelWidth:(float)labelWidth
                   margin:(float)margin{
    UILabel *cellLabel = label;
    NSString *textStr = text;
    cellLabel.text = textStr;
    [cellLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [cellLabel setNumberOfLines:0];
    CGRect rect = [cellLabel frame];
    rect.size = CGSizeMake(labelWidth, 5000);
    [cellLabel setFrame:rect];
    [cellLabel sizeToFit];
    //上下に余白をとらせるため
    cellLabel.frame = CGRectMake(cellLabel.frame.origin.x, cellLabel.frame.origin.y
                                 , cellLabel.frame.size.width, cellLabel.frame.size.height+margin);
    return cellLabel;
}

+ (UILabel *)getMoziSizeSetting:(UILabel *)label{
    UILabel *slabel =label;
    slabel.adjustsFontSizeToFitWidth = YES;
    slabel.minimumScaleFactor = 8.f/20.f;
    return slabel;
}

+ (void)showSVProgressHUD:(NSString *)message{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setFont:[UIFont fontWithName:@"HiraKakuProN-W6" size:15]];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    if ([message  isEqual: @""]) {
        [SVProgressHUD showWithStatus:@"読み込み中です…\nしばらくお待ち下さい。"];
    }else{
        [SVProgressHUD showWithStatus:message];
    }
}
+ (void)dismissSVProgressHUD{
    [SVProgressHUD dismiss];
}
+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    return randomString;
}

// 正規表現を利用、メールアドレスのフォーマットチェック
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}


+(double)chartMax:(double)max min:(double)min{
    double setMaxD = max;
    if (max != 0 && min != 100.0) {
        double difference = max - min;
        
        double scalefactor = 0.12;
        
        if (difference <= 1.0) {
            scalefactor = 2.0;
        } else if (difference <= 2.0) {
            scalefactor = 0.75;
        } else if (difference <= 4.0) {
            scalefactor = 0.33;
        }
        setMaxD = max + difference * scalefactor;
    }
    return setMaxD;
}
+(double)chartMin:(double)max min:(double)min{
    double setMinD = min;
    if (max != 0 && min != 100.0) {
        double difference = max - min;
        
        double scalefactor = 0.12;
        
        if (difference <= 1.0) {
            scalefactor = 2.0;
        } else if (difference <= 2.0) {
            scalefactor = 0.75;
        } else if (difference <= 4.0) {
            scalefactor = 0.33;
        }
        setMinD = min - difference * scalefactor;
    }
    return setMinD;
}

+(UIView *)viewRoundedRect:(UIView *)view direction:(int)direction{
    UIView *roundView = view;
    UIBezierPath *maskPath;
    switch (direction) {
        case 1://上
            maskPath = [UIBezierPath bezierPathWithRoundedRect:roundView.bounds
                                             byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                   cornerRadii:CGSizeMake(10.0, 10.0)];
            break;
        case 2://下
            maskPath = [UIBezierPath bezierPathWithRoundedRect:roundView.bounds
                                             byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                   cornerRadii:CGSizeMake(10.0, 10.0)];
            break;
        case 3://上下
            maskPath = [UIBezierPath bezierPathWithRoundedRect:roundView.bounds
                                             byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft | UIRectCornerTopRight)
                                                   cornerRadii:CGSizeMake(10.0, 10.0)];
            break;
        case 4://解除
            maskPath = [UIBezierPath bezierPathWithRoundedRect:roundView.bounds
                                             byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft | UIRectCornerTopRight)
                                                   cornerRadii:CGSizeMake(0.0, 0.0)];
            break;
        default:
            break;
    }
    maskPath = [UIBezierPath bezierPathWithRoundedRect:roundView.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft | UIRectCornerTopRight)
                                           cornerRadii:CGSizeMake(0.0, 0.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = roundView.bounds;
    maskLayer.path = maskPath.CGPath;
    roundView.layer.mask = maskLayer;
    return roundView;
}

+(NSString *)getUserID{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDataDic = [ud objectForKey:@"UserData_Key"];
    NSString *userId = [userDataDic objectForKey:@"UserId"];
    return userId;
}
+(NSString *)getGroupID{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDataDic = [ud objectForKey:@"UserData_Key"];
    NSString *groupId = [userDataDic objectForKey:@"GroupId"];
    return groupId;
}

+(BOOL)checkErrorMessage:(NSDictionary *)dic{
    BOOL is_exists = [dic.allKeys containsObject:@"ERRORMESSAGE"];
    return is_exists;
}

@end
