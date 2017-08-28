//
//  PHPConnection.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/22.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import "PHPConnection.h"

@interface PHPConnection ()<NSURLSessionDelegate>

@end

@implementation PHPConnection

NSString *mainURL = @"http://api.suisaniot.net/suisaniot/v2/app/";//サービス用本番サーバー
NSString *mainURL2 = @"http://api.suisaniot.net/suisaniot/v2/app/";//本番サーバー
//NSString *mainURL = @"http://api.suisaniot.net/suisaniot/v1/app/";//本番サーバー
//NSString *mainURL2 = @"http://api.suisaniot.net/suisaniot/v1/app2/";//本番サーバー
NSString *apiURL = @"http://api.suisaniot.net/suisaniot/v2/suisan-api/public/";
//NSString *mainURL = @"http://api.suisaniot.net/suisaniot/v1/apptest/";//テストサーバー
//NSString *apiURL = @"http://api.suisaniot.net/suisaniot/v1/suisanapi-test/spec/";
NSString *getAreaListPHP = @"getAreaList.php";
NSString *getDatasetListPHP = @"getDatasetList.php";
NSString *getDatasetList2PHP = @"getDatasetList2.php";
NSString *getPanelDetailPHP = @"getPanelDetail.php";
NSString *getTableDataPHP = @"getTableData.php";
NSString *getTableHeikinDataPHP = @"getTableHeikinData.php";
NSString *getSekisanPreviewDataPHP = @"getSekisanPreviewData.php";

NSString *getUnitDataPHP = @"getUnitData.php";

//新規サービス用

NSString *getPanelSekisanData40PHP = @"getPanelSekisanData40.php";
NSString *getTableData14_2PHP = @"getTableData14_2.php";
NSString *getTableHeikinData14_2PHP = @"getTableHeikinData14_2.php";
//チャットテスト用
NSString *addChatData = @"addChatData.php";
NSString *getChatData = @"getChatData.php";
//日誌機能
NSString *addDiaryDataPHP = @"addDiaryData.php";
NSString *updDiaryDataPHP = @"updDiaryData.php";
NSString *delDiaryDataPHP = @"delDiaryData.php";
NSString *getDiaryDataPHP = @"getDiaryData.php";
NSString *getAllDiaryDataPHP = @"getAllDiaryData.php";
NSString *getEventIdPHP = @"getEventId.php";
NSString *getDiaryEventIdPHP = @"getDiaryEventId.php";
//掲示板機能
NSString *getThreadListPHP = @"getThreadList.php";
NSString *addThreadPHP = @"addThread.php";
NSString *getThreadTopicListPHP = @"getThreadTopicList.php";
NSString *getTopicResListPHP = @"getTopicResList.php";
NSString *chkThreadCountPHP = @"chkThreadCount.php";

NSString *getThreadMailPHP = @"getThreadMail.php";
NSString *updThreadMailPHP = @"updThreadMail.php";

NSString *getThreadSettingPHP = @"getThreadSetting.php";
NSString *updThreadMemberPHP = @"updThreadMember.php";
NSString *delThreadPHP = @"delThread.php";

//チャット
NSString *delTopicResPHP = @"delTopicRes.php";//話題削除
NSString *getThreadMemberPHP = @"getThreadMember.php";//掲示板参加ユーザー取得
NSString *addTopicResPHP = @"addTopicRes.php";//返信、投稿


//ログイン認証関係
NSString *loginCheckPHP = @"loginCheck.php";
NSString *loginPHP = @"login.php";
NSString *inheritancePHP = @"inheritance.php";
//設定画面関係
NSString *getSettingTopDataPHP = @"getSettingTopData.php";
NSString *addMailAddressPHP = @"addMailAddress.php";
NSString *updAlarmSettingPHP = @"updAlarmSetting.php";
NSString *updSekisanSettingPHP = @"updSekisanSetting.php";
NSString *updNicknamePHP = @"updNickname.php";

