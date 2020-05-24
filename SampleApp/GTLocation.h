//
//  GTLocation.h
//  SampleApp
//
//  Created by mac on 2020/5/24.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/// App中统一的位置信息管理
@interface GTLocation : NSObject

+ (GTLocation *)locationManager;

- (void)checkLocationAuthorization;

@end

NS_ASSUME_NONNULL_END
