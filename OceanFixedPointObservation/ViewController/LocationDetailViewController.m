//
//  LocationDetailViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/18.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import "LocationDetailViewController.h"
#import "CheckMapViewController.h"
#import "WebViewMapViewController.h"

@interface LocationDetailViewController ()

@end

@implementation LocationDetailViewController
CheckMapViewController *checkMapViewController;
WebViewMapViewController *webViewMapViewController;
NSMutableArray *detailAry;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDetail{
    [Common showSVProgressHUD:@""];
    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W6" size:15];
    CGRect rect = [Common getScreenSize];
    float screenSizeF = rect.size.height-64;
    
    //5sなどのサイズ
    if (rect.size.width == 320) {
        font = [UIFont fontWithName:@"HiraKakuProN-W6" size:12];
    }
    //6のサイズ(現状storyboardに指定しているサイズ)
    if (rect.size.width == 375) {
        
    }
    //6プラスのサイズ
    if (rect.size.width == 414) {
        font = [UIFont fontWithName:@"HiraKakuProN-W6" size:18];
    }
    UIColor *color = RGB(100, 100, 100);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        detailAry = [PHPConnection getPanelDetail:self.DataSetCD];
        dispatch_async(dispatch_get_main_queue(), ^{
            for( NSDictionary * detailDic in detailAry) {
                CGRect rect = [Common getScreenSize];
                self.barView.frame = CGRectMake(self.barView.frame.origin.x, self.barView.frame.origin.y, rect.size.width, self.barView.frame.size.height);
                self.barView.frame = CGRectMake(self.barView.frame.origin.x, self.barView.frame.origin.y, rect.size.width, self.barView.frame.size.height);
                self.barTitleLabel.text = [detailDic objectForKey:@"AREANM"];
                self.barTitleLabel = [Common getMoziSizeSetting:self.barTitleLabel];
                
                UIScrollView *detailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y+64, rect.size.width, rect.size.height-64)];
                detailScrollView.backgroundColor = [UIColor clearColor];
                detailScrollView.pagingEnabled = NO;
                detailScrollView.showsHorizontalScrollIndicator = NO;
                detailScrollView.showsVerticalScrollIndicator = YES;
                detailScrollView.scrollsToTop = YES;
                detailScrollView.delegate = self;
                [self.view addSubview:detailScrollView];
                
                float objectAllHeight = 0;//全パーツの合計の高さ
                float titleLabelHeight = 25;//項目ラベルの高さ
                //種別
                UILabel *itemLabel1 = [[UILabel alloc] init];
                itemLabel1.frame = CGRectMake(0, objectAllHeight, rect.size.width, titleLabelHeight);
                itemLabel1.backgroundColor = [UIColor lightGrayColor];
                itemLabel1.font = font;
                itemLabel1.text = @"　種別";
                [detailScrollView addSubview:itemLabel1];
                objectAllHeight += itemLabel1.frame.size.height;
                
                UILabel *itemLabel2 = [[UILabel alloc] init];
                itemLabel2.frame = CGRectMake(0, objectAllHeight, rect.size.width, 45);
                itemLabel2.backgroundColor = [UIColor whiteColor];
                itemLabel2.textColor = color;
                itemLabel2.font = font;
                itemLabel2.text = [NSString stringWithFormat:@"　%@　%@",[detailDic objectForKey:@"DATATYPE"],[detailDic objectForKey:@"POINT"]];
                [detailScrollView addSubview:itemLabel2];
                objectAllHeight += itemLabel2.frame.size.height;
                
                //電池残量
                UILabel *itemLabel3 = [[UILabel alloc] init];
                itemLabel3.frame = CGRectMake(0, objectAllHeight, rect.size.width, titleLabelHeight);
                itemLabel3.backgroundColor = [UIColor lightGrayColor];
                itemLabel3.font = font;
                itemLabel3.text = @"　電池残量";
                [detailScrollView addSubview:itemLabel3];
                objectAllHeight += itemLabel3.frame.size.height;
                
                UILabel *itemLabel4 = [[UILabel alloc] init];
                itemLabel4.frame = CGRectMake(0, objectAllHeight, rect.size.width, 45);
                itemLabel4.backgroundColor = [UIColor whiteColor];
                itemLabel4.textColor = color;
                itemLabel4.font = font;
                NSString *voltDate = [detailDic objectForKey:@"VOLTDATE"];
                itemLabel4.text = [NSString stringWithFormat:@"　%@V　(%@年 %@月 %@日 %@時 時点)",
                                   [detailDic objectForKey:@"VOLT"],
                                   [voltDate substringWithRange:NSMakeRange(0, 4)],
                                   [voltDate substringWithRange:NSMakeRange(4, 2)],
                                   [voltDate substringWithRange:NSMakeRange(6, 2)],
                                   [voltDate substringWithRange:NSMakeRange(8, 2)]];
                [detailScrollView addSubview:itemLabel4];
                objectAllHeight += itemLabel4.frame.size.height;
                
                //位置
                UILabel *itemLabel5 = [[UILabel alloc] init];
                itemLabel5.frame = CGRectMake(0, objectAllHeight, rect.size.width, titleLabelHeight);
                itemLabel5.backgroundColor = [UIColor lightGrayColor];
                itemLabel5.font = font;
                itemLabel5.text = @"　位置";
                [detailScrollView addSubview:itemLabel5];
                objectAllHeight += itemLabel5.frame.size.height;
                
                UILabel *itemLabel6 = [[UILabel alloc] init];
                itemLabel6.backgroundColor = [UIColor whiteColor];
                itemLabel6.textColor = color;
                itemLabel6.font = font;
                
                NSString *latLonDate = [detailDic objectForKey:@"LATLONDATE"];
                NSString *latLonText = [NSString stringWithFormat:@"　緯度：%@　\n　軽度：%@　\n　(%@年 %@月 %@日 %@時 時点)",
                                        [detailDic objectForKey:@"LAT"],
                                        [detailDic objectForKey:@"LON"],
                                        [latLonDate substringWithRange:NSMakeRange(0, 4)],
                                        [latLonDate substringWithRange:NSMakeRange(4, 2)],
                                        [latLonDate substringWithRange:NSMakeRange(6, 2)],
                                        [latLonDate substringWithRange:NSMakeRange(8, 2)]];
                itemLabel6 = [Common getLabelSize:itemLabel6 text:latLonText labelWidth:rect.size.width margin:20];
                itemLabel6.frame = CGRectMake(0, objectAllHeight, itemLabel6.frame.size.width, itemLabel6.frame.size.height);
                [detailScrollView addSubview:itemLabel6];
                
                UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [button1 setTitle:@"地図で表示" forState:UIControlStateNormal];
                [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button1 setBackgroundColor:RGB(4, 123, 239)];
                [button1 sizeToFit];
                button1.layer.masksToBounds = NO;
                button1.layer.cornerRadius = 5.0f;
                button1.frame = CGRectMake(rect.size.width-110, objectAllHeight+10,100,itemLabel6.frame.size.height-20);
                [button1 addTarget:self action:@selector(mapBtnDidPush) forControlEvents:UIControlEventTouchUpInside];
                [detailScrollView addSubview:button1];
                
                objectAllHeight += itemLabel6.frame.size.height;
                
                //関連画像
                UILabel *itemLabel7 = [[UILabel alloc] init];
                itemLabel7.frame = CGRectMake(0, objectAllHeight, rect.size.width, titleLabelHeight);
                itemLabel7.backgroundColor = [UIColor lightGrayColor];
                itemLabel7.font = [UIFont systemFontOfSize:15];
                itemLabel7.text = @"　関連画像";
                [detailScrollView addSubview:itemLabel7];
                objectAllHeight += itemLabel7.frame.size.height;
                
                if ([detailDic objectForKey:@"IMGURL"] == [NSNull null]) {
                    UIImageView *eventImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, objectAllHeight+5, rect.size.width-20, 200)];
                    eventImageView.contentMode = UIViewContentModeScaleAspectFit;
                    eventImageView.image = [UIImage imageNamed:@"noimage.png"];
                    [detailScrollView addSubview:eventImageView];
                    objectAllHeight += 210;
                }else{
                    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                    indicator.frame = CGRectMake(rect.size.width/2-indicator.frame.size.width/2, (objectAllHeight+10)+(100-indicator.frame.size.width/2), indicator.frame.size.width, indicator.frame.size.height);
                    [detailScrollView addSubview:indicator];
                    indicator.hidesWhenStopped = YES;
                    [indicator startAnimating];
                    UIImageView *eventImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, objectAllHeight, rect.size.width, indicator.frame.size.height)];
                    eventImageView.contentMode = UIViewContentModeScaleAspectFit;
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        UIImage *eventImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: [detailDic objectForKey:@"IMGURL"]]]];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            eventImageView.frame = CGRectMake(10, objectAllHeight+5, rect.size.width-20, 200);
                            eventImageView.image = eventImage;
                            [detailScrollView addSubview:eventImageView];
                            [indicator stopAnimating];
                        });
                    });
                    objectAllHeight += 210;
                }
                
                //説明
                UILabel *itemLabel8 = [[UILabel alloc] init];
                itemLabel8.frame = CGRectMake(0, objectAllHeight, rect.size.width, titleLabelHeight);
                itemLabel8.backgroundColor = [UIColor lightGrayColor];
                itemLabel8.font = font;
                itemLabel8.text = @"　説明";
                [detailScrollView addSubview:itemLabel8];
                objectAllHeight += itemLabel8.frame.size.height;
                
                UILabel *itemLabel9 = [[UILabel alloc] init];
                itemLabel9.backgroundColor = [UIColor whiteColor];
                itemLabel9.textColor = color;
                itemLabel9.font = font;
                
                NSString *memo;
                if ([detailDic objectForKey:@"MEMO"] == [NSNull null]) {
                    memo = @"(未設定)";
                }else{
                    memo = [detailDic objectForKey:@"MEMO"];
                }
                itemLabel9 = [Common getLabelSize:itemLabel9 text:memo labelWidth:rect.size.width margin:10];
                itemLabel9.frame = CGRectMake(15, objectAllHeight, itemLabel9.frame.size.width-30, itemLabel9.frame.size.height);
                [detailScrollView addSubview:itemLabel9];
                objectAllHeight += itemLabel9.frame.size.height;
                
                CGRect btnRect;
                if (rect.size.width == 414) {
                    btnRect = CGRectMake(10, screenSizeF-60, rect.size.width-20,50);
                }else{
                    btnRect = CGRectMake(10, objectAllHeight+10, rect.size.width-20,50);
                }
                
                UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [button2 setTitle:@"トップページから削除する" forState:UIControlStateNormal];
                [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button2 setBackgroundColor:RGB(4, 123, 239)];
                [button2 sizeToFit];
                button2.layer.masksToBounds = NO;
                button2.layer.cornerRadius = 5.0f;
                button2.frame = btnRect;
                [button2 addTarget:self action:@selector(deleteBtnDidPush) forControlEvents:UIControlEventTouchUpInside];
                [detailScrollView addSubview:button2];
                
                objectAllHeight += 70;
                
                if (screenSizeF > objectAllHeight+50) {
                    detailScrollView.contentSize = CGSizeMake(rect.size.width, screenSizeF);
                }else{
                    detailScrollView.contentSize = CGSizeMake(rect.size.width, objectAllHeight);
                }
            }
            [Common dismissSVProgressHUD];
        });
    });
}

