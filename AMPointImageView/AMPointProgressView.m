//
//  AMPointProgressView.m
//  DemoForSignIn
//
//  Created by  高东星 on 17/8/25.
//  Copyright © 2017年 anmur. All rights reserved.
//

#import "AMPointProgressView.h"
#import "AMProgressView.h"
#import "AMPointImageView.h"

#define DEFAULT_TRACKTINTCOLOR [UIColor lightGrayColor]
#define DEFAULT_PROGRESSTINTCOLOR [UIColor redColor]

@interface  AMPointProgressView()
@property (nonatomic,weak) AMProgressView *progressView;
@property (nonatomic,strong) NSMutableArray *pointImageViewArray;
@end


@implementation AMPointProgressView


#pragma mark - lifeCycle

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _startPoint = 0;
        _endPoint = 100;
        _pointImageViewSize = CGSizeMake(10, 10);
        _lineProgressViewHeight = 3;
        _trackTintColor = DEFAULT_TRACKTINTCOLOR;
        _pointTintColor = DEFAULT_PROGRESSTINTCOLOR;
        _startDisplayPointLoation = 0.12;
        [self addProgressView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // progressView居中
    _progressView.frame = CGRectMake(0, 0, self.frame.size.width, _lineProgressViewHeight);
    CGPoint center = _progressView.center;
    center.y = self.frame.size.height * 0.5;
    _progressView.center = center;
    
    NSInteger count = self.pointImageViewArray.count;
    CGFloat startDisplayPointLoationX = self.frame.size.width * _startDisplayPointLoation;
    CGFloat disPlayWidth = self.frame.size.width - 2 * startDisplayPointLoationX;
    NSInteger margin = disPlayWidth / (count - 1);
    
    for (NSInteger i = 0; i < count; i ++) {
        UIImageView *pointImageView = self.pointImageViewArray[i];
        pointImageView.frame = CGRectMake(0, 0, _pointImageViewSize.width, _pointImageViewSize.height);
        pointImageView.center = CGPointMake(i * margin + startDisplayPointLoationX, self.frame.size.height * 0.5);
        pointImageView.layer.cornerRadius = _pointImageViewSize.height * 0.5;
        pointImageView.layer.masksToBounds = YES;
    }
    [self calculateRealProgress];
}


#pragma mark - public getter & setter
- (void)setPoint:(NSInteger)point{
    if (self.pointArray.count == 0) {
        NSException *ex = [NSException exceptionWithName:@"error" reason:@"必须先初始化pointArray,然后再设置point" userInfo:nil];
        @throw ex;
    }
    if (point < _startPoint) {
        point = _startPoint;
    }
    if (point > _endPoint) {
        point = _endPoint;
    }
    _point = point;
    [self setNeedsLayout];

}

- (void)calculateRealProgress{
    NSInteger selectedIndex = -1;
    NSInteger selectedNum = _startPoint;
    NSInteger count = self.pointArray.count;
    for (NSInteger i = count - 1; i > -1; i--) {
        NSInteger num = [self.pointArray[i] integerValue];
        AMPointImageView *imageView = self.pointImageViewArray[i];
        imageView.isSelected = NO;
        if (_point >= num) {
            selectedNum = num;
            selectedIndex = i;
            break;
        }
    }
    
    
    if (selectedIndex == self.pointArray.count - 1) {
        
        [self calculateRealProgressWithPoint:_point intervalStartPoint:selectedNum intervalEndPoint:_endPoint intervalStartImageView:self.pointImageViewArray[selectedIndex] intervalEndImageView:nil];
        
    } else if(selectedIndex == -1){
        [self calculateRealProgressWithPoint:_point intervalStartPoint:_startPoint intervalEndPoint:[self.pointArray[0] integerValue] intervalStartImageView:nil intervalEndImageView:self.pointImageViewArray[0]];
    }else {
        [self calculateRealProgressWithPoint:_point intervalStartPoint:selectedNum intervalEndPoint:[self.pointArray[selectedIndex + 1] integerValue] intervalStartImageView:self.pointImageViewArray[selectedIndex] intervalEndImageView:self.pointImageViewArray[selectedIndex + 1]];
    }
}

