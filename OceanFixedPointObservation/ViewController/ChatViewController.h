//
//  ChatViewController.h
//  testChat
//
//  Created by Andex_MacBook14 on 2017/04/26.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *allUserBtn;
- (IBAction)allUserBtn:(id)sender;

@property (strong, nonatomic) NSString *roomName;
@property (strong, nonatomic) NSString *adminName;
@property (strong, nonatomic) NSString *threadId;
@property (strong, nonatomic) NSString *manageId;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (strong, nonatomic) NSMutableArray *allChatAry;
@property (strong, nonatomic) NSMutableArray *chatAry;
@property (strong, nonatomic) NSMutableArray *chatResAry;
@property (weak, nonatomic) IBOutlet UILabel *roomTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *postBtn;
- (IBAction)postBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *dialogBaseView;
@property (weak, nonatomic) IBOutlet UIView *dialogMainView;
@property (weak, nonatomic) IBOutlet UILabel *dialogTitleView;
@property (weak, nonatomic) IBOutlet UITextView *dialogTextView;
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;
- (IBAction)cameraBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *albumBtn;
- (IBAction)albumBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
- (IBAction)okBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
- (IBAction)cancelBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *preImageView;
@property (weak, nonatomic) IBOutlet UILabel *adminNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *accessLabel;


@property (strong, nonatomic) NSTimer *timer;//テーブル表示用タイマー
@end