NSString *updAlarmSwitchPHP = @"updAlarmSwitch.php";
NSString *chkMailExistPHP = @"chkMailExist.php";
NSString *delAlarmSettingPHP = @"delAlarmSetting.php";
NSString *delSekisanSettingPHP = @"delSekisanSetting.php";

//トップ画面
NSString *getNewNotificationPHP = @"getNewNotification.php";


NSMutableDictionary *jsonResponse;
NSUserDefaults *userDefaults;

+(NSMutableArray *)getAreaList{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getAreaListPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
}

+(NSMutableArray *)getDatasetList:(int)areaCD{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getDatasetListPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    NSData *bodyData;
    if (areaCD == 0) {
        bodyData = [[NSString stringWithFormat:@"userid=%@&groupid=%@",[Common getUserID],[Common getGroupID]] dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodyData];
    }else{
        bodyData = [[NSString stringWithFormat:@"areacd=%d&userid=%@&groupid=%@",areaCD,[Common getUserID],[Common getGroupID]] dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodyData];
    }
    
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
}
+(NSMutableArray *)getDatasetList2:(int)areaCD{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getDatasetList2PHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    NSData *bodyData;
    if (areaCD == 0) {
        bodyData = [[NSString stringWithFormat:@"userid=%@&groupid=%@&date=%@",[Common getUserID],[Common getGroupID],[Common getTimeStringS]] dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodyData];
    }else{
        bodyData = [[NSString stringWithFormat:@"areacd=%d&userid=%@&groupid=%@&date=%@",areaCD,[Common getUserID],[Common getGroupID],[Common getTimeStringS]] dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodyData];
    }
    
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
}

