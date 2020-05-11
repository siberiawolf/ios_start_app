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
    __weak typeof (self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        __strong typeof (weakSelf) strongSelf = weakSelf;   // 处理循环引用
        
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
        
        // 将网络请求回的数据存储起来
        [strongSelf _archiveListDataWithArray:listItemArray.copy];

//        期望所有的回包都是在主线程中进行
        dispatch_async(dispatch_get_main_queue(), ^{
                           if (finishBlock) {
                               //             当没有错误返回时，参数为TRUE
                               finishBlock(error == nil, listItemArray.copy);
                           }
                       });
    }];
    [dataTask resume]; // 恢复task(执行task)
}

/// 获取沙盒地址
- (void)_archiveListDataWithArray:(NSArray<GTListItem *> *)array{
    //
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES); // 读取用户缓存目录
    NSString *cachePath = [pathArray firstObject];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"GTData"]; // 准备好一个叫GTData的目录
    
    // 1.创建文件夹
    NSError *createError;
    [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&createError]; // 创建好GTData文件夹
    
    // 2.创建文件
    NSString *listDataPath = [dataPath stringByAppendingPathComponent:@"list"]; // 向GTData中创建一个list文件
    
    // 采用安全模式序列化整个array
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
    
    // 将整个数据序列化到文件中
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];    // 向list文件中写数据
    
    // 反序列化文件中的数据
    NSData *readListData = [fileManager contentsAtPath:listDataPath];
    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class],[GTListItem class], nil] fromData:readListData error:nil]; // 取出序列化的数据
    
    // 3.查询文件
//    BOOL fileExit = [fileManager fileExistsAtPath:listDataPath];
    
    // 4.删除文件
//    if(fileExit){
//        [fileManager removeItemAtPath:listDataPath error:nil];
//    }
    
    // 5.向文件末尾添加内容
//    NSFileHandle *fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:listDataPath];
//
//    [fileHandler seekToEndOfFile]; // 向文件最后添加内容
//    [fileHandler writeData:[@"def" dataUsingEncoding:NSUTF8StringEncoding]];
//
//    [fileHandler synchronizeFile]; // 立即刷新文件
//    [fileHandler closeFile]; // 关闭文件操作
    
    NSLog(@"");
}

@end
