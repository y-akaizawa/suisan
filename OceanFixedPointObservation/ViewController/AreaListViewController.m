//
//  AreaListViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/04/28.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import "AreaListViewController.h"
#import "WebViewMapViewController.h"
#import "GetArrayObject.h"

@interface AreaListViewController ()

@end

@implementation AreaListViewController
WebViewMapViewController *webViewMapViewCon;
NSMutableArray *allAreaAry;
NSMutableArray *areaCDAry;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.areaTableView.delegate = self;
    self.areaTableView.dataSource = self;
    allAreaAry = [PHPConnection getDatasetList2:0];
    NSLog(@"areaDateAry = %@",allAreaAry);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    return allAreaAry.count;
}
//セル高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
//セル内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *areaDic = [allAreaAry objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AreaCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    cellLabel = [Common getMoziSizeSetting:cellLabel];
    UILabel *cellLabel2 = (UILabel *)[cell viewWithTag:4];
    cellLabel2 = [Common getMoziSizeSetting:cellLabel2];
    UIButton *cellBtn = (UIButton *)[cell viewWithTag:2];
    cellBtn.backgroundColor = [UIColor clearColor];
//    cellBtn.layer.borderWidth = 1.0f;
//    cellBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    cellBtn.layer.cornerRadius = 5.0f;
    UIButton *addBtn = (UIButton *)[cell viewWithTag:3];
//    addBtn.backgroundColor = [UIColor clearColor];
//    addBtn.layer.borderWidth = 1.0f;
//    addBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    addBtn.layer.cornerRadius = 5.0f;
    cellLabel.text = [NSString stringWithFormat:@"%@ %@ %@",[areaDic objectForKey:@"AREANM"],[areaDic objectForKey:@"DATATYPE"],[areaDic objectForKey:@"POINT"]];
    cellLabel2.text = [NSString stringWithFormat:@"最終データ更新：%@",[areaDic objectForKey:@"LASTUPD"]];
    [cellBtn addTarget:self action:@selector(mapBtnDidPush:event:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn addTarget:self action:@selector(addBtnDidPush:event:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)mapBtnDidPush:(id)sender event:(UIEvent *)event{
    // 押されたボタンのセルのインデックスを取得
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self.areaTableView];
    NSIndexPath *indexPath = [self.areaTableView indexPathForRowAtPoint:point];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"確認" message:@"外部ページに移動します。\nよろしいですか？" preferredStyle:UIAlertControllerStyleAlert];
    
    // addActionした順に左から右にボタンが配置されます
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // otherボタンが押された時の処理
        [self otherButtonPushed:indexPath];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"キャンセル" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // cancelボタンが押された時の処理
        [self cancelButtonPushed];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
//
//    areaCDAry = [PHPConnection getPanelDetail:[selectAreaPlaceDateAry objectAtIndex:indexPath.row]];
//    webViewMapViewCon = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewMapViewController"];
//    webViewMapViewCon.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    webViewMapViewCon.webMapAry = areaCDAry;
//    [self presentViewController:webViewMapViewCon animated:YES completion:nil];
    
}

- (void)addBtnDidPush:(id)sender event:(UIEvent *)event{
    // 押されたボタンのセルのインデックスを取得
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self.areaTableView];
    NSIndexPath *indexPath = [self.areaTableView indexPathForRowAtPoint:point];
    NSMutableDictionary *areaDic = [allAreaAry objectAtIndex:indexPath.row];
    // cellがタップされた際の処理
    NSString *areaCD = [areaDic objectForKey:@"DATASETCD"];
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
    
    switch (self.areaPanelNo) {
        case 1:
            DataSetCD1 = areaCD;
            break;
        case 2:
            DataSetCD2 = areaCD;
            break;
        case 3:
            DataSetCD3 = areaCD;
            break;
        case 4:
            DataSetCD4 = areaCD;
            break;
        case 5:
            DataSetCD5 = areaCD;
            break;
        case 6:
            DataSetCD6 = areaCD;
            break;
        case 7:
            DataSetCD7 = areaCD;
            break;
        case 8:
            DataSetCD8 = areaCD;
            break;
        case 9:
            DataSetCD9 = areaCD;
            break;
        case 10:
            DataSetCD10 = areaCD;
            break;
        case 11:
            DataSetCD11 = areaCD;
            break;
        case 12:
            DataSetCD12 = areaCD;
            break;
        case 13:
            DataSetCD13 = areaCD;
            break;
        case 14:
            DataSetCD14 = areaCD;
            break;
        case 15:
            DataSetCD15 = areaCD;
            break;
        case 16:
            DataSetCD16 = areaCD;
            break;
        case 17:
            DataSetCD17 = areaCD;
            break;
        case 18:
            DataSetCD18 = areaCD;
            break;
        case 19:
            DataSetCD19 = areaCD;
            break;
        case 20:
            DataSetCD20 = areaCD;
            break;
        case 21:
            DataSetCD21 = areaCD;
            break;
        case 22:
            DataSetCD22 = areaCD;
            break;
        case 23:
            DataSetCD23 = areaCD;
            break;
        case 24:
            DataSetCD24 = areaCD;
            break;
        case 25:
            DataSetCD25 = areaCD;
            break;
        case 26:
            DataSetCD26 = areaCD;
            break;
        case 27:
            DataSetCD27 = areaCD;
            break;
        case 28:
            DataSetCD28 = areaCD;
            break;
        case 29:
            DataSetCD29 = areaCD;
            break;
        case 30:
            DataSetCD30 = areaCD;
            break;
        case 31:
            DataSetCD31 = areaCD;
            break;
        case 32:
            DataSetCD32 = areaCD;
            break;
        case 33:
            DataSetCD33 = areaCD;
            break;
        case 34:
            DataSetCD34 = areaCD;
            break;
        case 35:
            DataSetCD35 = areaCD;
            break;
        case 36:
            DataSetCD36 = areaCD;
            break;
        case 37:
            DataSetCD37 = areaCD;
            break;
        case 38:
            DataSetCD38 = areaCD;
            break;
        case 39:
            DataSetCD39 = areaCD;
            break;
        case 40:
            DataSetCD40 = areaCD;
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
    NSLog(@"UserData_Key = %@",[ud objectForKey:@"UserData_Key"]);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelButtonPushed{

}
- (void)otherButtonPushed:(NSIndexPath *)indexP{
    NSMutableDictionary *areaDic = [allAreaAry objectAtIndex:indexP.row];
    NSString *areaCD = [areaDic objectForKey:@"DATASETCD"];
    NSString* urlString;
    areaCDAry = [PHPConnection getPanelDetail:areaCD];
    for( NSDictionary * mapDic in areaCDAry) {
        urlString = [NSString stringWithFormat:@"http://api.suisaniot.net/suisaniot/v2/map/map.php?lat=%@&lon=%@",[mapDic objectForKey:@"LAT"],[mapDic objectForKey:@"LON"]];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}
- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