+(NSMutableArray *)getPanelDetail:(NSString *)dataSetCD{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getPanelDetailPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    NSData *bodyData = [[NSString stringWithFormat:@"datasetcd=%@&userid=%@&groupid=%@",dataSetCD,[Common getUserID],[Common getGroupID]] dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
}

+(NSMutableArray *)getSettingTopData{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getSettingTopDataPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    NSData *bodyData = [[NSString stringWithFormat:@"userid=%@&groupid=%@",[Common getUserID],[Common getGroupID]] dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
}

+(NSMutableArray *)getSekisanPreviewData:(NSString *)detasetcd
                              targetdate:(NSString *)targetdate
                                datefrom:(NSString *)datefrom
                                  dateto:(NSString *)dateto
                                    base:(NSString *)base
                                     std:(NSString *)std{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getSekisanPreviewDataPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"detasetcd=%@&targetdate=%@&datefrom=%@&dateto=%@&base=%@&std=%@",detasetcd,targetdate,datefrom,dateto,base,std];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    [ary addObject:jsonResponse];
    return ary;
}

+(NSMutableArray *)getUnitData:(NSString *)dataSetCD1
                    dataSetCD2:(NSString *)dataSetCD2
                    dataSetCD3:(NSString *)dataSetCD3
                    dataSetCD4:(NSString *)dataSetCD4{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getUnitDataPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"detasetcd1=%@&detasetcd2=%@&detasetcd3=%@&detasetcd4=%@&userid=%@&groupid=%@",dataSetCD1,dataSetCD2,dataSetCD3,dataSetCD4,[Common getUserID],[Common getGroupID]];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
}
+(NSMutableArray *)getPanelSekisanData40:(NSString *)DataSetCD1
                              DataSetCD2:(NSString *)DataSetCD2
                              DataSetCD3:(NSString *)DataSetCD3
                              DataSetCD4:(NSString *)DataSetCD4
                              DataSetCD5:(NSString *)DataSetCD5
                              DataSetCD6:(NSString *)DataSetCD6
                              DataSetCD7:(NSString *)DataSetCD7
                              DataSetCD8:(NSString *)DataSetCD8
                              DataSetCD9:(NSString *)DataSetCD9
                             DataSetCD10:(NSString *)DataSetCD10
                             DataSetCD11:(NSString *)DataSetCD11
                             DataSetCD12:(NSString *)DataSetCD12
                             DataSetCD13:(NSString *)DataSetCD13
                             DataSetCD14:(NSString *)DataSetCD14
                             DataSetCD15:(NSString *)DataSetCD15
                             DataSetCD16:(NSString *)DataSetCD16
                             DataSetCD17:(NSString *)DataSetCD17
                             DataSetCD18:(NSString *)DataSetCD18
                             DataSetCD19:(NSString *)DataSetCD19
                             DataSetCD20:(NSString *)DataSetCD20
                             DataSetCD21:(NSString *)DataSetCD21
                             DataSetCD22:(NSString *)DataSetCD22
                             DataSetCD23:(NSString *)DataSetCD23
                             DataSetCD24:(NSString *)DataSetCD24
                             DataSetCD25:(NSString *)DataSetCD25
                             DataSetCD26:(NSString *)DataSetCD26
                             DataSetCD27:(NSString *)DataSetCD27
                             DataSetCD28:(NSString *)DataSetCD28
                             DataSetCD29:(NSString *)DataSetCD29
                             DataSetCD30:(NSString *)DataSetCD30
                             DataSetCD31:(NSString *)DataSetCD31
                             DataSetCD32:(NSString *)DataSetCD32
                             DataSetCD33:(NSString *)DataSetCD33
                             DataSetCD34:(NSString *)DataSetCD34
                             DataSetCD35:(NSString *)DataSetCD35
                             DataSetCD36:(NSString *)DataSetCD36
                             DataSetCD37:(NSString *)DataSetCD37
                             DataSetCD38:(NSString *)DataSetCD38
                             DataSetCD39:(NSString *)DataSetCD39
                             DataSetCD40:(NSString *)DataSetCD40
                              targetDate:(NSString *)targetDate{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL2,getPanelSekisanData40PHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"detasetcd1=%@&detasetcd2=%@&detasetcd3=%@&detasetcd4=%@&detasetcd5=%@&detasetcd6=%@&detasetcd7=%@&detasetcd8=%@&detasetcd9=%@&detasetcd10=%@&detasetcd11=%@&detasetcd12=%@&detasetcd13=%@&detasetcd14=%@&detasetcd15=%@&detasetcd16=%@&detasetcd17=%@&detasetcd18=%@&detasetcd19=%@&detasetcd20=%@&detasetcd21=%@&detasetcd22=%@&detasetcd23=%@&detasetcd24=%@&detasetcd25=%@&detasetcd26=%@&detasetcd27=%@&detasetcd28=%@&detasetcd29=%@&detasetcd30=%@&detasetcd31=%@&detasetcd32=%@&detasetcd33=%@&detasetcd34=%@&detasetcd35=%@&detasetcd36=%@&detasetcd37=%@&detasetcd38=%@&detasetcd39=%@&detasetcd40=%@&targetdate=%@&userid=%@&groupid=%@",DataSetCD1,DataSetCD2,DataSetCD3,DataSetCD4,DataSetCD5,DataSetCD6,DataSetCD7,DataSetCD8,DataSetCD9,DataSetCD10,DataSetCD11,DataSetCD12,DataSetCD13,DataSetCD14,DataSetCD15,DataSetCD16,DataSetCD17,DataSetCD18,DataSetCD19,DataSetCD20,DataSetCD21,DataSetCD22,DataSetCD23,DataSetCD24,DataSetCD25,DataSetCD26,DataSetCD27,DataSetCD28,DataSetCD29,DataSetCD30,DataSetCD31,DataSetCD32,DataSetCD33,DataSetCD34,DataSetCD35,DataSetCD36,DataSetCD37,DataSetCD38,DataSetCD39,DataSetCD40,targetDate,[Common getUserID],[Common getGroupID]];
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
}

+(NSMutableArray *)getTableData14_2:(NSString *)dataSetCD1
                         dataSetCD2:(NSString *)dataSetCD2
                         dataSetCD3:(NSString *)dataSetCD3
                         dataSetCD4:(NSString *)dataSetCD4
                         targetDate:(NSString *)targetDate
                      targetDateflg:(NSString *)targetDateflg{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL2,getTableData14_2PHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"detasetcd1=%@&detasetcd2=%@&detasetcd3=%@&detasetcd4=%@&targetdate=%@&targetdateflg=%@&userid=%@&groupid=%@",dataSetCD1,dataSetCD2,dataSetCD3,dataSetCD4,targetDate,targetDateflg,[Common getUserID],[Common getGroupID]];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
}

