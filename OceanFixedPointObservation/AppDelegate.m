//
//  AppDelegate.m
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2016/03/17.
//  Copyright (c) 2016年 YusukeAkaizawa. All rights reserved.
//

#import "AppDelegate.h"
#import "XuniCoreDynamicKit/XuniCoreDynamicKit.h"
#import "License.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //[GMSServices provideAPIKey:googleMapAPIKey];
    [XuniLicenseManager setKey:xuniLicenseKey];
    NSSetUncaughtExceptionHandler(&exceptionHandler);
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (![ud objectForKey:@"UserData_Key"]) {
        //kaki1234,andex1234
        NSMutableDictionary *userData = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         @"0", @"DataSetCD1",
                                         @"0", @"DataSetCD2",
                                         @"0", @"DataSetCD3",
                                         @"0", @"DataSetCD4",
                                         @"0", @"DataSetCD5",
                                         @"0", @"DataSetCD6",
                                         @"0", @"DataSetCD7",
                                         @"0", @"DataSetCD8",
                                         @"0", @"DataSetCD9",
                                         @"0", @"DataSetCD10",
                                         @"0", @"DataSetCD11",
                                         @"0", @"DataSetCD12",
                                         @"0", @"DataSetCD13",
                                         @"0", @"DataSetCD14",
                                         @"0", @"DataSetCD15",
                                         @"0", @"DataSetCD16",
                                         @"0", @"DataSetCD17",
                                         @"0", @"DataSetCD18",
                                         @"0", @"DataSetCD19",
                                         @"0", @"DataSetCD20",
                                         @"0", @"DataSetCD21",
                                         @"0", @"DataSetCD22",
                                         @"0", @"DataSetCD23",
                                         @"0", @"DataSetCD24",
                                         @"0", @"DataSetCD25",
                                         @"0", @"DataSetCD26",
                                         @"0", @"DataSetCD27",
                                         @"0", @"DataSetCD28",
                                         @"0", @"DataSetCD29",
                                         @"0", @"DataSetCD30",
                                         @"0", @"DataSetCD31",
                                         @"0", @"DataSetCD32",
                                         @"0", @"DataSetCD33",
                                         @"0", @"DataSetCD34",
                                         @"0", @"DataSetCD35",
                                         @"0", @"DataSetCD36",
                                         @"0", @"DataSetCD37",
                                         @"0", @"DataSetCD38",
                                         @"0", @"DataSetCD39",
                                         @"0", @"DataSetCD40",
                                         @"", @"UserId",
                                         @"", @"GroupId",
                                         @"10", @"PageCount",
                                         nil];
        [ud setObject:userData forKey:@"UserData_Key"];//ユーザーデータ保存
        [ud setObject:@"0" forKey:@"Heikin_Key"];//グラフ画面の平均値保存用
        NSMutableArray *newNotificationAry = [[NSMutableArray alloc] initWithCapacity:0];
        [ud setObject:newNotificationAry forKey:@"NewNotification_Key"];
    }
    
    // 機種の取得
    UIStoryboard *storyboard;
    // StoryBoardの名称設定用
    NSString * storyBoardName = @"";
    int scInt = [Common getScreenSizeInt];
    switch (scInt) {
        case 1:
            storyBoardName = @"Main5s";
            break;
        case 2:
            storyBoardName = @"Main6";
            break;
        case 3:
            storyBoardName = @"Main6Plus";
            break;
        default:
            storyBoardName = @"Main6";
            break;
    }
    // StoryBoardのインスタンス化
    storyboard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    
    // 画面の生成
    UIViewController *mainViewController = [storyboard instantiateInitialViewController];
    
    // ルートウィンドウにひっつける
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = mainViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cStartDate"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cEndDate"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tStartDate"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tEndDate"];
}
void exceptionHandler(NSException *exception)
{
    /*
     LOG関数は コンソールログを出力する関数 DEBUG時にとても有効です。
     別エントリーで解説します。
     */
    // 不正終了した箇所を示す スタックトレースをコンソールログに出力する
    NSLog(@"stackSymbols:%@", [exception callStackSymbols]);
}

@end
