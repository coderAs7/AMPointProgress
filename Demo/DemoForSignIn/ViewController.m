//
//  ViewController.m
//  DemoForSignIn
//
//  Created by  高东星 on 17/8/25.
//  Copyright © 2017年 anmur. All rights reserved.
//

#import "ViewController.h"
#import "AMPointProgressView.h"
#import "AMProgressView.h"


@interface ViewController ()

@property (nonatomic,weak) AMPointProgressView *p;
@property (weak, nonatomic) IBOutlet UILabel *dayCountLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AMPointProgressView *progressView = [AMPointProgressView new];
    progressView.pointArray = @[@(7),@(15),@(30),@(60),@(90)];
    progressView.point = 15;
    _dayCountLabel.text = [NSString stringWithFormat:@"当前是 第 %zd 天",progressView.point];
    progressView.frame = CGRectMake(0, 100, self.view.frame.size.width, 40);


    // default (10,10)
    progressView.pointImageViewSize = CGSizeMake(15, 15);
    // default 3
    progressView.lineProgressViewHeight = 5;
    progressView.endPoint = 120;
    progressView.startPoint = 0;
    [self.view addSubview:progressView];
    _p = progressView;
    _p.backgroundColor = [UIColor blueColor];
}



- (IBAction)addOneDay:(id)sender {
    _p.point += 1;
    _dayCountLabel.text = [NSString stringWithFormat:@"当前是 第 %zd 天",_p.point];
}
- (IBAction)deleteOneDay:(id)sender {
    _p.point -= 1;
    _dayCountLabel.text = [NSString stringWithFormat:@"当前是 第 %zd 天",_p.point];
}



@end
