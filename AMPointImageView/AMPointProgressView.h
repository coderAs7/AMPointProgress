//
//  AMPointProgressView.h
//  DemoForSignIn
//
//  Created by  高东星 on 17/8/25.
//  Copyright © 2017年 anmur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMPointProgressView : UIView
// integer number array
@property (nonatomic,strong) NSArray *pointArray;
// default (10,10)
@property (nonatomic,assign) CGSize pointImageViewSize;
// default 3
@property (nonatomic,assign) CGFloat lineProgressViewHeight;
// default red
@property(nonatomic, strong) UIColor *pointTintColor;
// default lightGray
@property(nonatomic, strong) UIColor *trackTintColor;
@property (nonatomic,assign) NSInteger point;
// 0 ~ 0.5
// default 0.12
@property (nonatomic,assign) CGFloat startDisplayPointLoation;

// default 0;
@property (nonatomic,assign) NSInteger startPoint;
// default 100;
@property (nonatomic,assign) NSInteger endPoint;
@end
