//
//  PHPConnection.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/22.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHPConnection: NSObject

/*
 * エリア一覧を返す
 *
 * IN::
 *
 * OUT::
 * AREACD	エリアコード
 * AREANM	浜市岸　等
 * LAT		緯度(最新値)
 * LON		経度(最新値)
 *
 * */
+(NSMutableArray *)getAreaList;

/*
 * 表示可能なデータセット一覧を返す
 * (公開、非公開は判断しない)
 * IN::
 * AREACD		エリアコード　指定のない場合は全エリアを対象とする
 *
 * OUT::
 * DATASETCD	データセットコード
 * AREANM		浜市岸　等
 * DATATYPE		水温　等
 * POINT		1.5m　等
 * UNIT			℃　等
 *
 * */
+(NSMutableArray *)getDatasetList:(int)areaCD;
+(NSMutableArray *)getDatasetList2:(int)areaCD;
/*
 * 指定データセットの詳細画面情報を返す
 * (公開、非公開は判断しない)
 * IN::
 * DATASETCD	パネルのデータセットコード
 *
 * OUT::
 * DATASETCD	データセットコード
 * AREANM		浜市岸　等
 * DATATYPE		水温　等
 * POINT		1.5m　等
 * LAT			緯度
 * LON			経度
 * LATLONDATE	座標取得日時
 * VOLT			残電圧
 * VOLTDATE		残電圧取得時間
 * IMGURL		関連画像URL
 * MEMO			説明
 *
 * */
+(NSMutableArray *)getPanelDetail:(NSString *)dataSetCD;


/*
 * 設定画面の表示情報を返す
 *
 * IN::
 * userid	ユーザID （仮ユーザ登録、引越し済みのユーザは取得対象外となります）
 *
 * OUT::
 * MAILADDR				メールアドレス
 * ARMTIMEFROM			メール受信拒否時間FROM
 * ARMTIMETO			メール受信拒否時間TO
 * ARM1DATASETCD		アラーム1データセットCD
 * ARM1AREANM			浜市岸　等
 * ARM1DATATYPE			水温　等
 * ARM1POINT			1.5m　等
 * ARM1UNIT				℃　等
 * ARM1VALFROM			アラーム1数値FROM
 * ARM1VALTO			アラーム1数値TO
 * ARM1TIMES			アラーム1連続数
 * ARM1SWITCH			アラーム1有効無効
 * ARM2DATASETCD		アラーム2データセットCD
 * ARM2AREANM			浜市岸　等
 * ARM2DATATYPE			水温　等
 * ARM2POINT			2.5m　等
 * ARM2UNIT				℃　等
 * ARM2VALFROM			アラーム2数値FROM
 * ARM2VALTO			アラーム2数値TO
 * ARM2TIMES			アラーム2連続数
 * ARM2SWITCH			アラーム2有効無効
 * ARM3DATASETCD		アラーム3データセットCD
 * ARM3AREANM			浜市岸　等
 * ARM3DATATYPE			水温　等
 * ARM3POINT			3.5m　等
 * ARM3UNIT				℃　等
 * ARM3VALFROM			アラーム3数値FROM
 * ARM3VALTO			アラーム3数値TO
 * ARM3TIMES			アラーム3連続数
 * ARM3SWITCH			アラーム3有効無効
 * INTEGVAL1DATASETCD	積算値1データセットCD
 * INTEGVAL1AREANM		浜市岸　等
 * INTEGVAL1DATATYPE	水温　等
 * INTEGVAL1POINT		2.5m　等
 * INTEGVAL1UNIT		℃　等
 * INTEGVAL1DATEFROM	積算値1日時FROM
 * INTEGVAL1DATETO		積算値1日時TO
 * INTEGVAL1BASE		積算値1ベース値
 * INTEGVAL1STD			積算値1目安値
 * INTEGVAL2DATASETCD	積算値2データセットCD
 * INTEGVAL2AREANM		浜市岸　等
 * INTEGVAL2DATATYPE	水温　等
 * INTEGVAL2POINT		2.5m　等
 * INTEGVAL2UNIT		℃　等
 * INTEGVAL2DATEFROM	積算値2日時FROM
 * INTEGVAL2DATETO		積算値2日時TO
 * INTEGVAL2BASE		積算値2ベース値
 * INTEGVAL2STD			積算値2目安値
 * INTEGVAL3DATASETCD	積算値3データセットCD
 * INTEGVAL3AREANM		浜市岸　等
 * INTEGVAL3DATATYPE	水温　等
 * INTEGVAL3POINT		2.5m　等
 * INTEGVAL3UNIT		℃　等
 * INTEGVAL3DATEFROM	積算値3日時FROM
 * INTEGVAL3DATETO		積算値3日時TO
 * INTEGVAL3BASE		積算値3ベース値
 * INTEGVAL3STD			積算値3目安値
 *
 * */
