//
//  GTVideoCoverView.m
//  SampleApp
//
//  Created by mac on 2020/5/13.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTVideoCoverView.h"
#import <AVFoundation/AVFoundation.h>

@interface GTVideoCoverView()

@property (nonatomic, strong, readwrite) AVPlayerItem *videoItem;
@property (nonatomic, strong, readwrite) AVPlayer *avPlayer;
@property (nonatomic, strong, readwrite) AVPlayerLayer *playerLayer;

@property (nonatomic, strong, readwrite) UIImageView *coverView;
@property (nonatomic, strong, readwrite) UIImageView *playButton; // 期望点击整个cell进行播放视频
@property (nonatomic, copy, readwrite) NSString *videoUrl; // 视频URL

@end

@implementation GTVideoCoverView

/// 初始化添加View
/// @param frame View frame
- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)]; // 大小与frame一致
            _coverView;
        })];
        
        [_coverView addSubview:({
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-50)/2, (frame.size.height-50)/2, 50, 50)];
            _playButton;
        })];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];
        
        // 视频播放结束
        // 向消息通知事件中心注册自己
        [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(_handlePlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        
    }
    return self;
}

/// 销毁掉事件中心
- (void)dealloc{    // 单例销毁时移除
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_videoItem removeObserver:self forKeyPath:@"status"];  // 移除对status变化的监听
    [_videoItem removeObserver:self forKeyPath:@"loadedTimeRanges"];  // 移除对status变化的监听
}
#pragma mark - public method
- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl{
    _coverView.image = [UIImage imageNamed:videoCoverUrl];  // 视频首帧截图
    _playButton.image = [UIImage imageNamed:@"icon.bundle/videoPlay.png"]; // 播放按钮图标
    _videoUrl = videoUrl;   // 缓存视频url
}

#pragma mark - private method


/// 视频播放按钮事件
-(void)_tapToPlay{
    NSURL *videoURL = [NSURL URLWithString:_videoUrl]; // 资源创建
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
       NSLog(@"播放进度：%@", @(CMTimeGetSeconds(time))) ;
    }];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer]; // view创建
    _playerLayer.frame = _coverView.bounds; // 设置大小
    [_coverView.layer addSublayer:_playerLayer]; // 向视图中添加layer
    
    NSLog(@"");
}

/// 视频播放结束回调
-(void)_handlePlayEnd{
//    [_playerLayer removeFromSuperlayer]; // 移除Player
//    _avPlayer = nil; // 将播放器清空
//    _videoItem = nil;
    
    [_avPlayer seekToTime:CMTimeMake(0, 1)];
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
