//
//  CustomUIAlertController.h
//  OceanFixedPointObservation
//
//  Created by Andex_MacBook14 on 2017/06/02.
//  Copyright © 2017年 YusukeAkaizawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomUIAlertController : UIAlertController

@property (nonatomic) UIColor *messageColor;
@property (nonatomic) UIFont  *messageFont;
@property (nonatomic) NSTextAlignment messageAlign;

@property (nonatomic) UIColor *titleColor;
@property (nonatomic) UIFont  *titleFont;
@property (nonatomic) NSTextAlignment titleAlign;

@property (nonatomic) UIColor *tintColor;

@end
