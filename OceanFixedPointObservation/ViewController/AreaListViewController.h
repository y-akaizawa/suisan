//
//  AreaListViewController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/04/28.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaListViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>
- (IBAction)backBtn:(id)sender;
@property (assign, nonatomic) int areaPanelNo;
@property (weak, nonatomic) IBOutlet UITableView *areaTableView;

@end
