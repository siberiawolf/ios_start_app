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
        
    }
    return self;
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
    AVPlayerItem *videoItem = [AVPlayerItem playerItemWithAsset:asset]; // model创建
    AVPlayer *avPlayer = [AVPlayer playerWithPlayerItem:videoItem]; // controller创建
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer]; // view创建
    playerLayer.frame = _coverView.bounds; // 设置大小
    [_coverView.layer addSublayer:playerLayer]; // 向视图中添加layer
    [avPlayer play];    // 播放
    
    NSLog(@"");
}

@end
