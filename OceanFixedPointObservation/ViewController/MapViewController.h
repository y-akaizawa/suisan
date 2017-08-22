//
//  MapViewController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/17.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <MapKit/MapKit.h>

//GoogleAPI認証キー
//AIzaSyDDtD8of6ManRhhQXVncpEP24GoJ1FkEOU

@interface MapViewController : UIViewController
<
GMSMapViewDelegate,
CLLocationManagerDelegate,
UIGestureRecognizerDelegate
>

@property (assign, nonatomic) int panelNo;

@property (strong, nonatomic) GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *mapBaseView;
@property (weak, nonatomic) IBOutlet UIView *dialogView;
@property (weak, nonatomic) IBOutlet UIView *mainDialogView;
@property (weak, nonatomic) IBOutlet UILabel *dialogTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *dialogSelectBtn;
- (IBAction)dialogSelectBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;

- (IBAction)backBtn:(id)sender;

@end
