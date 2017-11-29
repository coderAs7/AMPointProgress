//
//  AMProgressView.h
//  DemoForSignIn
//
//  Created by  高东星 on 17/8/26.
//  Copyright © 2017年 anmur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMProgressView : UIView
// default red
@property(nonatomic, strong) UIColor *progressTintColor;
// default lightGray
@property(nonatomic, strong) UIColor *trackTintColor;
@property (nonatomic,assign) CGFloat progress;
@end
