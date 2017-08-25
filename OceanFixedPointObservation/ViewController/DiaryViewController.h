//
//  DiaryViewController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2017/05/19.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate>
- (IBAction)backBtn:(id)sender;
- (IBAction)addBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *diaryTableView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) NSMutableArray *diaryAry;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
- (IBAction)leftBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
- (IBAction)rightBtn:(id)sender;





@end