- (void)mapBtnDidPush{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"確認" message:@"外部ページで表示します。\nよろしいですか？" preferredStyle:UIAlertControllerStyleAlert];
    
    // addActionした順に左から右にボタンが配置されます
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // otherボタンが押された時の処理
        [self otherButtonPushed];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"キャンセル" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // cancelボタンが押された時の処理
        [self cancelButtonPushed];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)deleteBtnDidPush{
    //トップ画面から削除
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDataDic = [[ud objectForKey:@"UserData_Key"] mutableCopy];
    NSString *DataSetCD1 = [userDataDic objectForKey:@"DataSetCD1"];
    NSString *DataSetCD2 = [userDataDic objectForKey:@"DataSetCD2"];
    NSString *DataSetCD3 = [userDataDic objectForKey:@"DataSetCD3"];
    NSString *DataSetCD4 = [userDataDic objectForKey:@"DataSetCD4"];
    NSString *DataSetCD5 = [userDataDic objectForKey:@"DataSetCD5"];
    NSString *DataSetCD6 = [userDataDic objectForKey:@"DataSetCD6"];
    NSString *DataSetCD7 = [userDataDic objectForKey:@"DataSetCD7"];
    NSString *DataSetCD8 = [userDataDic objectForKey:@"DataSetCD8"];
    NSString *DataSetCD9 = [userDataDic objectForKey:@"DataSetCD9"];
    NSString *DataSetCD10 = [userDataDic objectForKey:@"DataSetCD10"];
    NSString *DataSetCD11 = [userDataDic objectForKey:@"DataSetCD11"];
    NSString *DataSetCD12 = [userDataDic objectForKey:@"DataSetCD12"];
    NSString *DataSetCD13 = [userDataDic objectForKey:@"DataSetCD13"];
    NSString *DataSetCD14 = [userDataDic objectForKey:@"DataSetCD14"];
    NSString *DataSetCD15 = [userDataDic objectForKey:@"DataSetCD15"];
    NSString *DataSetCD16 = [userDataDic objectForKey:@"DataSetCD16"];
    NSString *DataSetCD17 = [userDataDic objectForKey:@"DataSetCD17"];
    NSString *DataSetCD18 = [userDataDic objectForKey:@"DataSetCD18"];
    NSString *DataSetCD19 = [userDataDic objectForKey:@"DataSetCD19"];
    NSString *DataSetCD20 = [userDataDic objectForKey:@"DataSetCD20"];
    NSString *DataSetCD21 = [userDataDic objectForKey:@"DataSetCD21"];
    NSString *DataSetCD22 = [userDataDic objectForKey:@"DataSetCD22"];
    NSString *DataSetCD23 = [userDataDic objectForKey:@"DataSetCD23"];
    NSString *DataSetCD24 = [userDataDic objectForKey:@"DataSetCD24"];
    NSString *DataSetCD25 = [userDataDic objectForKey:@"DataSetCD25"];
    NSString *DataSetCD26 = [userDataDic objectForKey:@"DataSetCD26"];
    NSString *DataSetCD27 = [userDataDic objectForKey:@"DataSetCD27"];
    NSString *DataSetCD28 = [userDataDic objectForKey:@"DataSetCD28"];
    NSString *DataSetCD29 = [userDataDic objectForKey:@"DataSetCD29"];
    NSString *DataSetCD30 = [userDataDic objectForKey:@"DataSetCD30"];
    NSString *DataSetCD31 = [userDataDic objectForKey:@"DataSetCD31"];
    NSString *DataSetCD32 = [userDataDic objectForKey:@"DataSetCD32"];
    NSString *DataSetCD33 = [userDataDic objectForKey:@"DataSetCD33"];
    NSString *DataSetCD34 = [userDataDic objectForKey:@"DataSetCD34"];
    NSString *DataSetCD35 = [userDataDic objectForKey:@"DataSetCD35"];
    NSString *DataSetCD36 = [userDataDic objectForKey:@"DataSetCD36"];
    NSString *DataSetCD37 = [userDataDic objectForKey:@"DataSetCD37"];
    NSString *DataSetCD38 = [userDataDic objectForKey:@"DataSetCD38"];
    NSString *DataSetCD39 = [userDataDic objectForKey:@"DataSetCD39"];
    NSString *DataSetCD40 = [userDataDic objectForKey:@"DataSetCD40"];
    int panelN = [self.panelNo intValue];
    switch (panelN) {
        case 1:
            DataSetCD1 = @"0";
            break;
        case 2:
            DataSetCD2 = @"0";
            break;
        case 3:
            DataSetCD3 = @"0";
            break;
        case 4:
            DataSetCD4 = @"0";
            break;
        case 5:
            DataSetCD5 = @"0";
            break;
        case 6:
            DataSetCD6 = @"0";
            break;
        case 7:
            DataSetCD7 = @"0";
            break;
        case 8:
            DataSetCD8 = @"0";
            break;
        case 9:
            DataSetCD9 = @"0";
            break;
        case 10:
            DataSetCD10 = @"0";
            break;
        case 11:
            DataSetCD11 = @"0";
            break;
        case 12:
            DataSetCD12 = @"0";
            break;
        case 13:
            DataSetCD13 = @"0";
            break;
        case 14:
            DataSetCD14 = @"0";
            break;
        case 15:
            DataSetCD15 = @"0";
            break;
        case 16:
            DataSetCD16 = @"0";
            break;
        case 17:
            DataSetCD17 = @"0";
            break;
        case 18:
            DataSetCD18 = @"0";
            break;
        case 19:
            DataSetCD19 = @"0";
            break;
        case 20:
            DataSetCD20 = @"0";
            break;
        case 21:
            DataSetCD21 = @"0";
            break;
        case 22:
            DataSetCD22 = @"0";
            break;
        case 23:
            DataSetCD23 = @"0";
            break;
        case 24:
            DataSetCD24 = @"0";
            break;
        case 25:
            DataSetCD25 = @"0";
            break;
        case 26:
            DataSetCD26 = @"0";
            break;
        case 27:
            DataSetCD27 = @"0";
            break;
        case 28:
            DataSetCD28 = @"0";
            break;
        case 29:
            DataSetCD29 = @"0";
            break;
        case 30:
            DataSetCD30 = @"0";
            break;
        case 31:
            DataSetCD31 = @"0";
            break;
        case 32:
            DataSetCD32 = @"0";
            break;
        case 33:
            DataSetCD33 = @"0";
            break;
        case 34:
            DataSetCD34 = @"0";
            break;
        case 35:
            DataSetCD35 = @"0";
            break;
        case 36:
            DataSetCD36 = @"0";
            break;
        case 37:
            DataSetCD37 = @"0";
            break;
        case 38:
            DataSetCD38 = @"0";
            break;
        case 39:
            DataSetCD39 = @"0";
            break;
        case 40:
            DataSetCD40 = @"0";
            break;
            
        default:
            break;
    }
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD1] forKey:@"DataSetCD1"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD2] forKey:@"DataSetCD2"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD3] forKey:@"DataSetCD3"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD4] forKey:@"DataSetCD4"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD5] forKey:@"DataSetCD5"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD6] forKey:@"DataSetCD6"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD7] forKey:@"DataSetCD7"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD8] forKey:@"DataSetCD8"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD9] forKey:@"DataSetCD9"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD10] forKey:@"DataSetCD10"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD11] forKey:@"DataSetCD11"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD12] forKey:@"DataSetCD12"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD13] forKey:@"DataSetCD13"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD14] forKey:@"DataSetCD14"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD15] forKey:@"DataSetCD15"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD16] forKey:@"DataSetCD16"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD17] forKey:@"DataSetCD17"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD18] forKey:@"DataSetCD18"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD19] forKey:@"DataSetCD19"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD20] forKey:@"DataSetCD20"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD21] forKey:@"DataSetCD21"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD22] forKey:@"DataSetCD22"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD23] forKey:@"DataSetCD23"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD24] forKey:@"DataSetCD24"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD25] forKey:@"DataSetCD25"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD26] forKey:@"DataSetCD26"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD27] forKey:@"DataSetCD27"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD28] forKey:@"DataSetCD28"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD29] forKey:@"DataSetCD29"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD30] forKey:@"DataSetCD30"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD31] forKey:@"DataSetCD31"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD32] forKey:@"DataSetCD32"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD33] forKey:@"DataSetCD33"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD34] forKey:@"DataSetCD34"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD35] forKey:@"DataSetCD35"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD36] forKey:@"DataSetCD36"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD37] forKey:@"DataSetCD37"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD38] forKey:@"DataSetCD38"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD39] forKey:@"DataSetCD39"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",DataSetCD40] forKey:@"DataSetCD40"];
    [ud setObject:userDataDic forKey:@"UserData_Key"];
    [ud synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelButtonPushed{
    
}
- (void)otherButtonPushed{
    NSString* urlString;
    for( NSDictionary * mapDic in detailAry) {
        urlString = [NSString stringWithFormat:@"http://api.suisaniot.net/suisaniot/v2/map/map.php?lat=%@&lon=%@",[mapDic objectForKey:@"LAT"],[mapDic objectForKey:@"LON"]];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
