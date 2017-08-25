//
//  DiaryViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2017/05/19.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import "DiaryViewController.h"
#import "DiaryInputViewController.h"

@interface DiaryViewController ()

@end

@implementation DiaryViewController
int page;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.diaryTableView.delegate = self;
    self.diaryTableView.dataSource = self;
    page = 1;
    self.leftBtn.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [self diarySet:page];
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)diarySet:(int)pageCount{
    self.diaryAry = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *page = [NSString stringWithFormat:@"%d",pageCount];
    self.diaryAry = [PHPConnection getAllDiaryData:page page1count:@"10"];
    
    if (self.diaryAry.count > 0) {
        NSString *staTime = [NSString stringWithFormat:@"%@",[[self.diaryAry objectAtIndex:0] objectForKey:@"ASSAYDATE"]];
        NSString *endTime = [NSString stringWithFormat:@"%@",[[self.diaryAry objectAtIndex:self.diaryAry.count-1] objectForKey:@"ASSAYDATE"]];
        
        self.dateLabel.text = [NSString stringWithFormat:@"%@年%@月%@日〜\n%@年%@月%@日",[endTime substringWithRange:NSMakeRange(0, 4)],[endTime substringWithRange:NSMakeRange(4, 2)],[endTime substringWithRange:NSMakeRange(6, 2)],[staTime substringWithRange:NSMakeRange(0, 4)],[staTime substringWithRange:NSMakeRange(4, 2)],[staTime substringWithRange:NSMakeRange(6, 2)]];
    }
    [self.diaryTableView reloadData];
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
    return self.diaryAry.count;
}
//セル高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dic = self.diaryAry[indexPath.row];
    UILabel *l = [[UILabel alloc] init];
    if ([[dic objectForKey:@"MEMO"]  isEqual: @""] ) {
        l.frame = CGRectMake(l.frame.origin.x, l.frame.origin.y, l.frame.size.width, l.frame.size.height+50);
    }else{
        l = [Common getLabelSize:l text:[dic objectForKey:@"MEMO"] labelWidth:325 margin:20];
    }
    //75 = ラベル以外の高さ
    return 75 + l.frame.size.height;
}
//セル内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiaryCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableDictionary *dic = self.diaryAry[indexPath.row];
    UILabel *detaLabel = (UILabel *)[cell viewWithTag:11];
    detaLabel.textColor = [UIColor whiteColor];
    detaLabel.text = [NSString stringWithFormat:@"%@年%@月%@日%@時",[[dic objectForKey:@"ASSAYDATE"] substringWithRange:NSMakeRange(0, 4)],[[dic objectForKey:@"ASSAYDATE"] substringWithRange:NSMakeRange(4, 2)],[[dic objectForKey:@"ASSAYDATE"] substringWithRange:NSMakeRange(6, 2)],[[dic objectForKey:@"ASSAYDATE"] substringWithRange:NSMakeRange(8, 2)]];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:12];
    nameLabel.textColor = [UIColor whiteColor];
    if ([[dic objectForKey:@"DATASETCD"]  isEqual: @"0"]) {
        //nameLabel.text = @"関連付けブイなし";
        nameLabel.text = @"";
    }else{
        nameLabel.text = [NSString stringWithFormat:@"%@ %@ %@",[dic objectForKey:@"AREANM"],[dic objectForKey:@"DATATYPE"],[dic objectForKey:@"POINT"]];
    }
    
    
    UILabel *memoLabel = (UILabel *)[cell viewWithTag:13];
    memoLabel.textColor = [UIColor blackColor];
    memoLabel = [Common getLabelSize:memoLabel text:[dic objectForKey:@"MEMO"] labelWidth:325 margin:20];
    memoLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MEMO"]];
    [memoLabel sizeToFit];
    
    UIView *memoView = (UIView *)[cell viewWithTag:14];
    memoView.frame = CGRectMake(memoView.frame.origin.x, memoView.frame.origin.y, memoView.frame.size.width, 85 + memoLabel.frame.size.height);
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *dic = self.diaryAry[indexPath.row];
    DiaryInputViewController *diaryInputViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DiaryInputViewController"];
    diaryInputViewController.eventId = [dic objectForKey:@"EVENTID"];
    diaryInputViewController.diaryFlag = 1;
    diaryInputViewController.eventDic = dic;
    diaryInputViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:diaryInputViewController animated:YES completion:nil];
    
}

- (IBAction)backBtn:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)addBtn:(id)sender{
    DiaryInputViewController *diaryInputViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DiaryInputViewController"];
    diaryInputViewController.diaryFlag = 0;
    diaryInputViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:diaryInputViewController animated:YES completion:nil];
}

- (IBAction)leftBtn:(id)sender {
    page--;
    self.rightBtn.hidden = NO;
    [self diarySet:page];
    if (page == 1) {
        self.leftBtn.hidden = YES;
    }
}
- (IBAction)rightBtn:(id)sender {
    page++;
    self.leftBtn.hidden = NO;
    [self diarySet:page];
    if (self.diaryAry.count < 10) {
        self.rightBtn.hidden = YES;
    }
}
@end
