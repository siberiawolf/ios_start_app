//
//  GTMediator.h
//  SampleApp
//
//  Created by mac on 2020/5/17.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTMediator : NSObject

// target action
+ (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl;

// url scheme
typedef void(^GTMediatorProcessBlock)(NSDictionary *params);

/// 注册urlScheme
/// @param scheme 定义的urlScheme
/// @param processBlock 处理url的回调
+ (void)registerScheme:(NSString *)scheme processBlock:(GTMediatorProcessBlock) processBlock;

/// 打开urlScheme
/// @param url url地址
/// @param params url中具体的参数
+ (void)openUrl:(NSString *)url params:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
