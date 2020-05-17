//
//  GTMediator.m
//  SampleApp
//
//  Created by mac on 2020/5/17.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTMediator.h"

@implementation GTMediator

#pragma mark - Target Action
+ (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl {
    Class detailCls = NSClassFromString(@"GTDetailViewController"); // 通过反射实现业务逻辑完全解耦
    UIViewController *controller = [[detailCls alloc] performSelector:NSSelectorFromString(@"initWithUrlString:") withObject:detailUrl];
    return controller;
}
#pragma mark - URL Scheme

+ (NSMutableDictionary *)mediatorCache{
    static NSMutableDictionary *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = @{}.mutableCopy;
    });
    return cache;
}

+ (void)registerScheme:(NSString *)scheme processBlock:(GTMediatorProcessBlock) processBlock{
    if (scheme && processBlock) {   // 向mediator中添加
        [[[self class ] mediatorCache] setObject:processBlock forKey:scheme];
    }
}

+ (void)openUrl:(NSString *)url params:(NSDictionary *)params{
    GTMediatorProcessBlock block  = [[[self class] mediatorCache] objectForKey:url];
    if (block) {
        block(params);
    }
}

# pragma mark - protol class
+ (void)registerProtol:(Protocol *)proto class:(Class)cls{
    if (proto && cls) {
        [[[self class] mediatorCache] setObject:cls forKey:NSStringFromProtocol(proto)];
    }
}
+ (Class)classForProtol:(Protocol *)proto{
    return [[[self class] mediatorCache] objectForKey:NSStringFromProtocol(proto)];
}
@end
