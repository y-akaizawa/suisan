//
//  ChatViewController.m
//  testChat
//
//  Created by Andex_MacBook14 on 2017/04/26.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import "ChatViewController.h"
#define imageTapTag 10001
#define imageTag 10002
#define labelH 35

@interface ChatViewController ()<NSURLSessionDelegate,UIGestureRecognizerDelegate>

@end

@implementation ChatViewController
BOOL imageFlag;
float beginGestureScale;//ピンチイン時の初期の拡大値
float effectiveScale;//ピンチイン終了時の倍率
float imageX;//画像の位置保存用X
float imageY;//画像の位置保存用Y
int topicLabelWidth;
int resLabelWidth;

NSString *openTopicId = @"0";//もっと見る状態のtopicidを格納
NSString *chatType = @"";//話題か返信かtopic or res
NSString *topicId = @"";//返信時の返信対象のtopicid格納
UIImage *cameraImage = nil;//撮影、アルバム選択時の画像を一時的に格納
BOOL startCheck;//画面初期表示チェック(画面の読み込みに必要)

- (void)viewDidLoad {
    [super viewDidLoad];
    int scInt = [Common getScreenSizeInt];
    switch (scInt) {
        case 1:
            topicLabelWidth = 280;
            resLabelWidth = 240;
            break;
        case 2:
            topicLabelWidth = 320;
            resLabelWidth = 280;
            break;
        case 3:
            topicLabelWidth = 320;
            resLabelWidth = 280;
            break;
        default:
            topicLabelWidth = 320;
            resLabelWidth = 280;
            break;
    }
    self.accessLabel.textColor = [UIColor colorWithRed:0 green:0 blue:1.0 alpha:1];
    
    effectiveScale = 1.0f;
    self.preImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.dialogBaseView.hidden = YES;
    self.dialogTextView.layer.borderWidth = 1.0f;
    self.dialogTextView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.dialogTextView.delegate = self;
    self.postBtn.layer.cornerRadius = 10;
    self.postBtn.clipsToBounds = true;
    self.okBtn.layer.cornerRadius = 10;
    self.okBtn.clipsToBounds = true;
    self.cancelBtn.layer.cornerRadius = 10;
    self.cancelBtn.clipsToBounds = true;
    
    self.roomTitleLabel.text = self.roomName;
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    self.chatTableView.separatorColor = [UIColor clearColor];
    self.chatTableView.bounces = YES;
    imageFlag = NO;
    if([self.adminName  isEqual: @""]){
        self.adminNameLabel.hidden = YES;
    }else{
        self.adminNameLabel.text = [NSString stringWithFormat:@"管理人：%@",self.adminName];
    }
    
    self.adminNameLabel.adjustsFontSizeToFitWidth = YES;
    self.adminNameLabel.minimumScaleFactor = 5.f/30.f;
    startCheck = NO;
    
    [self refleshControlSetting];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (startCheck == NO) {
        [self getChatAry];
        startCheck = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) timerInfo:(NSTimer *)timer{
    [self updateVisibleCells];
}
-(void)getChatAry{
    [Common showSVProgressHUD:@""];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //チャットデータ全収納用配列を作成、初期化
        [self.allChatAry removeAllObjects];
        self.allChatAry = [[NSMutableArray alloc] initWithCapacity:0];
        [self.chatAry removeAllObjects];
        self.chatAry = [[NSMutableArray alloc] initWithCapacity:0];
        //話題データ取得
        self.chatAry = [PHPConnection getThreadTopicList:self.threadId];
        dispatch_async(dispatch_get_main_queue(), ^{
            int allCount = 0;
            for(NSDictionary *dic1 in self.chatAry){
                [self.allChatAry addObject:dic1];
                //返信データ取得
                NSMutableArray *resChatAry = [[NSMutableArray alloc] initWithCapacity:0];
                if ([[dic1 objectForKey:@"TOPICID"]  isEqual: openTopicId]) {
                    resChatAry = [PHPConnection getTopicResList:self.threadId topicid:[dic1 objectForKey:@"TOPICID"] init:@"0"];
                }else{
                    resChatAry = [PHPConnection getTopicResList:self.threadId topicid:[dic1 objectForKey:@"TOPICID"] init:@"1"];
                }
                for(NSDictionary *dic2 in resChatAry){
                    if ([Common checkErrorMessage:dic2] == YES) {
                        [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"ERRORMESSAGE"]];
                    }else{
                        [self.allChatAry addObject:dic2];
                    }
                }
                allCount++;
            }
            if ([self.timer  isValid] == NO) {
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerInfo:) userInfo:nil repeats:YES];
                [self.timer fire];
            }
            [self.chatTableView reloadData];
            [self updateVisibleCells];
            self.chatTableView.userInteractionEnabled = YES;
            [Common dismissSVProgressHUD];
        });
    });
}
#pragma mark-テーブルビューデリゲート
//セッション
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//セル数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allChatAry.count;
}
//セル高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //リストの配列番号取得
    //allTopicListAryからリストの配列番号の要素をNSDictionaryで取り出す
    NSDictionary *cellDic;
    if (self.allChatAry.count == 0) {
        cellDic = nil;
    }else{
        cellDic = [self.allChatAry objectAtIndex:indexPath.row];
    }
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    NSString *memoStr = @"";
    if([cellDic.allKeys containsObject:@"TOPICID"]){
        if([[cellDic objectForKey:@"DELSTATUS"]  isEqual: @""]){
            memoStr = [cellDic objectForKey:@"TOPIC"];
        }else{
            memoStr = [NSString stringWithFormat:@"%@%@",[cellDic objectForKey:@"DELSTATUS"],[cellDic objectForKey:@"TOPIC"]];
        }
        l = [Common getLabelSize:l text:memoStr labelWidth:topicLabelWidth margin:0];
    }else{
        if([[cellDic objectForKey:@"DELSTATUS"]  isEqual: @""]){
            memoStr = [cellDic objectForKey:@"RES"];
        }else{
            memoStr = [NSString stringWithFormat:@"%@%@",[cellDic objectForKey:@"DELSTATUS"],[cellDic objectForKey:@"RES"]];
        }
        l = [Common getLabelSize:l text:memoStr labelWidth:resLabelWidth margin:0];
    }
    [l sizeToFit];
    float labelHeight = labelH;
    if (l.frame.size.height > labelH) {
        labelHeight = l.frame.size.height;
    }
    if (indexPath.row == self.allChatAry.count-1) {
        labelHeight = labelHeight + 10;
    }
    int	resCount = 0;
    if([cellDic.allKeys containsObject:@"RESCOUNT"]){
        //"RESCOUNT"の数値を取得しておく
        resCount = [[cellDic objectForKey:@"RESCOUNT"] intValue];
    }
    
    //連想配列の要素に特定のキーがあるかどうかをチェック("TOPICID"が存在すれば見出し、しなければ返信)
    if([cellDic.allKeys containsObject:@"TOPICID"]){
        //見出し
        //"IMAGEURL"が空白かどうかをチェック
        if(![[cellDic objectForKey:@"IMAGEURL"]  isEqual: @""]){
            //画像がある
            //①の見出し画像ありのリスト処理
            return 300+labelHeight;
        }else{
            //画像がない
            //②の見出し画像なしのリスト処理
            return 160+labelHeight;
        }
    }else{
        //返信
        //resCountが3以下かどうか
        //3以下ならそのまま処理
        if(resCount < 4){
            //"IMAGEURL"が空白かどうかをチェック
            if(![[cellDic objectForKey:@"IMAGEURL"]  isEqual: @""]){
                //画像がある
                //③の返信 画像ありのリスト処理
                return 250+labelHeight;
            }else{
                //画像がない
                //④の返信 画像なしのリスト処理
                return 110+labelHeight;
            }
        }else{
            //resCountが4以上の場合こちらに分岐
            //リスト番号が3より上かどうか(アプリが落ちる対策)下の場合通常処理
            if(indexPath.row >= 3){
                //allTopicListAryから現在の3個前の要素を取得する
                NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row-3];
                //3個前の要素が見出しかどうか調べる、違う場合は通常処理
                if([dic.allKeys containsObject:@"TOPICID"]){
                    //もっと見るが選択されているかどうかのチェック
                    //openTopicIdと"TOPICID"が同じの場合通常処理、違う場合もっと見る表示に分岐
                    if([dic objectForKey:@"TOPICID"] == openTopicId){
                        //"IMAGEURL"が空白かどうかをチェック
                        if(![[cellDic objectForKey:@"IMAGEURL"]  isEqual: @""]){
                            //画像がある
                            //③の返信 画像ありのリスト処理
                            return 250+labelHeight;
                        }else{
                            //画像がない
                            //④の返信 画像なしのリスト処理
                            return 110+labelHeight;
                        }
                    }else{
                        //"IMAGEURL"が空白かどうかをチェック
                        if(![[cellDic objectForKey:@"IMAGEURL"]  isEqual: @""]){
                            //画像がある
                            //⑤の返信 画像あり もっと見る表示のリスト処理
                            return 300+labelHeight;
                        }else{
                            //画像がない
                            //⑥の返信 画像なし もっと見る表示のリスト処理
                            return 160+labelHeight;
                        }
                    }
                }else{
                    //"IMAGEURL"が空白かどうかをチェック
                    if(![[cellDic objectForKey:@"IMAGEURL"]  isEqual: @""]){
                        //画像がある
                        //③の返信 画像ありのリスト処理
                        return 250+labelHeight;
                    }else{
                        //画像がない
                        //④の返信 画像なしのリスト処理
                        return 110+labelHeight;
                    }
                }
            }else{
                //"IMAGEURL"が空白かどうかをチェック
                if(![[cellDic objectForKey:@"IMAGEURL"]  isEqual: @""]){
                    //画像がある
                    //③の返信 画像ありのリスト処理
                    return 250+labelHeight;
                }else{
                    //画像がない
                    //④の返信 画像なしのリスト処理
                    return 110+labelHeight;
                }
            }
        }
    }
}
//セル内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell1,*cell2,*cell3,*cell4,*cell5,*cell6;
    cell1 = [tableView dequeueReusableCellWithIdentifier:@"AdminCell"];
    cell2 = [tableView dequeueReusableCellWithIdentifier:@"AdminImageCell"];
    cell3 = [tableView dequeueReusableCellWithIdentifier:@"ResCell"];
    cell4 = [tableView dequeueReusableCellWithIdentifier:@"ResImageCell"];
    cell5 = [tableView dequeueReusableCellWithIdentifier:@"ResLordCell"];
    cell6 = [tableView dequeueReusableCellWithIdentifier:@"ResImageLordCell"];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    cell3.selectionStyle = UITableViewCellSelectionStyleNone;
    cell4.selectionStyle = UITableViewCellSelectionStyleNone;
    cell5.selectionStyle = UITableViewCellSelectionStyleNone;
    cell6.selectionStyle = UITableViewCellSelectionStyleNone;
    //リストの配列番号取得
    //allTopicListAryからリストの配列番号の要素をNSDictionaryで取り出す
    NSDictionary *cellDic;
    if (self.allChatAry.count == 0) {
        cellDic = nil;
    }else{
        cellDic = [self.allChatAry objectAtIndex:indexPath.row];
    }
    NSString *memoStr = @"";
    if([cellDic.allKeys containsObject:@"TOPICID"]){
        if([[cellDic objectForKey:@"DELSTATUS"]  isEqual: @""]){
            memoStr = [cellDic objectForKey:@"TOPIC"];
        }else{
            memoStr = [NSString stringWithFormat:@"%@%@",[cellDic objectForKey:@"DELSTATUS"],[cellDic objectForKey:@"TOPIC"]];
        }
    }else{
        if([[cellDic objectForKey:@"DELSTATUS"]  isEqual: @""]){
            memoStr = [cellDic objectForKey:@"RES"];
        }else{
            memoStr = [NSString stringWithFormat:@"%@%@",[cellDic objectForKey:@"DELSTATUS"],[cellDic objectForKey:@"RES"]];
        }
    }
    /*AdminCell:話題開始用 画像なし
     *tag=1 : 背景、角丸、サイズ変更用
     *tag=2 : 本文ラベル
     *tag=3 : 投稿者
     *tag=4 : 返信件数ラベル
     *tag=5 : 削除ボタン
     *tag=6 : この話題に返信
     *tag=7 : 日時ラベル
     */
    UIView *backGraundView1 = (UIView *)[cell1 viewWithTag:1];
    [Common viewRoundedRect:backGraundView1 direction:1];
    UILabel *memoLabel1 = (UILabel *)[cell1 viewWithTag:2];
    memoLabel1.textColor = [UIColor blackColor];
    UILabel *nemeLabel1 = (UILabel *)[cell1 viewWithTag:3];
    nemeLabel1.adjustsFontSizeToFitWidth = YES;
    nemeLabel1.minimumScaleFactor = 5.f/30.f;
    UILabel *countLabel1 = (UILabel *)[cell1 viewWithTag:4];
    UIButton *delBtn1 = (UIButton *)[cell1 viewWithTag:5];
    delBtn1.layer.cornerRadius = 20;
    delBtn1.clipsToBounds = true;
    [delBtn1 addTarget:self action:@selector(deleteTopicBtn:event:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *reBtn1 = (UIButton *)[cell1 viewWithTag:6];
    reBtn1.layer.cornerRadius = 10;
    reBtn1.clipsToBounds = true;
    [reBtn1 addTarget:self action:@selector(handleTouchButton:event:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *timeLabel1 = (UILabel *)[cell1 viewWithTag:7];
    
    
    
    /*AdminImageCell:話題開始用 画像あり
     *tag=1 : 背景、角丸、サイズ変更用
     *tag=2 : 本文ラベル
     *tag=3 : 画像
     *tag=4 : 投稿者
     *tag=5 : 返信件数ラベル
     *tag=6 : 削除ボタン
     *tag=7 : この話題に返信
     *tag=8 : 日時ラベル
     */
    UIView *backGraundView2 = (UIView *)[cell2 viewWithTag:1];
    [Common viewRoundedRect:backGraundView2 direction:1];
    UILabel *memoLabel2 = (UILabel *)[cell2 viewWithTag:2];
    memoLabel2.textColor = [UIColor blackColor];
    UIImageView *image2 = (UIImageView *)[cell2 viewWithTag:3];
    image2.contentMode = UIViewContentModeScaleAspectFit;
    UILabel *nemeLabel2 = (UILabel *)[cell2 viewWithTag:4];
    nemeLabel2.adjustsFontSizeToFitWidth = YES;
    nemeLabel2.minimumScaleFactor = 5.f/30.f;
    UILabel *countLabel2 = (UILabel *)[cell2 viewWithTag:5];
    UIButton *delBtn2 = (UIButton *)[cell2 viewWithTag:6];
    delBtn2.layer.cornerRadius = 20;
    delBtn2.clipsToBounds = true;
    [delBtn2 addTarget:self action:@selector(deleteTopicBtn:event:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *reBtn2 = (UIButton *)[cell2 viewWithTag:7];
    reBtn2.layer.cornerRadius = 10;
    reBtn2.clipsToBounds = true;
    [reBtn2 addTarget:self action:@selector(handleTouchButton:event:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *timeLabel2 = (UILabel *)[cell2 viewWithTag:8];
    UIActivityIndicatorView *indicator2 = (UIActivityIndicatorView *)[cell2 viewWithTag:9];
    indicator2.hidesWhenStopped = YES;
    UIButton *imageBtn2 = (UIButton *)[cell2 viewWithTag:10];
    [imageBtn2 addTarget:self action:@selector(imagePicUpBtn:event:) forControlEvents:UIControlEventTouchUpInside];
    
    
    /*GuestCell:話題返信用 画像なし
     *tag=1 : 背景、角丸、サイズ変更用
     *tag=2 : 本文ラベル
     *tag=3 : 投稿者,日時ラベル
     *tag=4 : 削除ボタン
     */
    UIView *backGraundView3 = (UIView *)[cell3 viewWithTag:1];
    [Common viewRoundedRect:backGraundView3 direction:4];
    UILabel *memoLabel3 = (UILabel *)[cell3 viewWithTag:2];
    memoLabel3.textColor = [UIColor blackColor];
    
    UILabel *nemeLabel3 = (UILabel *)[cell3 viewWithTag:3];
    nemeLabel3.adjustsFontSizeToFitWidth = YES;
    nemeLabel3.minimumScaleFactor = 5.f/30.f;
    UIButton *delBtn3 = (UIButton *)[cell3 viewWithTag:4];
    delBtn3.layer.cornerRadius = 20;
    delBtn3.clipsToBounds = true;
    [delBtn3 addTarget:self action:@selector(deleteResBtn:event:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *timeLabel3 = (UILabel *)[cell3 viewWithTag:5];
    
    
    
    /*GuestImageCell:話題返信用もっと見る 画像あり
     *tag=1 : 背景、角丸、サイズ変更用
     *tag=2 : 本文ラベル
     *tag=3 : 画像
     *tag=4 : 投稿者,日時ラベル
     *tag=5 : 削除ボタン
     */
    UIView *backGraundView4 = (UIView *)[cell4 viewWithTag:1];
    [Common viewRoundedRect:backGraundView4 direction:4];
    UILabel *memoLabel4 = (UILabel *)[cell4 viewWithTag:2];
    memoLabel4.textColor = [UIColor blackColor];
    UIImageView *image4 = (UIImageView *)[cell4 viewWithTag:3];
    image4.contentMode = UIViewContentModeScaleAspectFit;
    UILabel *nemeLabel4 = (UILabel *)[cell4 viewWithTag:4];
    nemeLabel4.adjustsFontSizeToFitWidth = YES;
    nemeLabel4.minimumScaleFactor = 5.f/30.f;
    UIButton *delBtn4 = (UIButton *)[cell4 viewWithTag:5];
    delBtn4.layer.cornerRadius = 20;
    delBtn4.clipsToBounds = true;
    [delBtn4 addTarget:self action:@selector(deleteResBtn:event:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *timeLabel4 = (UILabel *)[cell4 viewWithTag:6];
    UIActivityIndicatorView *indicator4 = (UIActivityIndicatorView *)[cell4 viewWithTag:9];
    indicator4.hidesWhenStopped = YES;
    UIButton *imageBtn4 = (UIButton *)[cell4 viewWithTag:10];
    [imageBtn4 addTarget:self action:@selector(imagePicUpBtn:event:) forControlEvents:UIControlEventTouchUpInside];
    
    
    /*GuestLordCell:話題返信用 画像なし
     *tag=1 : 背景、角丸、サイズ変更用
     *tag=2 : 本文ラベル
     *tag=3 : 投稿者,日時ラベル
     *tag=4 : 削除ボタン
     *tag=5 : もっと見るボタン
     */
    UIView *backGraundView5 = (UIView *)[cell5 viewWithTag:1];
    [Common viewRoundedRect:backGraundView5 direction:2];
    UILabel *memoLabel5 = (UILabel *)[cell5 viewWithTag:2];
    memoLabel5.textColor = [UIColor blackColor];
    
    UILabel *nemeLabel5 = (UILabel *)[cell5 viewWithTag:3];
    nemeLabel5.adjustsFontSizeToFitWidth = YES;
    nemeLabel5.minimumScaleFactor = 5.f/30.f;
    UIButton *delBtn5 = (UIButton *)[cell5 viewWithTag:4];
    delBtn5.layer.cornerRadius = 20;
    delBtn5.clipsToBounds = true;
    [delBtn5 addTarget:self action:@selector(deleteResBtn:event:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *timeLabel5 = (UILabel *)[cell5 viewWithTag:5];
    UIButton *lordBtn5 = (UIButton *)[cell5 viewWithTag:6];
    [lordBtn5 addTarget:self action:@selector(lordButton:event:) forControlEvents:UIControlEventTouchUpInside];
    
    /*GuestImageLordCCell:話題返信用もっと見る 画像あり
     *tag=1 : 背景、角丸、サイズ変更用
     *tag=2 : 本文ラベル
     *tag=3 : 画像
     *tag=4 : 投稿者,日時ラベル
     *tag=5 : 削除ボタン
     *tag=6 : もっと見るボタン
     */
    UIView *backGraundView6 = (UIView *)[cell6 viewWithTag:1];
    [Common viewRoundedRect:backGraundView6 direction:2];
    UILabel *memoLabel6 = (UILabel *)[cell6 viewWithTag:2];
    memoLabel6.textColor = [UIColor blackColor];
    UIImageView *image6 = (UIImageView *)[cell6 viewWithTag:3];
    image6.contentMode = UIViewContentModeScaleAspectFit;
    UILabel *nemeLabel6 = (UILabel *)[cell6 viewWithTag:4];
    nemeLabel6.adjustsFontSizeToFitWidth = YES;
    nemeLabel6.minimumScaleFactor = 5.f/30.f;
    UIButton *delBtn6 = (UIButton *)[cell6 viewWithTag:5];
    delBtn6.layer.cornerRadius = 20;
    delBtn6.clipsToBounds = true;
    [delBtn6 addTarget:self action:@selector(deleteResBtn:event:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *timeLabel6 = (UILabel *)[cell6 viewWithTag:6];
    UIButton *lordBtn6 = (UIButton *)[cell6 viewWithTag:7];
    [lordBtn6 addTarget:self action:@selector(lordButton:event:) forControlEvents:UIControlEventTouchUpInside];
    UIActivityIndicatorView *indicator6 = (UIActivityIndicatorView *)[cell6 viewWithTag:9];
    indicator6.hidesWhenStopped = YES;
    UIButton *imageBtn6 = (UIButton *)[cell6 viewWithTag:10];
    [imageBtn6 addTarget:self action:@selector(imagePicUpBtn:event:) forControlEvents:UIControlEventTouchUpInside];
    
    
    int	resCount = 0;
    if([cellDic.allKeys containsObject:@"RESCOUNT"]){
        //"RESCOUNT"の数値を取得しておく
        resCount = [[cellDic objectForKey:@"RESCOUNT"] intValue];
    }
    
    
    //連想配列の要素に特定のキーがあるかどうかをチェック("TOPICID"が存在すれば見出し、しなければ返信)
    if([cellDic.allKeys containsObject:@"TOPICID"]){
        //見出し
        //"IMAGEURL"が空白かどうかをチェック
        if(![[cellDic objectForKey:@"IMAGEURL"]  isEqual: @""]){
            //画像がある
            //①の見出し画像ありのリスト処理
            memoLabel2 = [Common getLabelSize:memoLabel2 text:memoStr labelWidth:topicLabelWidth margin:0];
            memoLabel2.text = [NSString stringWithFormat:@"%@",memoStr];
            [memoLabel2 sizeToFit];
            float labelHeight2 = labelH;
            if (memoLabel2.frame.size.height > labelH) {
                labelHeight2 = memoLabel2.frame.size.height;
            }
            backGraundView2.frame = CGRectMake(backGraundView2.frame.origin.x, backGraundView2.frame.origin.y, backGraundView2.frame.size.width, backGraundView2.frame.size.height+labelHeight2);
            //文字数で増えたぶんだけずらす
            image2.transform = CGAffineTransformIdentity;
            image2.transform = CGAffineTransformMakeTranslation(0, labelHeight2);
            
            nemeLabel2.transform = CGAffineTransformIdentity;
            nemeLabel2.transform = CGAffineTransformMakeTranslation(0, labelHeight2);
            
            countLabel2.transform = CGAffineTransformIdentity;
            countLabel2.transform = CGAffineTransformMakeTranslation(0, labelHeight2);
            
            delBtn2.transform = CGAffineTransformIdentity;
            delBtn2.transform = CGAffineTransformMakeTranslation(0, labelHeight2);
            
            reBtn2.transform = CGAffineTransformIdentity;
            reBtn2.transform = CGAffineTransformMakeTranslation(0, labelHeight2);
            
            timeLabel2.transform = CGAffineTransformIdentity;
            timeLabel2.transform = CGAffineTransformMakeTranslation(0, labelHeight2);
            
            indicator2.transform = CGAffineTransformIdentity;
            indicator2.transform = CGAffineTransformMakeTranslation(0, labelHeight2);
            
            imageBtn2.transform = CGAffineTransformIdentity;
            imageBtn2.transform = CGAffineTransformMakeTranslation(0, labelHeight2);
            
            [indicator2 startAnimating];
            dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t q_main = dispatch_get_main_queue();
            image2.image = nil;
            dispatch_async(q_global, ^{
                UIImage *image = [self getImage:[cellDic objectForKey:@"IMAGEURL"]];
                dispatch_async(q_main, ^{
                    image2.image = image;
                    [indicator2 stopAnimating];
                });
            });
            
            nemeLabel2.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
            timeLabel2.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
            countLabel2.text = [NSString stringWithFormat:@"返信数：%@件",[cellDic objectForKey:@"RESCOUNT"]];
            //削除ボタンが管理者か自分で書き込んだ話題、返信の場合削除ボタン表示
            if ([self.manageId isEqual: [Common getUserID]] || [[cellDic objectForKey:@"WRITEUSERID"] isEqual: [Common getUserID]] || [[cellDic objectForKey:@"DELSTATUS"] isEqual: @""]) {
                delBtn2.hidden = NO;
            }else{
                delBtn2.hidden = YES;
            }
            if (resCount == 0) {
                [Common viewRoundedRect:backGraundView2 direction:3];
            }
            return cell2;
        }else{
            //画像がない
            //②の見出し画像なしのリスト処理
            memoLabel1 = [Common getLabelSize:memoLabel1 text:memoStr labelWidth:topicLabelWidth margin:0];
            memoLabel1.text = [NSString stringWithFormat:@"%@",memoStr];
            float labelHeight1 = labelH;
            if (memoLabel1.frame.size.height > labelH) {
                labelHeight1 = memoLabel1.frame.size.height;
            }
            backGraundView1.frame = CGRectMake(backGraundView1.frame.origin.x, backGraundView1.frame.origin.y, backGraundView1.frame.size.width, backGraundView1.frame.size.height+labelHeight1);
            //文字数で増えたぶんだけずらす
            nemeLabel1.transform = CGAffineTransformIdentity;
            nemeLabel1.transform = CGAffineTransformMakeTranslation(0, labelHeight1);
            
            countLabel1.transform = CGAffineTransformIdentity;
            countLabel1.transform = CGAffineTransformMakeTranslation(0, labelHeight1);
            
            delBtn1.transform = CGAffineTransformIdentity;
            delBtn1.transform = CGAffineTransformMakeTranslation(0, labelHeight1);
            
            reBtn1.transform = CGAffineTransformIdentity;
            reBtn1.transform = CGAffineTransformMakeTranslation(0, labelHeight1);
            
            timeLabel1.transform = CGAffineTransformIdentity;
            timeLabel1.transform = CGAffineTransformMakeTranslation(0, labelHeight1);
            
            nemeLabel1.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
            timeLabel1.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
            countLabel1.text = [NSString stringWithFormat:@"返信数：%@件",[cellDic objectForKey:@"RESCOUNT"]];
            //削除ボタンが管理者か自分で書き込んだ話題、返信の場合削除ボタン表示
            if ([self.manageId isEqual: [Common getUserID]] || [[cellDic objectForKey:@"WRITEUSERID"] isEqual: [Common getUserID]]) {
                delBtn1.hidden = NO;
            }else{
                delBtn1.hidden = YES;
            }
            if (resCount == 0) {
                [Common viewRoundedRect:backGraundView1 direction:3];
            }
            return cell1;
        }
    }else{
        //返信
        //resCountが3以下かどうか
        //3以下ならそのまま処理
        if(resCount < 4){
            //"IMAGEURL"が空白かどうかをチェック
            if(![[cellDic objectForKey:@"IMAGEURL"]  isEqual: @""]){
                //画像がある
                //③の返信 画像ありのリスト処理
                memoLabel4 = [Common getLabelSize:memoLabel4 text:memoStr labelWidth:resLabelWidth margin:0];
                memoLabel4.text = [NSString stringWithFormat:@"%@",memoStr];
                [memoLabel4 sizeToFit];
                float labelHeight4 = labelH;
                if (memoLabel4.frame.size.height > labelH) {
                    labelHeight4 = memoLabel4.frame.size.height;
                }
                backGraundView4.frame = CGRectMake(backGraundView4.frame.origin.x, backGraundView4.frame.origin.y, backGraundView4.frame.size.width, backGraundView4.frame.size.height+labelHeight4);
                //文字数で増えたぶんだけずらす
                image4.transform = CGAffineTransformIdentity;
                image4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                
                nemeLabel4.transform = CGAffineTransformIdentity;
                nemeLabel4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                
                delBtn4.transform = CGAffineTransformIdentity;
                delBtn4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                
                timeLabel4.transform = CGAffineTransformIdentity;
                timeLabel4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                
                indicator4.transform = CGAffineTransformIdentity;
                indicator4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                
                imageBtn4.transform = CGAffineTransformIdentity;
                imageBtn4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                
                [indicator4 startAnimating];
                dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_queue_t q_main = dispatch_get_main_queue();
                image4.image = nil;
                dispatch_async(q_global, ^{
                    UIImage *image = [self getImage:[cellDic objectForKey:@"IMAGEURL"]];
                    dispatch_async(q_main, ^{
                        image4.image = image;
                        [indicator4 stopAnimating];
                    });
                });
                nemeLabel4.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
                timeLabel4.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
                //削除ボタンが管理者か自分で書き込んだ話題、返信の場合削除ボタン表示
                if ([self.manageId isEqual: [Common getUserID]] || [[cellDic objectForKey:@"WRITEUSERID"] isEqual: [Common getUserID]]) {
                    delBtn4.hidden = NO;
                }else{
                    delBtn4.hidden = YES;
                }
                if (resCount == 1 && indexPath.row >= 1) {
                    NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row-1];
                    if([dic.allKeys containsObject:@"TOPICID"]){
                        [Common viewRoundedRect:backGraundView4 direction:2];
                    }
                }
                if (resCount == 2 && indexPath.row >= 2) {
                    NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row-2];
                    if([dic.allKeys containsObject:@"TOPICID"]){
                        [Common viewRoundedRect:backGraundView4 direction:2];
                    }
                }
                if (resCount == 3 && indexPath.row >= 3) {
                    NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row-3];
                    if([dic.allKeys containsObject:@"TOPICID"]){
                        [Common viewRoundedRect:backGraundView4 direction:2];
                    }
                }
                return cell4;
            }else{
                //画像がない
                //④の返信 画像なしのリスト処理
                memoLabel3 = [Common getLabelSize:memoLabel3 text:memoStr labelWidth:resLabelWidth margin:0];
                memoLabel3.text = [NSString stringWithFormat:@"%@",memoStr];
                [memoLabel3 sizeToFit];
                float labelHeight3 = labelH;
                if (memoLabel3.frame.size.height > labelH) {
                    labelHeight3 = memoLabel3.frame.size.height;
                }
                backGraundView3.frame = CGRectMake(backGraundView3.frame.origin.x, backGraundView3.frame.origin.y, backGraundView3.frame.size.width, backGraundView3.frame.size.height+labelHeight3);
                //文字数で増えたぶんだけずらす
                nemeLabel3.transform = CGAffineTransformIdentity;
                nemeLabel3.transform = CGAffineTransformMakeTranslation(0, labelHeight3);
                
                delBtn3.transform = CGAffineTransformIdentity;
                delBtn3.transform = CGAffineTransformMakeTranslation(0, labelHeight3);
                
                timeLabel3.transform = CGAffineTransformIdentity;
                timeLabel3.transform = CGAffineTransformMakeTranslation(0, labelHeight3);
                
                nemeLabel3.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
                timeLabel3.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
                //削除ボタンが管理者か自分で書き込んだ話題、返信の場合削除ボタン表示
                if ([self.manageId isEqual: [Common getUserID]] || [[cellDic objectForKey:@"WRITEUSERID"] isEqual: [Common getUserID]]) {
                    delBtn3.hidden = NO;
                }else{
                    delBtn3.hidden = YES;
                }
                if (resCount == 1 && indexPath.row >= 1) {
                    NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row-1];
                    if([dic.allKeys containsObject:@"TOPICID"]){
                        [Common viewRoundedRect:backGraundView3 direction:2];
                    }
                }
                if (resCount == 2 && indexPath.row >= 2) {
                    NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row-2];
                    if([dic.allKeys containsObject:@"TOPICID"]){
                        [Common viewRoundedRect:backGraundView3 direction:2];
                    }
                }
                if (resCount == 3 && indexPath.row >= 3) {
                    NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row-3];
                    if([dic.allKeys containsObject:@"TOPICID"]){
                        [Common viewRoundedRect:backGraundView3 direction:2];
                    }
                }
                return cell3;
            }
        }else{
            //resCountが4以上の場合こちらに分岐
            //リスト番号が3より上かどうか(アプリが落ちる対策)下の場合通常処理
            if(indexPath.row >= 3){
                //allTopicListAryから現在の3個前の要素を取得する
                NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row-3];
                //3個前の要素が見出しかどうか調べる、違う場合は通常処理
                if([dic.allKeys containsObject:@"TOPICID"]){
                    //もっと見るが選択されているかどうかのチェック
                    //openTopicIdと"TOPICID"が同じの場合通常処理、違う場合もっと見る表示に分岐
                    if([dic objectForKey:@"TOPICID"] == openTopicId){
                        //"IMAGEURL"が空白かどうかをチェック
                        if(![[cellDic objectForKey:@"IMAGEURL"]  isEqual: @""]){
                            //画像がある
                            //③の返信 画像ありのリスト処理
                            memoLabel4 = [Common getLabelSize:memoLabel4 text:memoStr labelWidth:resLabelWidth margin:0];
                            memoLabel4.text = [NSString stringWithFormat:@"%@",memoStr];
                            [memoLabel4 sizeToFit];
                            float labelHeight4 = labelH;
                            if (memoLabel4.frame.size.height > labelH) {
                                labelHeight4 = memoLabel4.frame.size.height;
                            }
                            backGraundView4.frame = CGRectMake(backGraundView4.frame.origin.x, backGraundView4.frame.origin.y, backGraundView4.frame.size.width, backGraundView4.frame.size.height+labelHeight4);
                            //文字数で増えたぶんだけずらす
                            image4.transform = CGAffineTransformIdentity;
                            image4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                            
                            nemeLabel4.transform = CGAffineTransformIdentity;
                            nemeLabel4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                            
                            delBtn4.transform = CGAffineTransformIdentity;
                            delBtn4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                            
                            timeLabel4.transform = CGAffineTransformIdentity;
                            timeLabel4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                            
                            indicator4.transform = CGAffineTransformIdentity;
                            indicator4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                            
                            imageBtn4.transform = CGAffineTransformIdentity;
                            imageBtn4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                            
                            [indicator4 startAnimating];
                            dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                            dispatch_queue_t q_main = dispatch_get_main_queue();
                            image4.image = nil;
                            dispatch_async(q_global, ^{
                                UIImage *image = [self getImage:[cellDic objectForKey:@"IMAGEURL"]];
                                dispatch_async(q_main, ^{
                                    image4.image = image;
                                    [indicator4 stopAnimating];
                                });
                            });
                            nemeLabel4.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
                            timeLabel4.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
                            //削除ボタンが管理者か自分で書き込んだ話題、返信の場合削除ボタン表示
                            if ([self.manageId isEqual: [Common getUserID]] || [[cellDic objectForKey:@"WRITEUSERID"] isEqual: [Common getUserID]]) {
                                delBtn4.hidden = NO;
                            }else{
                                delBtn4.hidden = YES;
                            }
                            int cellResCount = [[cellDic objectForKey:@"RESCOUNT"] intValue];
                            if (cellResCount > indexPath.row) {
                                
                            }else{
                                NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row - cellResCount];
                                if([dic.allKeys containsObject:@"TOPICID"]){
                                    if ([[cellDic objectForKey:@"RESCOUNT"]  isEqual: [dic objectForKey:@"RESCOUNT"]]) {
                                        [Common viewRoundedRect:backGraundView4 direction:2];
                                    }
                                }
                            }
                            return cell4;
                        }else{
                            //画像がない
                            //④の返信 画像なしのリスト処理
                            memoLabel3 = [Common getLabelSize:memoLabel3 text:memoStr labelWidth:resLabelWidth margin:0];
                            memoLabel3.text = [NSString stringWithFormat:@"%@",memoStr];
                            [memoLabel3 sizeToFit];
                            float labelHeight3 = labelH;
                            if (memoLabel3.frame.size.height > labelH) {
                                labelHeight3 = memoLabel3.frame.size.height;
                            }
                            backGraundView3.frame = CGRectMake(backGraundView3.frame.origin.x, backGraundView3.frame.origin.y, backGraundView3.frame.size.width, backGraundView3.frame.size.height+labelHeight3);
                            //文字数で増えたぶんだけずらす
                            nemeLabel3.transform = CGAffineTransformIdentity;
                            nemeLabel3.transform = CGAffineTransformMakeTranslation(0, labelHeight3);
                            
                            delBtn3.transform = CGAffineTransformIdentity;
                            delBtn3.transform = CGAffineTransformMakeTranslation(0, labelHeight3);
                            
                            timeLabel3.transform = CGAffineTransformIdentity;
                            timeLabel3.transform = CGAffineTransformMakeTranslation(0, labelHeight3);
                            
                            nemeLabel3.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
                            timeLabel3.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
                            //削除ボタンが管理者か自分で書き込んだ話題、返信の場合削除ボタン表示
                            if ([self.manageId isEqual: [Common getUserID]] || [[cellDic objectForKey:@"WRITEUSERID"] isEqual: [Common getUserID]]) {
                                delBtn3.hidden = NO;
                            }else{
                                delBtn3.hidden = YES;
                            }
                            int cellResCount = [[cellDic objectForKey:@"RESCOUNT"] intValue];
                            if (cellResCount > indexPath.row) {
                                
                            }else{
                                NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row - cellResCount];
                                if([dic.allKeys containsObject:@"TOPICID"]){
                                    if ([[cellDic objectForKey:@"RESCOUNT"]  isEqual: [dic objectForKey:@"RESCOUNT"]]) {
                                        [Common viewRoundedRect:backGraundView3 direction:2];
                                    }
                                }
                            }
                            return cell3;
                        }
                    }else{
                        //"IMAGEURL"が空白かどうかをチェック
                        if(![[cellDic objectForKey:@"IMAGEURL"]  isEqual: @""]){
                            //画像がある
                            //⑤の返信 画像あり もっと見る表示のリスト処理
                            memoLabel6 = [Common getLabelSize:memoLabel6 text:memoStr labelWidth:resLabelWidth margin:0];
                            memoLabel6.text = [NSString stringWithFormat:@"%@",memoStr];
                            [memoLabel6 sizeToFit];
                            float labelHeight6 = labelH;
                            if (memoLabel6.frame.size.height > labelH) {
                                labelHeight6 = memoLabel6.frame.size.height;
                            }
                            backGraundView6.frame = CGRectMake(backGraundView6.frame.origin.x, backGraundView6.frame.origin.y, backGraundView6.frame.size.width, backGraundView6.frame.size.height+labelHeight6);
                            //文字数で増えたぶんだけずらす
                            image6.transform = CGAffineTransformIdentity;
                            image6.transform = CGAffineTransformMakeTranslation(0, labelHeight6);
                            
                            nemeLabel6.transform = CGAffineTransformIdentity;
                            nemeLabel6.transform = CGAffineTransformMakeTranslation(0, labelHeight6);
                            
                            delBtn6.transform = CGAffineTransformIdentity;
                            delBtn6.transform = CGAffineTransformMakeTranslation(0, labelHeight6);
                            
                            timeLabel6.transform = CGAffineTransformIdentity;
                            timeLabel6.transform = CGAffineTransformMakeTranslation(0, labelHeight6);
                            
                            lordBtn6.transform = CGAffineTransformIdentity;
                            lordBtn6.transform = CGAffineTransformMakeTranslation(0, labelHeight6);
                            
                            indicator6.transform = CGAffineTransformIdentity;
                            indicator6.transform = CGAffineTransformMakeTranslation(0, labelHeight6);
                            
                            imageBtn6.transform = CGAffineTransformIdentity;
                            imageBtn6.transform = CGAffineTransformMakeTranslation(0, labelHeight6);
                            
                            [indicator6 startAnimating];
                            dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                            dispatch_queue_t q_main = dispatch_get_main_queue();
                            image6.image = nil;
                            dispatch_async(q_global, ^{
                                UIImage *image = [self getImage:[cellDic objectForKey:@"IMAGEURL"]];
                                dispatch_async(q_main, ^{
                                    image6.image = image;
                                    [indicator6 stopAnimating];
                                });
                            });
                            nemeLabel6.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
                            timeLabel6.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
                            [Common viewRoundedRect:backGraundView6 direction:2];
                            return cell6;
                        }else{
                            //画像がない
                            //⑥の返信 画像なし もっと見る表示のリスト処理
                            memoLabel5 = [Common getLabelSize:memoLabel5 text:memoStr labelWidth:resLabelWidth margin:0];
                            memoLabel5.text = [NSString stringWithFormat:@"%@",memoStr];
                            [memoLabel5 sizeToFit];
                            float labelHeight5 = labelH;
                            if (memoLabel5.frame.size.height > labelH) {
                                labelHeight5 = memoLabel5.frame.size.height;
                            }
                            backGraundView5.frame = CGRectMake(backGraundView5.frame.origin.x, backGraundView5.frame.origin.y, backGraundView5.frame.size.width, backGraundView5.frame.size.height+labelHeight5);
                            
                            //文字数で増えたぶんだけずらす
                            nemeLabel5.transform = CGAffineTransformIdentity;
                            nemeLabel5.transform = CGAffineTransformMakeTranslation(0, labelHeight5);
                            
                            delBtn5.transform = CGAffineTransformIdentity;
                            delBtn5.transform = CGAffineTransformMakeTranslation(0, labelHeight5);
                            
                            timeLabel5.transform = CGAffineTransformIdentity;
                            timeLabel5.transform = CGAffineTransformMakeTranslation(0, labelHeight5);
                            
                            lordBtn5.transform = CGAffineTransformIdentity;
                            lordBtn5.transform = CGAffineTransformMakeTranslation(0, labelHeight5);
                            
                            nemeLabel5.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
                            timeLabel5.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
                            [Common viewRoundedRect:backGraundView5 direction:2];
                            return cell5;
                        }
                    }
                }else{
                    //"IMAGEURL"が空白かどうかをチェック
                    if(![[cellDic objectForKey:@"IMAGEURL"]  isEqual: @""]){
                        //画像がある
                        //③の返信 画像ありのリスト処理
                        memoLabel4 = [Common getLabelSize:memoLabel4 text:memoStr labelWidth:resLabelWidth margin:0];
                        memoLabel4.text = [NSString stringWithFormat:@"%@",memoStr];
                        [memoLabel4 sizeToFit];
                        float labelHeight4 = labelH;
                        if (memoLabel4.frame.size.height > labelH) {
                            labelHeight4 = memoLabel4.frame.size.height;
                        }
                        backGraundView4.frame = CGRectMake(backGraundView4.frame.origin.x, backGraundView4.frame.origin.y, backGraundView4.frame.size.width, backGraundView4.frame.size.height+labelHeight4);
                        //文字数で増えたぶんだけずらす
                        image4.transform = CGAffineTransformIdentity;
                        image4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                        
                        nemeLabel4.transform = CGAffineTransformIdentity;
                        nemeLabel4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                        
                        delBtn4.transform = CGAffineTransformIdentity;
                        delBtn4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                        
                        timeLabel4.transform = CGAffineTransformIdentity;
                        timeLabel4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                        
                        indicator4.transform = CGAffineTransformIdentity;
                        indicator4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                        
                        imageBtn4.transform = CGAffineTransformIdentity;
                        imageBtn4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                        
                        [indicator4 startAnimating];
                        dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                        dispatch_queue_t q_main = dispatch_get_main_queue();
                        image4.image = nil;
                        dispatch_async(q_global, ^{
                            UIImage *image = [self getImage:[cellDic objectForKey:@"IMAGEURL"]];
                            dispatch_async(q_main, ^{
                                image4.image = image;
                                [indicator4 stopAnimating];
                            });
                        });
                        nemeLabel4.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
                        timeLabel4.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
                        //削除ボタンが管理者か自分で書き込んだ話題、返信の場合削除ボタン表示
                        if ([self.manageId isEqual: [Common getUserID]] || [[cellDic objectForKey:@"WRITEUSERID"] isEqual: [Common getUserID]]) {
                            delBtn4.hidden = NO;
                        }else{
                            delBtn4.hidden = YES;
                        }
                        int cellResCount = [[cellDic objectForKey:@"RESCOUNT"] intValue];
                        if (cellResCount > indexPath.row) {
                            
                        }else{
                            NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row - cellResCount];
                            if([dic.allKeys containsObject:@"TOPICID"]){
                                if ([[cellDic objectForKey:@"RESCOUNT"]  isEqual: [dic objectForKey:@"RESCOUNT"]]) {
                                    [Common viewRoundedRect:backGraundView4 direction:2];
                                }
                            }
                        }
                        return cell4;
                    }else{
                        //画像がない
                        //④の返信 画像なしのリスト処理
                        memoLabel3 = [Common getLabelSize:memoLabel3 text:memoStr labelWidth:resLabelWidth margin:0];
                        memoLabel3.text = [NSString stringWithFormat:@"%@",memoStr];
                        [memoLabel3 sizeToFit];
                        float labelHeight3 = labelH;
                        if (memoLabel3.frame.size.height > labelH) {
                            labelHeight3 = memoLabel3.frame.size.height;
                        }
                        backGraundView3.frame = CGRectMake(backGraundView3.frame.origin.x, backGraundView3.frame.origin.y, backGraundView3.frame.size.width, backGraundView3.frame.size.height+labelHeight3);
                        //文字数で増えたぶんだけずらす
                        nemeLabel3.transform = CGAffineTransformIdentity;
                        nemeLabel3.transform = CGAffineTransformMakeTranslation(0, labelHeight3);
                        
                        delBtn3.transform = CGAffineTransformIdentity;
                        delBtn3.transform = CGAffineTransformMakeTranslation(0, labelHeight3);
                        
                        timeLabel3.transform = CGAffineTransformIdentity;
                        timeLabel3.transform = CGAffineTransformMakeTranslation(0, labelHeight3);
                        
                        nemeLabel3.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
                        timeLabel3.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
                        //削除ボタンが管理者か自分で書き込んだ話題、返信の場合削除ボタン表示
                        if ([self.manageId isEqual: [Common getUserID]] || [[cellDic objectForKey:@"WRITEUSERID"] isEqual: [Common getUserID]]) {
                            delBtn3.hidden = NO;
                        }else{
                            delBtn3.hidden = YES;
                        }
                        int cellResCount = [[cellDic objectForKey:@"RESCOUNT"] intValue];
                        if (cellResCount > indexPath.row) {
                            
                        }else{
                            NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row - cellResCount];
                            if([dic.allKeys containsObject:@"TOPICID"]){
                                if ([[cellDic objectForKey:@"RESCOUNT"]  isEqual: [dic objectForKey:@"RESCOUNT"]]) {
                                    [Common viewRoundedRect:backGraundView3 direction:2];
                                }
                            }
                        }
                        return cell3;
                    }
                }
            }else{
                //"IMAGEURL"が空白かどうかをチェック
                if(![[cellDic objectForKey:@"IMAGEURL"]  isEqual: @""]){
                    //画像がある
                    //③の返信 画像ありのリスト処理
                    memoLabel4 = [Common getLabelSize:memoLabel4 text:memoStr labelWidth:resLabelWidth margin:0];
                    memoLabel4.text = [NSString stringWithFormat:@"%@",memoStr];
                    [memoLabel4 sizeToFit];
                    float labelHeight4 = labelH;
                    if (memoLabel4.frame.size.height > labelH) {
                        labelHeight4 = memoLabel4.frame.size.height;
                    }
                    backGraundView4.frame = CGRectMake(backGraundView4.frame.origin.x, backGraundView4.frame.origin.y, backGraundView4.frame.size.width, backGraundView4.frame.size.height+labelHeight4);
                    //文字数で増えたぶんだけずらす
                    image4.transform = CGAffineTransformIdentity;
                    image4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                    
                    nemeLabel4.transform = CGAffineTransformIdentity;
                    nemeLabel4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                    
                    delBtn4.transform = CGAffineTransformIdentity;
                    delBtn4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                    
                    timeLabel4.transform = CGAffineTransformIdentity;
                    timeLabel4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                    
                    indicator4.transform = CGAffineTransformIdentity;
                    indicator4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                    
                    imageBtn4.transform = CGAffineTransformIdentity;
                    imageBtn4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
                    
                    [indicator4 startAnimating];
                    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                    dispatch_queue_t q_main = dispatch_get_main_queue();
                    image4.image = nil;
                    dispatch_async(q_global, ^{
                        UIImage *image = [self getImage:[cellDic objectForKey:@"IMAGEURL"]];
                        dispatch_async(q_main, ^{
                            image4.image = image;
                            [indicator4 stopAnimating];
                        });
                    });
                    nemeLabel4.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
                    timeLabel4.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
                    //削除ボタンが管理者か自分で書き込んだ話題、返信の場合削除ボタン表示
                    if ([self.manageId isEqual: [Common getUserID]] || [[cellDic objectForKey:@"WRITEUSERID"] isEqual: [Common getUserID]]) {
                        delBtn4.hidden = NO;
                    }else{
                        delBtn4.hidden = YES;
                    }
                    int cellResCount = [[cellDic objectForKey:@"RESCOUNT"] intValue];
                    if (cellResCount > indexPath.row) {
                        
                    }else{
                        NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row - cellResCount];
                        if([dic.allKeys containsObject:@"TOPICID"]){
                            if ([[cellDic objectForKey:@"RESCOUNT"]  isEqual: [dic objectForKey:@"RESCOUNT"]]) {
                                [Common viewRoundedRect:backGraundView4 direction:2];
                            }
                        }
                    }
                    return cell4;
                }else{
                    //画像がない
                    //④の返信 画像なしのリスト処理
                    memoLabel3 = [Common getLabelSize:memoLabel3 text:memoStr labelWidth:resLabelWidth margin:0];
                    memoLabel3.text = [NSString stringWithFormat:@"%@",memoStr];
                    [memoLabel3 sizeToFit];
                    float labelHeight3 = labelH;
                    if (memoLabel3.frame.size.height > labelH) {
                        labelHeight3 = memoLabel3.frame.size.height;
                    }
                    backGraundView3.frame = CGRectMake(backGraundView3.frame.origin.x, backGraundView3.frame.origin.y, backGraundView3.frame.size.width, backGraundView3.frame.size.height+labelHeight3);
                    //文字数で増えたぶんだけずらす
                    nemeLabel3.transform = CGAffineTransformIdentity;
                    nemeLabel3.transform = CGAffineTransformMakeTranslation(0, labelHeight3);
                    
                    delBtn3.transform = CGAffineTransformIdentity;
                    delBtn3.transform = CGAffineTransformMakeTranslation(0, labelHeight3);
                    
                    timeLabel3.transform = CGAffineTransformIdentity;
                    timeLabel3.transform = CGAffineTransformMakeTranslation(0, labelHeight3);
                    
                    nemeLabel3.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
                    timeLabel3.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
                    //削除ボタンが管理者か自分で書き込んだ話題、返信の場合削除ボタン表示
                    if ([self.manageId isEqual: [Common getUserID]] || [[cellDic objectForKey:@"WRITEUSERID"] isEqual: [Common getUserID]]) {
                        delBtn3.hidden = NO;
                    }else{
                        delBtn3.hidden = YES;
                    }
                    int cellResCount = [[cellDic objectForKey:@"RESCOUNT"] intValue];
                    if (cellResCount > indexPath.row) {
                        
                    }else{
                        NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row - cellResCount];
                        if([dic.allKeys containsObject:@"TOPICID"]){
                            if ([[cellDic objectForKey:@"RESCOUNT"]  isEqual: [dic objectForKey:@"RESCOUNT"]]) {
                                [Common viewRoundedRect:backGraundView3 direction:2];
                            }
                        }
                    }
                    return cell3;
                }
            }
        }
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//イメージ取得
-(UIImage *)getImage:(NSString *)imageUrl{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageUrl]]];
    return image;
}


//  UIImagePickerControllerデリゲート
//　撮影が完了時した時に呼ばれる
- (void)imagePickerController: (UIImagePickerController *)imagePicker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    cameraImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.preImageView setImage:cameraImage];
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)backBtn:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)postBtn:(id)sender{
    cameraImage = nil;
    self.dialogTextView.text = @"";
    chatType = @"topic";
    topicId = @"";
    self.dialogTitleView.text = @"新しい話題を投稿";
    self.dialogBaseView.hidden = NO;
    self.preImageView.image = nil;
}
- (IBAction)cameraBtn:(id)sender {
    // カメラの利用
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    // カメラが利用可能かチェック
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        // インスタンスの作成
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.sourceType = sourceType;
        cameraPicker.delegate = self;
        
        [self presentViewController:cameraPicker animated:YES completion:nil];
    }
    else{
        
    }
}
- (IBAction)albumBtn:(id)sender {
    // アルバムの利用
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.sourceType = sourceType;
        cameraPicker.delegate = self;
        
        // ビューを開く
        [self presentViewController:cameraPicker animated:YES completion:nil];
        
    }
    else{
    }
}
- (IBAction)okBtn:(id)sender {
    if (cameraImage == nil) {
        NSDictionary *addTopicResDic = [PHPConnection addTopicRes:self.threadId type:chatType topicid:topicId memo:self.dialogTextView.text imageurl:@""];
    }else{
        [self imagePostData:cameraImage type:chatType topicId:topicId memo:self.dialogTextView.text];
    }
    
    
    [self keyBoardCloes];
    self.dialogBaseView.hidden = YES;
    [self getChatAry];
}
- (IBAction)cancelBtn:(id)sender {
    [self keyBoardCloes];
    self.dialogBaseView.hidden = YES;
}
//セルの画像タップで画面全体に表示させる
- (void)imagePicUpBtn:(UIButton *)sender event:(UIEvent *)event {
    NSIndexPath *indexPath = [self indexPathForControlEvent:event];
    NSDictionary *cellDic = [self.allChatAry objectAtIndex:indexPath.row];
    UIView *imageSetView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    imageSetView.tag = imageTapTag;
    imageSetView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageSetView.frame];
    imageView.tag = imageTag;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageSetView addSubview:imageView];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // 画面の中央に表示するようにframeを変更する
    float w = indicator.frame.size.width;
    float h = indicator.frame.size.height;
    float x = imageSetView.frame.size.width/2 - w/2;
    float y = imageSetView.frame.size.height/2 - h/2;
    indicator.frame = CGRectMake(x, y, w, h);
    indicator.hidesWhenStopped = YES;
    [indicator startAnimating];
    [imageSetView addSubview:indicator];
    [self.view addSubview:imageSetView];
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        UIImage *image = [self getImage:[cellDic objectForKey:@"IMAGEURL"]];
        dispatch_async(q_main, ^{
            imageView.image = image;
            [indicator stopAnimating];
            UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
            [imageSetView addGestureRecognizer:tapGesture];
            UIPinchGestureRecognizer* pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
            pinchGesture.delegate = self;
            [imageSetView addGestureRecognizer:pinchGesture];
            UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
            [imageSetView addGestureRecognizer:panGesture];
        });
    });
}
- (void) handleTapGesture:(UITapGestureRecognizer*)sender {
    UIView *view = (UIView *)[self.view viewWithTag:imageTapTag];
    [view removeFromSuperview];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]) {
        // 適用されているスケールを覚えておく
        beginGestureScale = effectiveScale;
    }
    return YES;
}
- (void) handlePinchGesture:(UIPinchGestureRecognizer*) sender {
    UIPinchGestureRecognizer* pinch = (UIPinchGestureRecognizer*)sender;
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:imageTag];
    // 新しく適用するスケールを計算する (適用されているスケール x 新しくピンチしたスケール)
    effectiveScale = beginGestureScale * pinch.scale;
    // スケールをビューに適用する
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(imageX, imageY);
    CGAffineTransform t2 = CGAffineTransformMakeScale(effectiveScale, effectiveScale);
    CGAffineTransform t = CGAffineTransformConcat(t1, t2);
    imageView.transform = t;
    
}
- (void) handlePanGesture:(UIPanGestureRecognizer*) sender {
    UIPanGestureRecognizer* pan = (UIPanGestureRecognizer*) sender;
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:imageTag];
    CGPoint location = [pan translationInView:self.view];
    imageX = location.x;
    imageY = location.y;
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(imageX, imageY);
    CGAffineTransform t2 = CGAffineTransformMakeScale(effectiveScale, effectiveScale);
    CGAffineTransform t = CGAffineTransformConcat(t1, t2);
    imageView.transform = t;
}
//もっと見るボタン
- (void)lordButton:(UIButton *)sender event:(UIEvent *)event {
    NSIndexPath *indexPath = [self indexPathForControlEvent:event];
    //もっと見るは３個目の返信のため３個前の話題データを取得しtopicidを取得する
    NSDictionary *cellDic = [self.allChatAry objectAtIndex:indexPath.row-3];
    //rescount取得して話題を取得しtopicidを取得する
    openTopicId = [cellDic objectForKey:@"TOPICID"];
    [self getChatAry];
}
//cell削除ボタン
- (void)deleteTopicBtn:(UIButton *)sender event:(UIEvent *)event {
    NSIndexPath *indexPath = [self indexPathForControlEvent:event];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"確認" message:@"書き込みを削除します。\nよろしいですか？" preferredStyle:UIAlertControllerStyleAlert];
    
    // addActionした順に左から右にボタンが配置されます
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // otherボタンが押された時の処理
        [self otherButtonPushed:indexPath type:@"TOPIC"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"キャンセル" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // cancelボタンが押された時の処理
        [self cancelButtonPushed];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}
