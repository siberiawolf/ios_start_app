//
//  GTVideoPlayer.m
//  SampleApp
//
//  Created by mac on 2020/5/14.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface GTVideoPlayer ()
@property (nonatomic, strong, readwrite) AVPlayerItem *videoItem;
@property (nonatomic, strong, readwrite) AVPlayer *avPlayer;
@property (nonatomic, strong, readwrite) AVPlayerLayer *playerLayer;
@end

@implementation GTVideoPlayer

+ (GTVideoPlayer *)player{
    static GTVideoPlayer *player;
    static dispatch_once_t onceToken; // 实现播放器单例
    dispatch_once(&onceToken, ^{
        player = [[GTVideoPlayer alloc] init];
    });
    return player;
}

- (void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *)attachView {
    
    [self _stopPlay]; // 销毁掉原来的播放器，重新创建
    
    NSURL *videoURL = [NSURL URLWithString: videoUrl]; // 资源创建
    AVAsset *asset = [AVAsset assetWithURL:videoURL];
    _videoItem = [AVPlayerItem playerItemWithAsset:asset]; // model创建
    // 对playerItem监听status变化
    [_videoItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];    // 资源加载成功
    [_videoItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];     // 资源缓存进度

    CMTime duration = _videoItem.duration;
    CGFloat videoDuration = CMTimeGetSeconds(duration);

    _avPlayer = [AVPlayer playerWithPlayerItem:_videoItem]; // controller创建
    // 按照每1秒进行回调
    [_avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        NSLog(@"播放进度：%@", @(CMTimeGetSeconds(time)));
    }];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer]; // view创建
    _playerLayer.frame = attachView.bounds; // 设置大小
    [attachView.layer addSublayer:_playerLayer]; // 向视图中添加layer
    
    // 视频播放结束
    // 向消息通知事件中心注册自己
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(_handlePlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];

    NSLog(@"");
}

#pragma mark - private method

///  停止播放
- (void)_stopPlay {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_playerLayer removeFromSuperlayer];     // 移除Player
    [_videoItem removeObserver:self forKeyPath:@"status"];  // 移除对status变化的监听
    [_videoItem removeObserver:self forKeyPath:@"loadedTimeRanges"];  // 移除对status变化的监听
    _avPlayer = nil;     // 将播放器清空
    _videoItem = nil;
}

/// 视频播放结束回调
- (void)_handlePlayEnd {
    [_avPlayer seekToTime:CMTimeMake(0, 1)];
    [_avPlayer play];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"status"]){ // 监听的是status变化时
        if(((NSNumber *)[change objectForKey:NSKeyValueChangeNewKey]).integerValue == AVPlayerItemStatusReadyToPlay){ // 当变化的状态为准备好播放时
            [_avPlayer play];    // 播放
        }else{
            NSLog(@"");
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSLog(@"缓冲：%@", [change objectForKey:NSKeyValueChangeNewKey]);
    }
}


@end
