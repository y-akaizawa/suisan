//
//  LocationDetailViewController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/18.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocationDetailViewController : UIViewController
<UIScrollViewDelegate>
@property (assign, nonatomic) NSString *DataSetCD;
@property (assign, nonatomic) NSString *panelNo;
@property (weak, nonatomic) IBOutlet UIView *barView;
@property (weak, nonatomic) IBOutlet UILabel *barTitleLabel;

- (IBAction)backBtn:(id)sender;

@end