- (void)deleteResBtn:(UIButton *)sender event:(UIEvent *)event {
    NSIndexPath *indexPath = [self indexPathForControlEvent:event];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"確認" message:@"書き込みを削除します。\nよろしいですか？" preferredStyle:UIAlertControllerStyleAlert];
    
    // addActionした順に左から右にボタンが配置されます
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // otherボタンが押された時の処理
        [self otherButtonPushed:indexPath type:@"RES"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"キャンセル" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // cancelボタンが押された時の処理
        [self cancelButtonPushed];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)cancelButtonPushed{
}
- (void)otherButtonPushed:(NSIndexPath *)indexPath type:(NSString *)type{
    if ([type  isEqual: @"TOPIC"]) {
        NSDictionary *cellDic = [self.allChatAry objectAtIndex:indexPath.row];
        NSDictionary *delTopicRes = [PHPConnection delTopicRes:self.threadId type:@"topic" cid:[cellDic objectForKey:@"TOPICID"]];
        if ([Common checkErrorMessage:delTopicRes] == YES) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エラー" message:[NSString stringWithFormat:@"%@",[delTopicRes objectForKey:@"ERRORMESSAGE"]] preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                // cancelボタンが押された時の処理
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            [self getChatAry];
        }
    }else{
        NSDictionary *cellDic = [self.allChatAry objectAtIndex:indexPath.row];
        NSDictionary *delTopicRes = [PHPConnection delTopicRes:self.threadId type:@"res" cid:[cellDic objectForKey:@"RESID"]];
        if ([Common checkErrorMessage:delTopicRes] == YES) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エラー" message:[NSString stringWithFormat:@"%@",[delTopicRes objectForKey:@"ERRORMESSAGE"]] preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                // cancelボタンが押された時の処理
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            [self getChatAry];
        }
    }
}
#pragma mark - handleTouchEvent
- (void)handleTouchButton:(UIButton *)sender event:(UIEvent *)event {
    NSIndexPath *indexPath = [self indexPathForControlEvent:event];
    NSDictionary *cellDic = [self.allChatAry objectAtIndex:indexPath.row];
    cameraImage = nil;
    self.preImageView.image = nil;
    self.dialogTextView.text = @"";
    topicId = [cellDic objectForKey:@"TOPICID"];
    chatType = @"res";
    self.dialogTitleView.text = @"話題に返信";
    self.dialogBaseView.hidden = NO;
}

