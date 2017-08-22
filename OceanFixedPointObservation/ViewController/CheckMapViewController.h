//
//  CheckMapViewController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/04/08.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <MapKit/MapKit.h>

@interface CheckMapViewController : UIViewController
<
GMSMapViewDelegate,
CLLocationManagerDelegate,
UIGestureRecognizerDelegate
>
@property (strong, nonatomic) GMSMapView *mapView;
@property (assign, nonatomic) NSMutableArray *mapAry;
- (IBAction)backBtn:(id)sender;
@end
