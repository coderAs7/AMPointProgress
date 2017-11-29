//
//  AMPointImageView.h
//  DemoForSignIn
//
//  Created by  高东星 on 17/8/26.
//  Copyright © 2017年 anmur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMPointImageView : UIImageView
// default red
@property(nonatomic, strong) UIColor *selectedTintColor;
// default lightGray
@property(nonatomic, strong) UIColor *unSelectedTintColor;

@property (nonatomic,assign) BOOL isSelected;
@end
