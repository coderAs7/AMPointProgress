//
//  AMPointImageView.m
//  DemoForSignIn
//
//  Created by  高东星 on 17/8/26.
//  Copyright © 2017年 anmur. All rights reserved.
//

#import "AMPointImageView.h"

@implementation AMPointImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if (_isSelected) {
        self.backgroundColor = _selectedTintColor;
    }else{
        self.backgroundColor = _unSelectedTintColor;
    }
}

- (void)setSelectedTintColor:(UIColor *)selectedTintColor{
    _selectedTintColor = selectedTintColor;
    self.isSelected = _isSelected;
}
- (void)setUnSelectedTintColor:(UIColor *)unSelectedTintColor{
    _unSelectedTintColor = unSelectedTintColor;
    self.isSelected = _isSelected;
}

@end
