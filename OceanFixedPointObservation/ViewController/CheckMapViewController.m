//
//  CheckMapViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/04/08.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import "CheckMapViewController.h"

@interface CheckMapViewController ()

@end

@implementation CheckMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = [Common getScreenSize];
    // (1) GMSCameraPositionインスタンスの作成
    
    float latF = 0.0f;
    float lonF = 0.0f;
    NSString *markerTitle;
    NSString *markerSnippet;
    for( NSDictionary * mapDic in self.mapAry) {
        latF = [[mapDic objectForKey:@"LAT"] floatValue];
        lonF = [[mapDic objectForKey:@"LON"] floatValue];
        markerTitle = [mapDic objectForKey:@"AREANM"];
        markerSnippet = [NSString stringWithFormat:@"%@　%@",
                         [mapDic objectForKey:@"DATATYPE"],
                         [mapDic objectForKey:@"POINT"]];;
    }
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latF
                                                            longitude:lonF
                                                                 zoom:12.0];
    // (2) GMSMapViewインスタンスの作成
    CGRect mapRect = CGRectMake(0, 64, rect.size.width, rect.size.height-64);
    self.mapView = [GMSMapView mapWithFrame:mapRect camera:camera];
    self.mapView.mapType = kGMSTypeNormal;
    
    // (3) myLocationEnabledプロパティ
    self.mapView.myLocationEnabled = YES;
    
    // (4) settings.myLocationButtonプロパティ
    self.mapView.settings.myLocationButton = YES;
    self.mapView.settings.compassButton = YES;
    // (5) delegateの設定
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latF, lonF);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = markerTitle;
    //marker.snippet = markerSnippet;
    marker.icon = [UIImage imageNamed:@"marker0327.png"];
    marker.map = self.mapView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
