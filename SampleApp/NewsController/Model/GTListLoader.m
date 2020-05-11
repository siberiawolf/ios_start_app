//
//  GTListLoader.m
//  SampleApp
//
//  Created by mac on 2020/5/9.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTListLoader.h"
#import "GTListItem.h"
#import <AFNetworking.h>

@implementation GTListLoader

- (void)loadListDataWithFinishBlock:(GTListLoaderFinishBlock)finishBlock {
//    使用AFNetworking 处理网络请求
//    [[AFHTTPSessionManager manager] GET:@"https://static001.geekbang.org/univer/classes/ios_dev/lession/45/toutiao.json" parameters:nil headers:nil progress:^(NSProgress *_Nonnull downloadProgress) {
//        NSLog(@"AFNetworking  进度条");
//    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
//        NSLog(@"AFNetworking 请求成功");
//    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
//        NSLog(@"AFNetworking 请求失败");
//    }];

//    使用系统自带的方式处理网络请求

    NSString *urlString = @"https://static001.geekbang.org/univer/classes/ios_dev/lession/45/toutiao.json";
//    NSString *urlString = @"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";
    NSURL *listURL = [NSURL URLWithString:urlString];

//     使用系统自带的sharedSession创建一个session
    NSURLSession *session = [NSURLSession sharedSession];

//     dataTask属于session；同时封装了listRequest
//    __unused NSURLRequest *listRequest = [NSURLRequest requestWithURL:listURL];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:listRequest];

//    通过Handler block处理response
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        NSError *jsonError;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

#warning 类型判断检查
        NSArray *dataArray = [((NSDictionary *)[((NSDictionary *)jsonObj) objectForKey:@"result"]) objectForKey:@"data"];
        NSMutableArray *listItemArray = @[].mutableCopy;    // 已经结构化的数组
        for (NSDictionary *info in dataArray) {
            GTListItem *listItem = [[GTListItem alloc] init];
            [listItem configWithDictonary:info];
            [listItemArray addObject:listItem];
        }

//        期望所有的回包都是在主线程中进行
        dispatch_async(dispatch_get_main_queue(), ^{
                           if (finishBlock) {
                               //             当没有错误返回时，参数为TRUE
                               finishBlock(error == nil, listItemArray.copy);
                           }
                       });
    }];
    [self _getSandBoxPath]; // 获取沙盒地址
    [dataTask resume]; // 恢复task(执行task)
}

/// 获取沙盒地址
- (void)_getSandBoxPath{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"");
}

@end
