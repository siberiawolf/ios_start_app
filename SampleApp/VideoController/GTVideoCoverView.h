//
//  GTVideoCoverView.h
//  SampleApp
//
//  Created by mac on 2020/5/13.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTVideoCoverView : UICollectionViewCell


/// 视频播放列表
/// @param videoCoverUrl 视频占位图url
/// @param videoUrl 视频播放url
- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl;

@end

NS_ASSUME_NONNULL_END
