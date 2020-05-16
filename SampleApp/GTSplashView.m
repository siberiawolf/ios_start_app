//
//  GTSplashView.m
//  SampleApp
//
//  Created by mac on 2020/5/16.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTSplashView.h"
#import "GTScreen.h"

@interface GTSplashView()

@property (nonatomic, strong, readwrite) UIButton *button;  // 让用户手动点击

@end

@implementation GTSplashView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"icon.bundle/splash.png"];
        [self addSubview:({
            _button = [[UIButton alloc] initWithFrame:UIRect(330, 100, 60, 40)];
            _button.backgroundColor = [UIColor lightGrayColor];
            [_button setTitle:@"跳过" forState:UIControlStateNormal];
            [_button addTarget:self action:@selector(_removeSplashView) forControlEvents:UIControlEventTouchUpInside];
            _button;
        })];
        self.userInteractionEnabled = YES; // 闪屏是UIClickView，要允许点击
    }
    return self;
}

- (void)_removeSplashView{
    [self removeFromSuperview];
}

@end