+(NSMutableArray *)getSettingTopData;


//メールアドレス、ユーザーID登録
+(void)mailadd:(NSString *)userId mailAddr:(NSString *)mailAddr armtimeFrom:(NSString *)armtimeFrom armtimeTo:(NSString *)armtimeTo;

//メールアドレス更新
+(void)mailSet:(NSString *)userId mailAddr:(NSString *)mailAddr armtimeFrom:(NSString *)armtimeFrom armtimeTo:(NSString *)armtimeTo;

//登録データ削除
+(void)mailDelete:(NSString *)userId;


//アラームスイッチ反映
+(void)alarmSwicth:(NSString *)userId arm1:(NSString *)arm1 arm2:(NSString *)arm2 arm3:(NSString *)arm3;

//アラーム登録
+(void)alarmSet:(NSString *)userId
        alarmNo:(NSString *)alarmNo
        alarmCD:(NSString *)alarmCD
      alarmFrom:(NSString *)alarmFrom
        alarmTo:(NSString *)alarmTo
     alarmCount:(NSString *)alarmCount;

//アラーム削除
+(void)alarmDelete:(NSString *)userId alarmNo:(NSString *)alarmNo;


//積算値登録
+(void)sekisanSet:(NSString *)userId
        sekisanNo:(NSString *)sekisanNo
        sekisanCD:(NSString *)sekisanCD
      sekisanFrom:(NSString *)sekisanFrom
        sekisanTo:(NSString *)sekisanTo
      sekisanBase:(NSString *)sekisanBase
       sekisanStd:(NSString *)sekisanStd;



/*
 * 積算値設定画面のプレビュー表示情報を返す
 *
 * IN::
 * detasetcd	データセットCD
 * targetdate	取得したい年月日時 2016011218 等
 * datefrom		積算期間FROM
 * dateto		積算期間TO
 * base			積算基準値
 * std			積算目安値
 * */
//積算値プレビュー
+(NSMutableArray *)getSekisanPreviewData:(NSString *)detasetcd
                              targetdate:(NSString *)targetdate
                                datefrom:(NSString *)datefrom
                                  dateto:(NSString *)dateto
                                    base:(NSString *)base
                                     std:(NSString *)std;



//積算値削除
+(void)sekisanDelete:(NSString *)userId sekisanNo:(NSString *)sekisanNo;


+(NSMutableArray *)getUnitData:(NSString *)dataSetCD1
                       dataSetCD2:(NSString *)dataSetCD2
                       dataSetCD3:(NSString *)dataSetCD3
                       dataSetCD4:(NSString *)dataSetCD4;


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
                              targetDate:(NSString *)targetDate;

+(NSMutableArray *)getTableData14_2:(NSString *)dataSetCD1
                       dataSetCD2:(NSString *)dataSetCD2
                       dataSetCD3:(NSString *)dataSetCD3
                       dataSetCD4:(NSString *)dataSetCD4
                       targetDate:(NSString *)targetDate
                    targetDateflg:(NSString *)targetDateflg;

+(NSMutableArray *)getTableHeikinData14_2:(NSString *)dataSetCD1
                             dataSetCD2:(NSString *)dataSetCD2
                             dataSetCD3:(NSString *)dataSetCD3
                             dataSetCD4:(NSString *)dataSetCD4
                             targetDate:(NSString *)targetDate
                          targetDateflg:(NSString *)targetDateflg
                                 heikin:(NSString *)heikin;

//チャットテスト用
+(NSMutableArray *)getChatData:(NSString *)roomid
                        userid:(NSString *)userid
                       groupid:(NSString *)groupid;


//lat lon　dete imageflg updateflg
+(NSMutableArray *)addChatData:(NSString *)roomid
                        userid:(NSString *)userid
                       groupid:(NSString *)groupid
                      chatmemo:(NSString *)chatmemo
                           lat:(NSString *)lat
                           lon:(NSString *)lon
                      imageflg:(NSString *)imageflg
                     updateflg:(NSString *)updateflg;