// UIControlEventからタッチ位置のindexPathを取得する
- (NSIndexPath *)indexPathForControlEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint p = [touch locationInView:self.chatTableView];
    NSIndexPath *indexPath = [self.chatTableView indexPathForRowAtPoint:p];
    return indexPath;
}
-(BOOL)textViewShouldBeginEditing:(UITextView*)textView{
    self.dialogMainView.transform = CGAffineTransformMakeTranslation(0, -50);
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self keyBoardCloes];
}
-(void)keyBoardCloes{
    [self.dialogTextView resignFirstResponder];
    self.dialogMainView.transform = CGAffineTransformIdentity;
}
//更新
- (void)refleshControlSetting
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(onRefresh:)
             forControlEvents:UIControlEventValueChanged];
    [self.chatTableView addSubview:refreshControl];
}

- (void)onRefresh:(UIRefreshControl *)refreshControl
{
    [refreshControl beginRefreshing];
    // ここの間に更新のロジックを書く
    self.chatTableView.userInteractionEnabled = NO;
    [self getChatAry];
    [refreshControl endRefreshing];
}
- (IBAction)allUserBtn:(id)sender {
    NSMutableArray *ary = [PHPConnection getThreadMember:self.threadId manageid:self.manageId];
    NSMutableString *mStr = [NSMutableString string];
    if ([self.manageId  isEqual: @"0"]) {
        [mStr appendString:@"グループメンバー全て"];
    }else{
        for (NSDictionary *dic in ary) {
            [mStr appendString:[NSString stringWithFormat:@"%@\n",[dic objectForKey:@"USERNAME"]]];
        }
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"参加メンバー" message:mStr preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // cancelボタンが押された時の処理
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)imagePostData:(UIImage *)postImage type:(NSString *)type topicId:(NSString *)topicId memo:(NSString *)memo{
    NSMutableDictionary* dicText = [NSMutableDictionary dictionary];
    NSMutableDictionary* dicImage = [NSMutableDictionary dictionary];
    
    [dicText setObject:[Common getUserID] forKey:@"userid"];
    [dicText setObject:[Common getGroupID] forKey:@"groupid"];
    [dicText setObject:self.threadId forKey:@"threadid"];
    [dicText setObject:type forKey:@"type"];
    [dicText setObject:topicId forKey:@"topicid"];
    [dicText setObject:memo forKey:@"memo"];
    
    // 1つ目の画像
    NSData *imageData = [[NSData alloc]initWithData:UIImageJPEGRepresentation(postImage, 0.5)];
    [dicImage setObject:imageData forKey:@"postImage"];
    
    NSURL* url = [NSURL URLWithString:@"http://api.suisaniot.net/suisaniot/v2/app/addImageTopicRes.php"];
    
    [self postMultiDataWithTextDictionary:dicText imageDictionary:dicImage url:url delegate: self];
}

- (void)postMultiDataWithTextDictionary:(NSDictionary*)textDictionary
                        imageDictionary:(NSDictionary*)imageDictionary
                                    url:(NSURL*)url
                               delegate:(id<NSURLSessionDelegate>)delegate
{
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSString* boundary = @"MyBoundaryString";
    config.HTTPAdditionalHeaders =
    @{
      @"Content-Type" : [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary]
      };
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config
                                                          delegate:delegate
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    
    // postデータの作成
    NSMutableData* data = [NSMutableData data];
    
    // テキスト部分の設定
    for (id key in [textDictionary keyEnumerator])
    {
        NSString* value = [textDictionary valueForKey:key];
        
        [data appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data;"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"%@\r\n", value] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // 画像の設定
    for (int i = 0; i < [imageDictionary count]; i++)
    {
        NSString* key = [[imageDictionary allKeys] objectAtIndex:i];
        NSData* value = [imageDictionary valueForKey:key];
        NSString* name = [NSString stringWithFormat:@"uploadFile"];
        
        [data appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data;"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"name=\"%@\";", name] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"filename=\"%@\"\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[[NSString stringWithFormat:@"Content-Type: image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:value];
        [data appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // 最後にバウンダリを付ける
    [data appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    request.HTTPMethod = @"POST";
    request.HTTPBody = data;
//    NSURLSessionDataTask* task = [session dataTaskWithRequest:request];
//    
//    [task resume];
    [[session dataTaskWithRequest: request  completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // レスポンスが成功か失敗かを見てそれぞれ処理を行う
        if (response && ! error) {
            NSString *responseString = [[NSString alloc] initWithData: data  encoding: NSUTF8StringEncoding];
            NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
            if ([Common checkErrorMessage:dic] == YES) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エラー" message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ERRORMESSAGE"]] preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    // cancelボタンが押された時の処理
                }]];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }else{
                [self getChatAry];
            }
            cameraImage = nil;
        }
        else {
        }
        
    }] resume];
}
- (void)updateVisibleCells {
    for (UITableViewCell *cell in [self.chatTableView visibleCells]){
        [self updateCell:cell atIndexPath:[self.chatTableView indexPathForCell:cell]];
    }
}

