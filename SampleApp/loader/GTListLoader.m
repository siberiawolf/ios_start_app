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
    
    __unused NSURLRequest *listRequest = [NSURLRequest requestWithURL:listURL];
    
    NSLog(@"");
    
}

@end