//日誌
+(NSDictionary *)addDiaryData:(NSString *)datasetcd
                           memo:(NSString *)memo
                           date:(NSString *)date
                      writekind:(NSString *)writekind;

+(NSDictionary *)updDiaryData:(NSString *)eventid
                       datasetcd:(NSString *)datasetcd
                           memo:(NSString *)memo
                           date:(NSString *)date
                      writekind:(NSString *)writekind;

+(NSDictionary *)delDiaryData:(NSString *)eventid
                       datasetcd:(NSString *)datasetcd
                           memo:(NSString *)memo
                           date:(NSString *)date
                      writekind:(NSString *)writekind;

+(NSMutableArray *)getDiaryData:(NSString *)dataSetCD1
                     dataSetCD2:(NSString *)dataSetCD2
                     dataSetCD3:(NSString *)dataSetCD3
                     dataSetCD4:(NSString *)dataSetCD4
                     targetDate:(NSString *)targetDate
                  targetDateCD4:(NSString *)targetDateCD4
                  targetDateflg:(NSString *)targetDateflg
                           page:(NSString *)page
                     page1count:(NSString *)page1count;

+(NSMutableArray *)getAllDiaryData:(NSString *)page page1count:(NSString *)page1count;

+(NSMutableArray *)getEventId:(NSString *)dataSetCD1
                     dataSetCD2:(NSString *)dataSetCD2
                     dataSetCD3:(NSString *)dataSetCD3
                     dataSetCD4:(NSString *)dataSetCD4
                     targetDate:(NSString *)targetDate 
                  targetDateflg:(NSString *)targetDateflg
                           page:(NSString *)page
                     page1count:(NSString *)page1count;

+(NSMutableArray *)getDiaryEventId:(NSString *)eventid;

//掲示板機能
+(NSMutableArray *)getThreadList:(NSString *)threadids;

+(NSDictionary *)addThread:(NSString *)threadname;

+(NSDictionary *)chkThreadCount;

+(NSMutableArray *)getThreadTopicList:(NSString *)threadid;

+(NSMutableArray *)getTopicResList:(NSString *)threadid topicid:(NSString *)topicid init:(NSString *)init;

+(NSDictionary *)getThreadMail:(NSString *)threadid;

+(NSDictionary *)updThreadMail:(NSString *)threadid status:(NSString *)status;


+(NSMutableArray *)getThreadSetting:(NSString *)threadid;

+(NSDictionary *)updThreadMember:(NSString *)userid threadid:(NSString *)threadid status:(NSString *)status;

+(NSDictionary *)delThread:(NSString *)threadid;

+(NSDictionary *)delTopicRes:(NSString *)threadid type:(NSString *)type cid:(NSString *)cid;

+(NSMutableArray *)getThreadMember:(NSString *)threadid manageid:(NSString *)manageid;

+(NSDictionary *)addTopicRes:(NSString *)threadid type:(NSString *)type topicid:(NSString *)topicid memo:(NSString *)memo imageurl:(NSString *)imageurl;


//ログイン認証
+(NSDictionary *)loginCheck;

+(NSDictionary *)login:(NSString *)groupId username:(NSString *)username;

+(NSDictionary *)inheritance:(NSString *)groupId userId:(NSString *)userId;

//設定画面関係
+(NSDictionary *)addMailAddress:(NSString *)mailAdd from:(NSString *)from to:(NSString *)to;

+(NSDictionary *)updateMailTime:(NSString *)from to:(NSString *)to;

+(NSDictionary *)updAlarmSetting:(NSString *)no datasetcd:(NSString *)datasetcd from:(NSString *)from to:(NSString *)to;

+(NSDictionary *)updSekisanSetting:(NSString *)no datasetcd:(NSString *)datasetcd from:(NSString *)from to:(NSString *)to base:(NSString *)base std:(NSString *)std;

+(NSDictionary *)updNickname:(NSString *)name;

+(NSDictionary *)updAlarmSwitch:(NSString *)no status:(NSString *)status;

+(NSDictionary *)chkMailExist;

+(NSDictionary *)delAlarmSetting:(NSString *)no;

+(NSDictionary *)delSekisanSetting:(NSString *)no;

//トップ画面
+(NSDictionary *)getNewNotification:(NSString *)threadids;

@end
