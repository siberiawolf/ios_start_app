//
//  GTVideoPlayer.h
//  SampleApp
//
//  Created by mac on 2020/5/14.
//  Copyright © 2020 siberiawolf. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTVideoPlayer : NSObject

+ (GTVideoPlayer *)player; // 单例

/// 通过视频URL播放视频
/// @param videoUrl 视频URL
/// @param attachView 视频需要放到哪个view层上
- (void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *)attachView;

@end

NS_ASSUME_NONNULL_END
