//
//  ThreadViewController.h
//  testChat
//
//  Created by Andex_MacBook14 on 2017/04/26.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreadViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
- (IBAction)backBtn:(id)sender;
- (IBAction)addBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *RoomTableView;
@property (strong, nonatomic) NSMutableArray *threadListAry;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end
