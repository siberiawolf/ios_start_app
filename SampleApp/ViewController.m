//
//  ViewController.m
//  SampleApp
//
//  Created by mac on 2020/4/27.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "ViewController.h"

@interface TestView : UIView

@end

@implementation TestView

// 重载UIView初始化函数
- (instancetype)init{
    self = [super init];
    if(self){
        
    }
    return self;
}

// 四个主要的声明周期，这里直接调用内部的生命周期函数
// 重载UIView的生命周期
- (void)willMoveToSuperview:(nullable UIView *)newSuperview{
    [super willMoveToSuperview: newSuperview];
}
- (void)didMoveToSuperview{
    [super didMoveToSuperview];
}
- (void)willMoveToWindow:(nullable UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
}
- (void)didMoveToWindow{
    [super didMoveToWindow];
}

@end

@interface ViewController ()

@end

@implementation ViewController

// 重载UIViewController初始化函数
- (instancetype)init{
  self = [super init];
  if(self){
      
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear: animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear: animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewWillAppear: animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIView *view = [[UIView alloc] init]; // 向内存申请分配地址，然后创建一个UIView
//    view.backgroundColor = [UIColor redColor];  // 背景色是红色
//    view.frame = CGRectMake(100, 100, 100, 100);    // 宽高是100，距离屏幕也分别是100
//
//    [self.view addSubview:view];    // 添加视图到根视图
    
    // view2 这个视图是后入栈的，所以这个视图会在前面的视图上面展示
    TestView *view2 = [[TestView alloc] init]; // 向内存申请分配地址，然后创建一个UIView
    view2.backgroundColor = [UIColor greenColor];  // 背景色是红色
    view2.frame = CGRectMake(150, 150, 100, 100);    // 宽高是100，距离屏幕也分别是100

    [self.view addSubview:view2];    // 添加视图到根视图
}


@end
