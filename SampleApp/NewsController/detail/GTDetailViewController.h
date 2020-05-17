//
//  GTDetailViewController.h
//  SampleApp
//
//  Created by mac on 2020/5/5.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMediator.h"

NS_ASSUME_NONNULL_BEGIN

/// 文章详情页
@interface GTDetailViewController : UIViewController<GTDetailViewControllerProtocol>

/// 根据url初始化
/// @param urlString 详情页url
- (instancetype)initWithUrlString:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
