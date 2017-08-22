//
//  WebViewMapViewController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/04/27.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewMapViewController : UIViewController
<UIWebViewDelegate>
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (assign, nonatomic) NSMutableArray *webMapAry;
@end
