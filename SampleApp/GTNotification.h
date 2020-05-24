//
//  GTNotification.h
//  SampleApp
//
//  Created by mac on 2020/5/24.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/// APP 推送管理
@interface GTNotification : NSObject

+ (GTNotification *)notificationManager;

- (void)checkNotificationAuthorization;


@end

NS_ASSUME_NONNULL_END