+(NSMutableArray *)getTableHeikinData14_2:(NSString *)dataSetCD1
                               dataSetCD2:(NSString *)dataSetCD2
                               dataSetCD3:(NSString *)dataSetCD3
                               dataSetCD4:(NSString *)dataSetCD4
                               targetDate:(NSString *)targetDate
                            targetDateflg:(NSString *)targetDateflg
                                   heikin:(NSString *)heikin{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL2,getTableHeikinData14_2PHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"detasetcd1=%@&detasetcd2=%@&detasetcd3=%@&detasetcd4=%@&targetdate=%@&targetdateflg=%@&heikin=%@&userid=%@&groupid=%@",dataSetCD1,dataSetCD2,dataSetCD3,dataSetCD4,targetDate,targetDateflg,heikin,[Common getUserID],[Common getGroupID]];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSLog(@"jsonResponse: %@", jsonResponse);
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
    
}


+(NSMutableArray *)getChatData:(NSString *)roomid
                        userid:(NSString *)userid
                       groupid:(NSString *)groupid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL2,getChatData]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"roomid=%@&userid=%@&groupid=%@",roomid,userid,groupid];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
}

+(NSMutableArray *)addChatData:(NSString *)roomid
                        userid:(NSString *)userid
                       groupid:(NSString *)groupid
                      chatmemo:(NSString *)chatmemo
                           lat:(NSString *)lat
                           lon:(NSString *)lon
                      imageflg:(NSString *)imageflg
                     updateflg:(NSString *)updateflg;
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL2,addChatData]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"roomid=%@&userid=%@&groupid=%@",roomid,userid,groupid];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
}


+(NSDictionary *)addDiaryData:(NSString *)datasetcd
                           memo:(NSString *)memo
                           date:(NSString *)date
                      writekind:(NSString *)writekind{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,addDiaryDataPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&datasetcd=%@&memo=%@&date=%@&writekind=%@",[Common getUserID],[Common getGroupID],datasetcd,memo,date,writekind];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}

+(NSDictionary *)updDiaryData:(NSString *)eventid
                      datasetcd:(NSString *)datasetcd
                           memo:(NSString *)memo
                           date:(NSString *)date
                      writekind:(NSString *)writekind{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,updDiaryDataPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&eventid=%@&datasetcd=%@&memo=%@&date=%@&writekind=%@",[Common getUserID],[Common getGroupID],eventid,datasetcd,memo,date,writekind];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}

+(NSDictionary *)delDiaryData:(NSString *)eventid
                      datasetcd:(NSString *)datasetcd
                           memo:(NSString *)memo
                           date:(NSString *)date
                      writekind:(NSString *)writekind{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,delDiaryDataPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&eventid=%@&datasetcd=%@&memo=%@&date=%@&writekind=%@",[Common getUserID],[Common getGroupID],eventid,datasetcd,memo,date,writekind];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}

+(NSMutableArray *)getDiaryData:(NSString *)dataSetCD1
                     dataSetCD2:(NSString *)dataSetCD2
                     dataSetCD3:(NSString *)dataSetCD3
                     dataSetCD4:(NSString *)dataSetCD4
                     targetDate:(NSString *)targetDate
                  targetDateCD4:(NSString *)targetDateCD4
                  targetDateflg:(NSString *)targetDateflg
                           page:(NSString *)page
                     page1count:(NSString *)page1count{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getDiaryDataPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"detasetcd1=%@&detasetcd2=%@&detasetcd3=%@&detasetcd4=%@&targetdate=%@&targetdatecd4=%@&targetdateflg=%@&page=%@&page1count=%@&userid=%@&groupid=%@",dataSetCD1,dataSetCD2,dataSetCD3,dataSetCD4,targetDate,targetDateCD4,targetDateflg,page,page1count,[Common getUserID],[Common getGroupID]];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
    
}

+(NSMutableArray *)getAllDiaryData:(NSString *)page
                        page1count:(NSString *)page1count{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getAllDiaryDataPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"page=%@&page1count=%@&userid=%@&groupid=%@",page,page1count,[Common getUserID],[Common getGroupID]];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
}

+(NSMutableArray *)getEventId:(NSString *)dataSetCD1
                   dataSetCD2:(NSString *)dataSetCD2
                   dataSetCD3:(NSString *)dataSetCD3
                   dataSetCD4:(NSString *)dataSetCD4
                   targetDate:(NSString *)targetDate
                targetDateflg:(NSString *)targetDateflg
                         page:(NSString *)page
                   page1count:(NSString *)page1count{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getEventIdPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    NSString *bodyDataString = [NSString stringWithFormat:@"detasetcd1=%@&detasetcd2=%@&detasetcd3=%@&detasetcd4=%@&targetdate=%@&targetdateflg=%@&page=%@&page1count=%@&userid=%@&groupid=%@",dataSetCD1,dataSetCD2,dataSetCD3,dataSetCD4,targetDate,targetDateflg,page,page1count,[Common getUserID],[Common getGroupID]];
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
}

+(NSMutableArray *)getDiaryEventId:(NSString *)eventid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getDiaryEventIdPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"eventid=%@&userid=%@&groupid=%@",eventid,[Common getUserID],[Common getGroupID]];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
}