//for cell updating
- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    //リストの配列番号取得
    //allTopicListAryからリストの配列番号の要素をNSDictionaryで取り出す
    NSDictionary *cellDic = [self.allChatAry objectAtIndex:indexPath.row];
    NSString *memoStr = @"";
    if([cellDic.allKeys containsObject:@"TOPICID"]){
        if([[cellDic objectForKey:@"DELSTATUS"]  isEqual: @""]){
            memoStr = [cellDic objectForKey:@"TOPIC"];
        }else{
            memoStr = [NSString stringWithFormat:@"%@%@",[cellDic objectForKey:@"DELSTATUS"],[cellDic objectForKey:@"TOPIC"]];
        }
    }else{
        if([[cellDic objectForKey:@"DELSTATUS"]  isEqual: @""]){
            memoStr = [cellDic objectForKey:@"RES"];
        }else{
            memoStr = [NSString stringWithFormat:@"%@%@",[cellDic objectForKey:@"DELSTATUS"],[cellDic objectForKey:@"RES"]];
        }
    }
    int	resCount = 0;
    if([cellDic.allKeys containsObject:@"RESCOUNT"]){
        //"RESCOUNT"の数値を取得しておく
        resCount = [[cellDic objectForKey:@"RESCOUNT"] intValue];
    }
    
    if ([cell.reuseIdentifier  isEqual: @"AdminCell"]) {
        UIView *backGraundView1 = (UIView *)[cell viewWithTag:1];
        [Common viewRoundedRect:backGraundView1 direction:1];
        UILabel *memoLabel1 = (UILabel *)[cell viewWithTag:2];
        memoLabel1.textColor = [UIColor blackColor];
        UILabel *nemeLabel1 = (UILabel *)[cell viewWithTag:3];
        nemeLabel1.adjustsFontSizeToFitWidth = YES;
        nemeLabel1.minimumScaleFactor = 5.f/30.f;
        UILabel *countLabel1 = (UILabel *)[cell viewWithTag:4];
        UIButton *delBtn1 = (UIButton *)[cell viewWithTag:5];
        delBtn1.layer.cornerRadius = 20;
        delBtn1.clipsToBounds = true;
        UIButton *reBtn1 = (UIButton *)[cell viewWithTag:6];
        reBtn1.layer.cornerRadius = 10;
        reBtn1.clipsToBounds = true;
        UILabel *timeLabel1 = (UILabel *)[cell viewWithTag:7];
        memoLabel1 = [Common getLabelSize:memoLabel1 text:memoStr labelWidth:topicLabelWidth margin:0];
        memoLabel1.text = [NSString stringWithFormat:@"%@",memoStr];
        float labelHeight1 = labelH;
        if (memoLabel1.frame.size.height > labelH) {
            labelHeight1 = memoLabel1.frame.size.height;
        }
        backGraundView1.frame = CGRectMake(backGraundView1.frame.origin.x, backGraundView1.frame.origin.y, backGraundView1.frame.size.width, backGraundView1.frame.size.height+labelHeight1);
        //文字数で増えたぶんだけずらす
        nemeLabel1.transform = CGAffineTransformIdentity;
        nemeLabel1.transform = CGAffineTransformMakeTranslation(0, labelHeight1);
        
        countLabel1.transform = CGAffineTransformIdentity;
        countLabel1.transform = CGAffineTransformMakeTranslation(0, labelHeight1);
        
        delBtn1.transform = CGAffineTransformIdentity;
        delBtn1.transform = CGAffineTransformMakeTranslation(0, labelHeight1);
        
        reBtn1.transform = CGAffineTransformIdentity;
        reBtn1.transform = CGAffineTransformMakeTranslation(0, labelHeight1);
        
        timeLabel1.transform = CGAffineTransformIdentity;
        timeLabel1.transform = CGAffineTransformMakeTranslation(0, labelHeight1);
        
        nemeLabel1.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
        timeLabel1.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
        countLabel1.text = [NSString stringWithFormat:@"返信数：%@件",[cellDic objectForKey:@"RESCOUNT"]];
        //削除ボタンが管理者か自分で書き込んだ話題、返信の場合削除ボタン表示
        if ([self.manageId isEqual: [Common getUserID]] || [[cellDic objectForKey:@"WRITEUSERID"] isEqual: [Common getUserID]]) {
            delBtn1.hidden = NO;
        }else{
            delBtn1.hidden = YES;
        }
        if (resCount == 0) {
            [Common viewRoundedRect:backGraundView1 direction:3];
        }
    }
    if ([cell.reuseIdentifier  isEqual: @"AdminImageCell"]) {
        UIView *backGraundView2 = (UIView *)[cell viewWithTag:1];
        [Common viewRoundedRect:backGraundView2 direction:1];
        UILabel *memoLabel2 = (UILabel *)[cell viewWithTag:2];
        memoLabel2.textColor = [UIColor blackColor];
        UIImageView *image2 = (UIImageView *)[cell viewWithTag:3];
        image2.contentMode = UIViewContentModeScaleAspectFit;
        UILabel *nemeLabel2 = (UILabel *)[cell viewWithTag:4];
        nemeLabel2.adjustsFontSizeToFitWidth = YES;
        nemeLabel2.minimumScaleFactor = 5.f/30.f;
        UILabel *countLabel2 = (UILabel *)[cell viewWithTag:5];
        UIButton *delBtn2 = (UIButton *)[cell viewWithTag:6];
        delBtn2.layer.cornerRadius = 20;
        delBtn2.clipsToBounds = true;
        UIButton *reBtn2 = (UIButton *)[cell viewWithTag:7];
        reBtn2.layer.cornerRadius = 10;
        reBtn2.clipsToBounds = true;
        UILabel *timeLabel2 = (UILabel *)[cell viewWithTag:8];
        UIActivityIndicatorView *indicator2 = (UIActivityIndicatorView *)[cell viewWithTag:9];
        indicator2.hidesWhenStopped = YES;
        UIButton *imageBtn2 = (UIButton *)[cell viewWithTag:10];
        
        memoLabel2 = [Common getLabelSize:memoLabel2 text:memoStr labelWidth:topicLabelWidth margin:0];
        memoLabel2.text = [NSString stringWithFormat:@"%@",memoStr];
        [memoLabel2 sizeToFit];
        float labelHeight2 = labelH;
        if (memoLabel2.frame.size.height > labelH) {
            labelHeight2 = memoLabel2.frame.size.height;
        }
        backGraundView2.frame = CGRectMake(backGraundView2.frame.origin.x, backGraundView2.frame.origin.y, backGraundView2.frame.size.width, backGraundView2.frame.size.height+labelHeight2);
        //文字数で増えたぶんだけずらす
        image2.transform = CGAffineTransformIdentity;
        image2.transform = CGAffineTransformMakeTranslation(0, labelHeight2);
        
        nemeLabel2.transform = CGAffineTransformIdentity;
        nemeLabel2.transform = CGAffineTransformMakeTranslation(0, labelHeight2);
        
        countLabel2.transform = CGAffineTransformIdentity;
        countLabel2.transform = CGAffineTransformMakeTranslation(0, labelHeight2);
        
        delBtn2.transform = CGAffineTransformIdentity;
        delBtn2.transform = CGAffineTransformMakeTranslation(0, labelHeight2);
        
        reBtn2.transform = CGAffineTransformIdentity;
        reBtn2.transform = CGAffineTransformMakeTranslation(0, labelHeight2);
        
        timeLabel2.transform = CGAffineTransformIdentity;
        timeLabel2.transform = CGAffineTransformMakeTranslation(0, labelHeight2);
        
        indicator2.transform = CGAffineTransformIdentity;
        indicator2.transform = CGAffineTransformMakeTranslation(0, labelHeight2);
        
        imageBtn2.transform = CGAffineTransformIdentity;
        imageBtn2.transform = CGAffineTransformMakeTranslation(0, labelHeight2);
        
//        [indicator2 startAnimating];
//        dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        dispatch_queue_t q_main = dispatch_get_main_queue();
//        image2.image = nil;
//        dispatch_async(q_global, ^{
//            UIImage *image = [self getImage:[cellDic objectForKey:@"IMAGEURL"]];
//            dispatch_async(q_main, ^{
//                image2.image = image;
//                [indicator2 stopAnimating];
//            });
//        });
        
        nemeLabel2.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
        timeLabel2.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
        countLabel2.text = [NSString stringWithFormat:@"返信数：%@件",[cellDic objectForKey:@"RESCOUNT"]];
        //削除ボタンが管理者か自分で書き込んだ話題、返信の場合削除ボタン表示
        if ([self.manageId isEqual: [Common getUserID]] || [[cellDic objectForKey:@"WRITEUSERID"] isEqual: [Common getUserID]] || [[cellDic objectForKey:@"DELSTATUS"] isEqual: @""]) {
            delBtn2.hidden = NO;
        }else{
            delBtn2.hidden = YES;
        }
        if (resCount == 0) {
            [Common viewRoundedRect:backGraundView2 direction:3];
        }
    }
    if ([cell.reuseIdentifier  isEqual: @"ResCell"]) {
        UIView *backGraundView3 = (UIView *)[cell viewWithTag:1];
        [Common viewRoundedRect:backGraundView3 direction:4];
        UILabel *memoLabel3 = (UILabel *)[cell viewWithTag:2];
        memoLabel3.textColor = [UIColor blackColor];
        
        UILabel *nemeLabel3 = (UILabel *)[cell viewWithTag:3];
        nemeLabel3.adjustsFontSizeToFitWidth = YES;
        nemeLabel3.minimumScaleFactor = 5.f/30.f;
        UIButton *delBtn3 = (UIButton *)[cell viewWithTag:4];
        delBtn3.layer.cornerRadius = 20;
        delBtn3.clipsToBounds = true;
        UILabel *timeLabel3 = (UILabel *)[cell viewWithTag:5];
        
        memoLabel3 = [Common getLabelSize:memoLabel3 text:memoStr labelWidth:resLabelWidth margin:0];
        memoLabel3.text = [NSString stringWithFormat:@"%@",memoStr];
        [memoLabel3 sizeToFit];
        float labelHeight3 = labelH;
        if (memoLabel3.frame.size.height > labelH) {
            labelHeight3 = memoLabel3.frame.size.height;
        }
        backGraundView3.frame = CGRectMake(backGraundView3.frame.origin.x, backGraundView3.frame.origin.y, backGraundView3.frame.size.width, backGraundView3.frame.size.height+labelHeight3);
        //文字数で増えたぶんだけずらす
        nemeLabel3.transform = CGAffineTransformIdentity;
        nemeLabel3.transform = CGAffineTransformMakeTranslation(0, labelHeight3);
        
        delBtn3.transform = CGAffineTransformIdentity;
        delBtn3.transform = CGAffineTransformMakeTranslation(0, labelHeight3);
        
        timeLabel3.transform = CGAffineTransformIdentity;
        timeLabel3.transform = CGAffineTransformMakeTranslation(0, labelHeight3);
        
        nemeLabel3.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
        timeLabel3.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
        //削除ボタンが管理者か自分で書き込んだ話題、返信の場合削除ボタン表示
        if ([self.manageId isEqual: [Common getUserID]] || [[cellDic objectForKey:@"WRITEUSERID"] isEqual: [Common getUserID]]) {
            delBtn3.hidden = NO;
        }else{
            delBtn3.hidden = YES;
        }
        if (resCount == 1 && indexPath.row >= 1) {
            NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row-1];
            if([dic.allKeys containsObject:@"TOPICID"]){
                [Common viewRoundedRect:backGraundView3 direction:2];
            }
        }
        if (resCount == 2 && indexPath.row >= 2) {
            NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row-2];
            if([dic.allKeys containsObject:@"TOPICID"]){
                [Common viewRoundedRect:backGraundView3 direction:2];
            }
        }
        if (resCount == 3 && indexPath.row >= 3) {
            NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row-3];
            if([dic.allKeys containsObject:@"TOPICID"]){
                [Common viewRoundedRect:backGraundView3 direction:2];
            }
        }
    }
    if ([cell.reuseIdentifier  isEqual: @"ResImageCell"]) {
        UIView *backGraundView4 = (UIView *)[cell viewWithTag:1];
        [Common viewRoundedRect:backGraundView4 direction:4];
        UILabel *memoLabel4 = (UILabel *)[cell viewWithTag:2];
        memoLabel4.textColor = [UIColor blackColor];
        UIImageView *image4 = (UIImageView *)[cell viewWithTag:3];
        image4.contentMode = UIViewContentModeScaleAspectFit;
        UILabel *nemeLabel4 = (UILabel *)[cell viewWithTag:4];
        nemeLabel4.adjustsFontSizeToFitWidth = YES;
        nemeLabel4.minimumScaleFactor = 5.f/30.f;
        UIButton *delBtn4 = (UIButton *)[cell viewWithTag:5];
        delBtn4.layer.cornerRadius = 20;
        delBtn4.clipsToBounds = true;
        UILabel *timeLabel4 = (UILabel *)[cell viewWithTag:6];
        UIActivityIndicatorView *indicator4 = (UIActivityIndicatorView *)[cell viewWithTag:9];
        indicator4.hidesWhenStopped = YES;
        UIButton *imageBtn4 = (UIButton *)[cell viewWithTag:10];
        memoLabel4 = [Common getLabelSize:memoLabel4 text:memoStr labelWidth:resLabelWidth margin:0];
        memoLabel4.text = [NSString stringWithFormat:@"%@",memoStr];
        [memoLabel4 sizeToFit];
        float labelHeight4 = labelH;
        if (memoLabel4.frame.size.height > labelH) {
            labelHeight4 = memoLabel4.frame.size.height;
        }
        backGraundView4.frame = CGRectMake(backGraundView4.frame.origin.x, backGraundView4.frame.origin.y, backGraundView4.frame.size.width, backGraundView4.frame.size.height+labelHeight4);
        //文字数で増えたぶんだけずらす
        image4.transform = CGAffineTransformIdentity;
        image4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
        
        nemeLabel4.transform = CGAffineTransformIdentity;
        nemeLabel4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
        
        delBtn4.transform = CGAffineTransformIdentity;
        delBtn4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
        
        timeLabel4.transform = CGAffineTransformIdentity;
        timeLabel4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
        
        indicator4.transform = CGAffineTransformIdentity;
        indicator4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
        
        imageBtn4.transform = CGAffineTransformIdentity;
        imageBtn4.transform = CGAffineTransformMakeTranslation(0, labelHeight4);
        
//        [indicator4 startAnimating];
//        dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        dispatch_queue_t q_main = dispatch_get_main_queue();
//        image4.image = nil;
//        dispatch_async(q_global, ^{
//            UIImage *image = [self getImage:[cellDic objectForKey:@"IMAGEURL"]];
//            dispatch_async(q_main, ^{
//                image4.image = image;
//                [indicator4 stopAnimating];
//            });
//        });
        nemeLabel4.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
        timeLabel4.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
        //削除ボタンが管理者か自分で書き込んだ話題、返信の場合削除ボタン表示
        if ([self.manageId isEqual: [Common getUserID]] || [[cellDic objectForKey:@"WRITEUSERID"] isEqual: [Common getUserID]]) {
            delBtn4.hidden = NO;
        }else{
            delBtn4.hidden = YES;
        }
        if (resCount == 1 && indexPath.row >= 1) {
            NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row-1];
            if([dic.allKeys containsObject:@"TOPICID"]){
                [Common viewRoundedRect:backGraundView4 direction:2];
            }
        }
        if (resCount == 2 && indexPath.row >= 2) {
            NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row-2];
            if([dic.allKeys containsObject:@"TOPICID"]){
                [Common viewRoundedRect:backGraundView4 direction:2];
            }
        }
        if (resCount == 3 && indexPath.row >= 3) {
            NSDictionary *dic = [self.allChatAry objectAtIndex:indexPath.row-3];
            if([dic.allKeys containsObject:@"TOPICID"]){
                [Common viewRoundedRect:backGraundView4 direction:2];
            }
        }
    }
    if ([cell.reuseIdentifier  isEqual: @"ResLordCell"]) {
        UIView *backGraundView5 = (UIView *)[cell viewWithTag:1];
        [Common viewRoundedRect:backGraundView5 direction:2];
        UILabel *memoLabel5 = (UILabel *)[cell viewWithTag:2];
        memoLabel5.textColor = [UIColor blackColor];
        
        UILabel *nemeLabel5 = (UILabel *)[cell viewWithTag:3];
        nemeLabel5.adjustsFontSizeToFitWidth = YES;
        nemeLabel5.minimumScaleFactor = 5.f/30.f;
        UIButton *delBtn5 = (UIButton *)[cell viewWithTag:4];
        delBtn5.layer.cornerRadius = 20;
        delBtn5.clipsToBounds = true;
        UILabel *timeLabel5 = (UILabel *)[cell viewWithTag:5];
        UIButton *lordBtn5 = (UIButton *)[cell viewWithTag:6];
        
        memoLabel5 = [Common getLabelSize:memoLabel5 text:memoStr labelWidth:resLabelWidth margin:0];
        memoLabel5.text = [NSString stringWithFormat:@"%@",memoStr];
        [memoLabel5 sizeToFit];
        float labelHeight5 = labelH;
        if (memoLabel5.frame.size.height > labelH) {
            labelHeight5 = memoLabel5.frame.size.height;
        }
        backGraundView5.frame = CGRectMake(backGraundView5.frame.origin.x, backGraundView5.frame.origin.y, backGraundView5.frame.size.width, backGraundView5.frame.size.height+labelHeight5);
        
        //文字数で増えたぶんだけずらす
        nemeLabel5.transform = CGAffineTransformIdentity;
        nemeLabel5.transform = CGAffineTransformMakeTranslation(0, labelHeight5);
        
        delBtn5.transform = CGAffineTransformIdentity;
        delBtn5.transform = CGAffineTransformMakeTranslation(0, labelHeight5);
        
        timeLabel5.transform = CGAffineTransformIdentity;
        timeLabel5.transform = CGAffineTransformMakeTranslation(0, labelHeight5);
        
        lordBtn5.transform = CGAffineTransformIdentity;
        lordBtn5.transform = CGAffineTransformMakeTranslation(0, labelHeight5);
        
        nemeLabel5.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
        timeLabel5.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
        [Common viewRoundedRect:backGraundView5 direction:2];
    }
    if ([cell.reuseIdentifier  isEqual: @"ResImageLordCell"]) {
        UIView *backGraundView6 = (UIView *)[cell viewWithTag:1];
        [Common viewRoundedRect:backGraundView6 direction:2];
        UILabel *memoLabel6 = (UILabel *)[cell viewWithTag:2];
        memoLabel6.textColor = [UIColor blackColor];
        UIImageView *image6 = (UIImageView *)[cell viewWithTag:3];
        image6.contentMode = UIViewContentModeScaleAspectFit;
        UILabel *nemeLabel6 = (UILabel *)[cell viewWithTag:4];
        nemeLabel6.adjustsFontSizeToFitWidth = YES;
        nemeLabel6.minimumScaleFactor = 5.f/30.f;
        UIButton *delBtn6 = (UIButton *)[cell viewWithTag:5];
        delBtn6.layer.cornerRadius = 20;
        delBtn6.clipsToBounds = true;
        UILabel *timeLabel6 = (UILabel *)[cell viewWithTag:6];
        UIButton *lordBtn6 = (UIButton *)[cell viewWithTag:7];
        UIActivityIndicatorView *indicator6 = (UIActivityIndicatorView *)[cell viewWithTag:9];
        indicator6.hidesWhenStopped = YES;
        UIButton *imageBtn6 = (UIButton *)[cell viewWithTag:10];
        memoLabel6 = [Common getLabelSize:memoLabel6 text:memoStr labelWidth:resLabelWidth margin:0];
        memoLabel6.text = [NSString stringWithFormat:@"%@",memoStr];
        [memoLabel6 sizeToFit];
        float labelHeight6 = labelH;
        if (memoLabel6.frame.size.height > labelH) {
            labelHeight6 = memoLabel6.frame.size.height;
        }
        backGraundView6.frame = CGRectMake(backGraundView6.frame.origin.x, backGraundView6.frame.origin.y, backGraundView6.frame.size.width, backGraundView6.frame.size.height+labelHeight6);
        //文字数で増えたぶんだけずらす
        image6.transform = CGAffineTransformIdentity;
        image6.transform = CGAffineTransformMakeTranslation(0, labelHeight6);
        
        nemeLabel6.transform = CGAffineTransformIdentity;
        nemeLabel6.transform = CGAffineTransformMakeTranslation(0, labelHeight6);
        
        delBtn6.transform = CGAffineTransformIdentity;
        delBtn6.transform = CGAffineTransformMakeTranslation(0, labelHeight6);
        
        timeLabel6.transform = CGAffineTransformIdentity;
        timeLabel6.transform = CGAffineTransformMakeTranslation(0, labelHeight6);
        
        lordBtn6.transform = CGAffineTransformIdentity;
        lordBtn6.transform = CGAffineTransformMakeTranslation(0, labelHeight6);
        
        indicator6.transform = CGAffineTransformIdentity;
        indicator6.transform = CGAffineTransformMakeTranslation(0, labelHeight6);
        
        imageBtn6.transform = CGAffineTransformIdentity;
        imageBtn6.transform = CGAffineTransformMakeTranslation(0, labelHeight6);
        
//        [indicator6 startAnimating];
//        dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        dispatch_queue_t q_main = dispatch_get_main_queue();
//        image6.image = nil;
//        dispatch_async(q_global, ^{
//            UIImage *image = [self getImage:[cellDic objectForKey:@"IMAGEURL"]];
//            dispatch_async(q_main, ^{
//                image6.image = image;
//                [indicator6 stopAnimating];
//            });
//        });
        nemeLabel6.text = [NSString stringWithFormat:@"%@",[cellDic objectForKey:@"WRITEUSERNAME"]];
        timeLabel6.text = [NSString stringWithFormat:@"%@/%@/%@ %@:%@",[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(0, 4)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(4, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(6, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(8, 2)],[[cellDic objectForKey:@"WRITEDATE"] substringWithRange:NSMakeRange(10, 2)]];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.timer isValid] == YES) {
        [self.timer invalidate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.chatTableView.contentOffset.y > 0) {
         [self updateVisibleCells];
    }
}
@end
