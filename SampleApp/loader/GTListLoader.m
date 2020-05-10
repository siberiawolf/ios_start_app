//
//  GTListLoader.m
//  SampleApp
//
//  Created by mac on 2020/5/9.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTListLoader.h"

@implementation GTListLoader

- (void) loadListData{
//    NSString *urlString = @"https://static001.geekbang.org/univer/classes/ios_dev/lession/45/toutiao.json";
    NSString *urlString = @"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";
    NSURL *listURL = [NSURL URLWithString:urlString];
    
    
    
    // 使用系统自带的sharedSession创建一个session
    NSURLSession *session = [NSURLSession sharedSession];
    
//     dataTask属于session；同时封装了listRequest
//    __unused NSURLRequest *listRequest = [NSURLRequest requestWithURL:listURL];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:listRequest];
    
//    通过Handler block处理response
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"请求成功"); 
    }];
    
    [dataTask resume]; // 恢复task(执行task)
    
    NSLog(@"");
    
}

@end