//掲示板機能
+(NSMutableArray *)getThreadList:(NSString *)threadids{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getThreadListPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&date=%@&threadids=%@",[Common getUserID],[Common getGroupID],[Common getTimeStringS],threadids];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
}

+(NSDictionary *)addThread:(NSString *)threadname{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,addThreadPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&threadname=%@",[Common getUserID],[Common getGroupID],threadname];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}

+(NSMutableArray *)getThreadTopicList:(NSString *)threadid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getThreadTopicListPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&threadid=%@",[Common getUserID],[Common getGroupID],threadid];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
}

+(NSMutableArray *)getTopicResList:(NSString *)threadid topicid:(NSString *)topicid init:(NSString *)init{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getTopicResListPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&threadid=%@&topicid=%@&init=%@",[Common getUserID],[Common getGroupID],threadid,topicid,init];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
}

+(NSDictionary *)chkThreadCount{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,chkThreadCountPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@",[Common getUserID],[Common getGroupID]];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}

+(NSDictionary *)getThreadMail:(NSString *)threadid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getThreadMailPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&threadid=%@",[Common getUserID],[Common getGroupID],threadid];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return [ary objectAtIndex:0];
}

+(NSDictionary *)updThreadMail:(NSString *)threadid status:(NSString *)status{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,updThreadMailPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&threadid=%@&status=%@",[Common getUserID],[Common getGroupID],threadid,status];
    NSLog(@"bodyDataString111 = %@",bodyDataString);
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
//    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
//    for( NSDictionary * json in jsonResponse) {
//        [ary addObject:json];
//    }
    return jsonResponse;
}


+(NSMutableArray *)getThreadSetting:(NSString *)threadid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getThreadSettingPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&threadid=%@",[Common getUserID],[Common getGroupID],threadid];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
    for( NSDictionary * json in jsonResponse) {
        [ary addObject:json];
    }
    return ary;
}

+(NSDictionary *)updThreadMember:(NSString *)userid threadid:(NSString *)threadid status:(NSString *)status{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,updThreadMemberPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&threadid=%@&status=%@",userid,[Common getGroupID],threadid,status];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
//    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
//    for( NSDictionary * json in jsonResponse) {
//        [ary addObject:json];
//    }
    return jsonResponse;
}
+(NSDictionary *)delThread:(NSString *)threadid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,delThreadPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&threadid=%@",[Common getUserID],[Common getGroupID],threadid];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}

