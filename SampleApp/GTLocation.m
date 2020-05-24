//
//  GTLocation.m
//  SampleApp
//
//  Created by mac on 2020/5/24.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface GTLocation()<CLLocationManagerDelegate>
@property (nonatomic, strong, readwrite) CLLocationManager *manager;
@end

@implementation GTLocation

+ (GTLocation *)locationManager{
    static GTLocation *location;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [[GTLocation alloc] init];
    });
    return location;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.manager = [[CLLocationManager alloc] init];
        self.manager.delegate = self;
    }
    return self;
}

- (void)checkLocationAuthorization{
    // 判断系统是否开启定位
    if(![CLLocationManager locationServicesEnabled]){
        // 引导弹窗
        
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.manager requestWhenInUseAuthorization];   // 请求位置权限
    }
}
// 权限改变
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusNotDetermined) { // 开启
        //
    }else if(status == kCLAuthorizationStatusDenied){ // 禁用
        //
    }
}

@end
