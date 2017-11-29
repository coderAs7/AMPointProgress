//
//  AMProgressView.m
//  DemoForSignIn
//
//  Created by  高东星 on 17/8/26.
//  Copyright © 2017年 anmur. All rights reserved.
//

#import "AMProgressView.h"


@interface AMProgressView ()


@property (nonatomic,weak) UIView *progressView;

@end



@implementation AMProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _progressTintColor = [UIColor redColor];
        _trackTintColor = [UIColor lightGrayColor];
        
        UIView *progressView = [UIView new];
        [self addSubview:progressView];
        progressView.backgroundColor = _progressTintColor;
        _progressView = progressView;
        
        self.backgroundColor = _trackTintColor;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsLayout];
}

- (void)setProgressTintColor:(UIColor *)progressTintColor{
    _progressTintColor = progressTintColor;
    _progressView.backgroundColor = progressTintColor;
}

- (void)setTrackTintColor:(UIColor *)trackTintColor{
    _trackTintColor = trackTintColor;
    self.backgroundColor = trackTintColor;
}

-  (void)layoutSubviews{
    [super layoutSubviews];
    _progressView.frame = CGRectMake(0, 0, _progress * self.frame.size.width, self.frame.size.height);
}

@end