- (void)calculateRealProgressWithPoint:(NSInteger)point intervalStartPoint:(NSInteger)intervalStartPoint intervalEndPoint:(NSInteger)intervalEndPoint intervalStartImageView:(UIImageView *)intervalStartImageView intervalEndImageView:(UIImageView *)intervalEndImageView{
    if (intervalEndImageView) {
        intervalEndPoint -= 1;
    }

    NSInteger D_value_end_start = intervalEndPoint - intervalStartPoint;
    NSInteger D_value_point_start = point - intervalStartPoint;
    
    CGFloat intervalEndImageViewProgress = 1;
    if(intervalEndImageView){
        if (point == intervalEndPoint) {
            intervalEndImageViewProgress = intervalEndImageView.center.x / self.frame.size.width;
        }else{
            intervalEndImageViewProgress = intervalEndImageView.frame.origin.x / self.frame.size.width;
        }

    }
    CGFloat intervalStartImageViewProgress = 0;
    if (intervalStartImageView) {
        if (D_value_point_start == 0) {
            intervalStartImageViewProgress = intervalStartImageView.center.x / self.frame.size.width;
        }else{
            intervalStartImageViewProgress = CGRectGetMaxX(intervalStartImageView.frame) / self.frame.size.width;
        }
    }

    CGFloat D_value_endProgress_startProgress = intervalEndImageViewProgress - intervalStartImageViewProgress;
    
    CGFloat progress = (D_value_point_start * 1.0 / D_value_end_start) * D_value_endProgress_startProgress + intervalStartImageViewProgress;
    _progressView.progress = progress;
    NSLog(@"%zd == %zd == %zd",point,intervalStartPoint,intervalEndPoint);
    

    if (intervalStartImageView) {
        NSInteger imagesCount = self.pointImageViewArray.count;
        for (NSInteger i = 0; i < imagesCount; i++) {
            AMPointImageView *imageView = self.pointImageViewArray[i];
            imageView.isSelected = YES;
            if (imageView == intervalStartImageView) {
                return;
            }
        }
    }
    
}




- (void)setPointImageViewSize:(CGSize)pointImageViewSize{
    _pointImageViewSize = pointImageViewSize;
    [self setNeedsLayout];
}

- (void)setPointArray:(NSArray *)pointArray{
    NSMutableArray *resultArray = [pointArray mutableCopy];
    [resultArray sortUsingSelector:@selector(compare:)];
    _pointArray = resultArray;
    [self reloadPointData];
}

- (void)setPointTintColor:(UIColor *)pointTintColor{
    _pointTintColor = pointTintColor;
    self.progressView.progressTintColor = pointTintColor;
    NSInteger count = self.pointImageViewArray.count;
    for (NSInteger i = 0; i < count; i++) {
        AMPointImageView *imageView = self.pointImageViewArray[i];
        imageView.selectedTintColor = pointTintColor;
    }
}
- (void)setTrackTintColor:(UIColor *)trackTintColor{
    _trackTintColor = trackTintColor;
    self.progressView.trackTintColor = trackTintColor;
    NSInteger count = self.pointImageViewArray.count;
    for (NSInteger i = 0; i < count; i++) {
        AMPointImageView *imageView = self.pointImageViewArray[i];
        imageView.unSelectedTintColor = trackTintColor;
    }
}

- (void)setLineProgressViewHeight:(CGFloat)lineProgressViewHeight{
    _lineProgressViewHeight = lineProgressViewHeight;
    [self setNeedsLayout];
}

#pragma mark - private getter & setter
- (NSArray *)pointImageViewArray{
    
    if (!_pointImageViewArray) {
        _pointImageViewArray = [[NSMutableArray alloc]init];
    }
    return _pointImageViewArray;
    
}

- (NSInteger)endPoint{
    NSInteger lastPoint = [self.pointArray.lastObject integerValue];
    if (_endPoint < lastPoint) {
        _endPoint = lastPoint + 100;
    }
    return _endPoint;
}

#pragma mark - privateMethods

- (void)reloadPointData{
    [_pointImageViewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _pointImageViewArray = nil;
    _progressView.progress = 0;
    _point = 0;
    NSInteger count = self.pointArray.count;
    for (NSInteger i = 0; i < count; i++) {
        AMPointImageView *imageView = [AMPointImageView new];
        imageView.isSelected = NO;
        imageView.unSelectedTintColor = self.trackTintColor;
        imageView.selectedTintColor = self.pointTintColor;
        [self.pointImageViewArray addObject:imageView];
        [self addSubview:imageView];
    }
    [self setNeedsLayout];
}


- (void)addProgressView{
    AMProgressView *progressView =  [[AMProgressView alloc] init];
    progressView.trackTintColor = self.trackTintColor;
    progressView.progressTintColor = self.pointTintColor;
    [self addSubview:progressView];
    progressView.progress = 0;
    _progressView = progressView;
}
@end
