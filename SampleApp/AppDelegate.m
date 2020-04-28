//
//  AppDelegate.m
//  SampleApp
//
//  Created by mac on 2020/4/27.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UITabBarController *tabbarController = [[UITabBarController alloc] init];

    
    // 将ViewController添加到tabbarController中
    // 创建4个UIViewController
    UIViewController *controller1 = [[UIViewController alloc] init];
    controller1.view.backgroundColor = [UIColor redColor];
    controller1.tabBarItem.title = @"新闻";
    controller1.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x.png"];
    controller1.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/page_selected@2x.png"];
    
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
    [tabbarController setViewControllers:@[controller2, controller1, controller3, controller4]];
    // 底部导航的顺序完全是由堆栈的顺序决定
    
    self.window.rootViewController = tabbarController;  // 显示最基本的tabbarController
    
    [self.window makeKeyAndVisible];
    return YES;
}



@end
