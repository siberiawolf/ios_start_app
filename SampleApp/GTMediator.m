//
//  GTMediator.m
//  SampleApp
//
//  Created by mac on 2020/5/17.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTMediator.h"

@implementation GTMediator

+ (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl {
    Class detailCls = NSClassFromString(@"GTDetailViewController"); // 通过反射实现业务逻辑完全解耦
    UIViewController *controller = [[detailCls alloc] performSelector:NSSelectorFromString(@"initWithUrlString:") withObject:detailUrl];
    return controller;
}

@end
