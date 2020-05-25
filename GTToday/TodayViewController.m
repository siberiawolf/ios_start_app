//
//  TodayViewController.m
//  GTToday
//
//  Created by mac on 2020/5/25.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 0, 200, 100)];
        [button setTitle:@"点击跳转" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(_openSampleApp) forControlEvents:UIControlEventTouchUpInside];
        button;
    })];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}
#pragma mark -
- (void) _openSampleApp{    // 打开SampleApp应用
    [self.extensionContext openURL:[NSURL URLWithString:@"GTTest://"] completionHandler:^(BOOL success) {
        
    }];
}

@end
