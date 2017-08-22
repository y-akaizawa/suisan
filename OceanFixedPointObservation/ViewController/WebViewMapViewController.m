//
//  WebViewMapViewController.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/04/27.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import "WebViewMapViewController.h"

@interface WebViewMapViewController ()

@end

@implementation WebViewMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    NSString* urlString;
    for( NSDictionary * mapDic in self.webMapAry) {
        self.titleLabel.text = [mapDic objectForKey:@"AREANM"];
        urlString = [NSString stringWithFormat:@"http://maps.google.co.jp/maps?ll=%@,%@&q=%@,%@&iwloc=J&z=13",[mapDic objectForKey:@"LAT"],[mapDic objectForKey:@"LON"],[mapDic objectForKey:@"LAT"],[mapDic objectForKey:@"LON"]];
    }
    
    // これを使って、URLオブジェクトをつくります
    NSURL* googleURL = [NSURL URLWithString: urlString];
    NSURLRequest* myRequest = [NSURLRequest requestWithURL: googleURL];
    [self.webView loadRequest:myRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)wView {
    [Common showSVProgressHUD:@""];
}
- (void)webViewDidFinishLoad:(UIWebView *)wView {
    // 全リクエスト終了
    if (wView.loading == NO) {
        [Common dismissSVProgressHUD];
    }
}
- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