+(NSDictionary *)delTopicRes:(NSString *)threadid type:(NSString *)type cid:(NSString *)cid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,delTopicResPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&threadid=%@&type=%@&id=%@",[Common getUserID],[Common getGroupID],threadid,type,cid];
    NSLog(@"bodyDataString = %@",bodyDataString);
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}

+(NSMutableArray *)getThreadMember:(NSString *)threadid manageid:(NSString *)manageid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getThreadMemberPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&threadid=%@&manageid=%@",[Common getUserID],[Common getGroupID],threadid,manageid];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
        NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:0];
        for( NSDictionary * json in jsonResponse) {
            [ary addObject:json];
        }
    return ary;
}

+(NSDictionary *)addTopicRes:(NSString *)threadid type:(NSString *)type topicid:(NSString *)topicid memo:(NSString *)memo imageurl:(NSString *)imageurl{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,addTopicResPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&threadid=%@&type=%@&topicid=%@&memo=%@&imageurl=%@",[Common getUserID],[Common getGroupID],threadid,type,topicid,memo,imageurl];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}


//ログイン認証
+(NSDictionary *)loginCheck{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,loginCheckPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@",[Common getUserID],[Common getGroupID]];
    //NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@",[Common getUserID],@""];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}

+(NSDictionary *)login:(NSString *)groupId username:(NSString *)username{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,loginPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"groupid=%@&username=%@",groupId,username];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}

+(NSDictionary *)inheritance:(NSString *)groupId userId:(NSString *)userId{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,inheritancePHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@",userId,groupId];
    
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}

//設定画面関係
+(NSDictionary *)addMailAddress:(NSString *)mailAdd from:(NSString *)from to:(NSString *)to{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,addMailAddressPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&mailaddress=%@&from=%@&to=%@",[Common getUserID],[Common getGroupID],mailAdd,from,to];
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}

+(NSDictionary *)updAlarmSetting:(NSString *)no datasetcd:(NSString *)datasetcd from:(NSString *)from to:(NSString *)to{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,updAlarmSettingPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&no=%@&datasetcd=%@&from=%@&to=%@",[Common getUserID],[Common getGroupID],no,datasetcd,from,to];
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}

+(NSDictionary *)updSekisanSetting:(NSString *)no datasetcd:(NSString *)datasetcd from:(NSString *)from to:(NSString *)to base:(NSString *)base std:(NSString *)std{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,updSekisanSettingPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&no=%@&datasetcd=%@&from=%@&to=%@&base=%@&std=%@",[Common getUserID],[Common getGroupID],no,datasetcd,from,to,base,std];
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        NSLog(@"失敗: %@", errorString);
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}

+(NSDictionary *)updNickname:(NSString *)name{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,updNicknamePHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&name=%@",[Common getUserID],[Common getGroupID],name];
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}

+(NSDictionary *)updAlarmSwitch:(NSString *)no status:(NSString *)status{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,updAlarmSwitchPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&no=%@&status=%@",[Common getUserID],[Common getGroupID],no,status];
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    NSLog(@"bodyDataString = %@",bodyDataString);
    NSLog(@"jsonResponse = %@",jsonResponse);
    return jsonResponse;
}

+(NSDictionary *)chkMailExist{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,chkMailExistPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@",[Common getUserID],[Common getGroupID]];
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}

+(NSDictionary *)delAlarmSetting:(NSString *)no{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,delAlarmSettingPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&no=%@",[Common getUserID],[Common getGroupID],no];
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}

+(NSDictionary *)delSekisanSetting:(NSString *)no{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,delSekisanSettingPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&no=%@",[Common getUserID],[Common getGroupID],no];
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}

+(NSDictionary *)getNewNotification:(NSString *)threadids{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainURL,getNewNotificationPHP]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyDataString = [NSString stringWithFormat:@"userid=%@&groupid=%@&threadids=%@",[Common getUserID],[Common getGroupID],threadids];
    NSData *bodyData = [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    NSError * error = nil;
    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSString *errorString = [error localizedDescription];
    if(0 < [errorString length]) {
        return nil;
    }
    // 通信成功
    else {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
    return jsonResponse;
}


@end
