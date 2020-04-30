//
//  AppDelegate.m
//  SampleApp
//
//  Created by mac on 2020/4/27.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>   // 在UITabBarController中有声明

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 这里使用自定义的UIWindow
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    
    // 之前自定义的ViewController
    ViewController *viewController = [[ViewController alloc] init];


    // 将ViewController添加到tabbarController中
    // 创建4个UIViewController
//    UIViewController *controller1 = [[UIViewController alloc] init];
//    controller1.view.backgroundColor = [UIColor redColor];
    viewController.tabBarItem.title = @"新闻";
    viewController.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x.png"];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/page_selected@2x.png"];
    
    UIViewController *controller2 = [[UIViewController alloc] init];
    controller2.view.backgroundColor = [UIColor yellowColor];
    controller2.tabBarItem.title = @"视频";
    controller2.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/video@2x.png"];
    controller2.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/video_selected@2x.png"];


    UIViewController *controller3 = [[UIViewController alloc] init];
    controller3.view.backgroundColor = [UIColor greenColor];
    controller3.tabBarItem.title = @"推荐";
    controller3.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/like@2x.png"];
    controller3.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/like_selected@2x.png"];

    
    UIViewController *controller4 = [[UIViewController alloc] init];
    controller4.view.backgroundColor = [UIColor lightGrayColor];
    controller4.tabBarItem.title = @"我的";
    controller4.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/home@2x.png"];
    controller4.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/home_selected@2x.png"];
       
    // 将4个UIViewController添加到UITabBarController中
    [tabbarController setViewControllers:@[viewController, controller2, controller3, controller4]];
    // 底部导航的顺序完全是由堆栈的顺序决定
    
    // 将当前这个类指定为tabbarController的delegate
    tabbarController.delegate = self;
    
    // 指定之前的viewController为navigationController
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabbarController];
        
    // rootViewController设置为NavigationController，改变切换效果
    self.window.rootViewController = navigationController;  // 显示最基本的tabbarController
    [self.window makeKeyAndVisible]; // 让UIWindow显示出来
        
    return YES;
}

// delegate需要实现的方法
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"did select delegate");
}



@end
