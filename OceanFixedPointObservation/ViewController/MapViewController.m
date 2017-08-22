//
//  MapViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/17.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import "MapViewController.h"
#import "PHPConnection.h"

@interface MapViewController ()

@end

@implementation MapViewController

NSMutableArray *areaListAry;//PHPからのデータ取得
NSString *dataSetCDSer;//選択されたコードを一時保管

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = [Common getScreenSize];
    self.dialogView.frame = rect;
    self.dialogView.alpha = 0;
    
    CGRect rect2 = [Common getCenterFrameWithView:self.mainDialogView parent:self.dialogView];
    self.mainDialogView.frame = rect2;
    [self.dialogView addSubview:self.mainDialogView];
    self.dialogView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    
    
    // (1) GMSCameraPositionインスタンスの作成
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:38.364236
                                                            longitude:141.127129
                                                                 zoom:12.0];
    // (2) GMSMapViewインスタンスの作成
    self.mapView = [GMSMapView mapWithFrame:rect camera:camera];
    self.mapView.mapType = kGMSTypeNormal;
    
    // (3) myLocationEnabledプロパティ
    self.mapView.myLocationEnabled = YES;
    
    // (4) settings.myLocationButtonプロパティ
    self.mapView.settings.myLocationButton = YES;
    self.mapView.settings.compassButton = YES;
    // (5) delegateの設定
    self.mapView.delegate = self;
    
    [self.mapBaseView addSubview:self.mapView];
    
    [Common showSVProgressHUD:@""];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        areaListAry = [PHPConnection getAreaList];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self markerSet];
            [Common dismissSVProgressHUD];
        });
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)markerSet{
    for(NSDictionary *areaDic in areaListAry){
        if([areaDic objectForKey:@"LAT"] != [NSNull null]){
            CLLocationCoordinate2D position = CLLocationCoordinate2DMake([[areaDic objectForKey:@"LAT"] floatValue], [[areaDic objectForKey:@"LON"] floatValue]);
            GMSMarker *marker = [GMSMarker markerWithPosition:position];
            marker.title = [areaDic objectForKey:@"AREANM"];
            marker.snippet = @"タップしてパネルに追加して下さい";
            marker.icon = [UIImage imageNamed:@"marker0327.png"];
            marker.userData = areaDic;
            marker.map = self.mapView;
        }
    }
}
- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{
    NSMutableArray *dataSetListAry = [PHPConnection getDatasetList:[[marker.userData objectForKey:@"AREACD"] intValue]];
    if (dataSetListAry.count == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エリア選択エラー" message:@"データが存在しないか、公開されていないエリアです。" preferredStyle:UIAlertControllerStyleAlert];
        
        // addActionした順に左から右にボタンが配置されます
        [alertController addAction:[UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // otherボタンが押された時の処理
            [self cancel];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        for( NSDictionary * dic in dataSetListAry) {
            self.dialogTitleLabel.text = [dic objectForKey:@"AREANM"];
            [self.dialogSelectBtn setTitle:[NSString stringWithFormat:@"%@  %@",[dic objectForKey:@"DATATYPE"],[dic objectForKey:@"POINT"]] forState:UIControlStateNormal];
            [self.dialogSelectBtn setTitle:[NSString stringWithFormat:@"%@  %@",[dic objectForKey:@"DATATYPE"],[dic objectForKey:@"POINT"]] forState:UIControlStateHighlighted];
            dataSetCDSer = [dic objectForKey:@"DATASETCD"];
        }
        self.dialogView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        [UIView transitionWithView:self.dialogView duration:.2 options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut animations:^{
            self.dialogView.alpha = 1.0;
            self.dialogView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}
- (void)cancel{
    
}


- (IBAction)dialogSelectBtn:(id)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDataDic = [[ud objectForKey:@"UserData_Key"] mutableCopy];
    NSString *aDataSetCD = [userDataDic objectForKey:@"ADataSetCD"];
    NSString *bDataSetCD = [userDataDic objectForKey:@"BDataSetCD"];
    NSString *cDataSetCD = [userDataDic objectForKey:@"CDataSetCD"];
    if (self.panelNo == 1) {
        aDataSetCD = [NSString stringWithFormat:@"%@",dataSetCDSer];
    }
    if (self.panelNo == 2) {
        bDataSetCD = [NSString stringWithFormat:@"%@",dataSetCDSer];
    }
    if (self.panelNo == 3) {
        cDataSetCD = [NSString stringWithFormat:@"%@",dataSetCDSer];
    }
    [userDataDic setObject:[NSString stringWithFormat:@"%@",aDataSetCD] forKey:@"ADataSetCD"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",bDataSetCD] forKey:@"BDataSetCD"];
    [userDataDic setObject:[NSString stringWithFormat:@"%@",cDataSetCD] forKey:@"CDataSetCD"];
    [ud setObject:userDataDic forKey:@"UserData_Key"];
    [ud synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelBtn:(id)sender {
    [UIView transitionWithView:self.dialogView
                      duration:.3
                       options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        self.dialogView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                        self.dialogView.alpha = 0;
                    }
                    completion:^(BOOL finished) {
                    }];
}

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
