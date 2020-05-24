//
//  AppDelegate.m
//  SampleApp
//
//  Created by mac on 2020/4/27.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "AppDelegate.h"
#import "GTNewsViewController.h"
#import "GTVideoViewController.h"
#import "GTRecommendViewController.h"
#import "GTMineViewController.h"
#import "GTSplashView.h"
#import "GTStaticTest.h" // 引入静态库
#import <GTFramework/GTFrameworkTest.h> // 引入动态库
#import "GTLocation.h"
#import "GTNotification.h"

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
    GTNewsViewController *newsViewController = [[GTNewsViewController alloc] init]; // 新闻列表
    GTVideoViewController *videoController = [[GTVideoViewController alloc] init];  // 视频列表
    GTRecommendViewController *recommendController = [[GTRecommendViewController alloc] init]; // 推荐
    GTMineViewController *mimeViewController = [[GTMineViewController alloc] init]; // 我的

    // 将4个UIViewController添加到UITabBarController中
    [tabbarController setViewControllers:@[newsViewController, videoController, recommendController, mimeViewController]];
    // 底部导航的顺序完全是由堆栈的顺序决定

    // 将当前这个类指定为tabbarController的delegate
    tabbarController.delegate = self;

    // 指定之前的viewController为navigationController
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabbarController];

    // rootViewController设置为NavigationController，改变切换效果
    self.window.rootViewController = navigationController;  // 显示最基本的tabbarController
    [self.window makeKeyAndVisible]; // 让UIWindow显示出来

    [self.window addSubview:({
        GTSplashView *splashView = [[GTSplashView alloc] initWithFrame:self.window.bounds];
        splashView;
    })];
    
//     使用iOS静态库
//    [[GTStaticTest alloc] init];
//    使用iOSFramework动态库
//    [[GTFrameworkTest alloc] init];
    // 检查位置信息
    [[GTLocation locationManager] checkLocationAuthorization];
    [[GTNotification notificationManager] checkNotificationAuthorization];
    
    return YES;
}

// delegate需要实现的方法
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"did select delegate");
}

# pragma -
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    
    return YES;
}

@end
