//
//  SekisanView.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/06/27.
//  Copyright © 2016年 YusukeAkaizawa. All rights reserved.
//

#import "SekisanView.h"
#import "MainViewController.h"

@implementation SekisanView
- (void)_init
{
    // initialize
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 初期設定など
}

+ (instancetype)SekisanView
{
    NSString * storyBoardName = @"";
    int scInt = [Common getScreenSizeInt];
    switch (scInt) {
        case 1:
            storyBoardName = @"SekisanView5s";
            break;
        case 2:
            storyBoardName = @"SekisanView6";
            break;
        case 3:
            storyBoardName = @"SekisanView6Plus";
            break;
        default:
            storyBoardName = @"SekisanView6";
            break;
    }
    
    // xib ファイルから MyView のインスタンスを得る
    UINib *nib = [UINib nibWithNibName:storyBoardName bundle:nil];
    SekisanView *view = [nib instantiateWithOwner:self options:nil][0];
    return view;
}

- (IBAction)mapBtn1:(id)sender{
    [self.mainViewController goList:1];
}

- (IBAction)mapBtn2:(id)sender{
    [self.mainViewController goList:2];
}

- (IBAction)mapBtn3:(id)sender{
    [self.mainViewController goList:3];
}

- (IBAction)mapBtn4:(id)sender{
    [self.mainViewController goList:4];
}

@end
