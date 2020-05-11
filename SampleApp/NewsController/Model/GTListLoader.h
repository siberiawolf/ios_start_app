//
//  GTListLoader.h
//  SampleApp
//
//  Created by mac on 2020/5/9.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GTListItem;  // 可以不用引入头文件，只是声明
NS_ASSUME_NONNULL_BEGIN

typedef void(^GTListLoaderFinishBlock)(BOOL success, NSArray<GTListItem *> *dataArray);


/// 列表请求
@interface GTListLoader : NSObject

- (void) loadListDataWithFinishBlock:(GTListLoaderFinishBlock) finishBlock;

@end

NS_ASSUME_NONNULL_END
