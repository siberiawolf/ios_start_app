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

+ (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl;

@end

NS_ASSUME_NONNULL_END
