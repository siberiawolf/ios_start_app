//
//  GTVideoToolbar.m
//  SampleApp
//
//  Created by mac on 2020/5/14.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTVideoToolbar.h"

@interface GTVideoToolbar()

@property(nonatomic, strong, readwrite) UIImageView *avatorImageView;
@property(nonatomic, strong, readwrite) UILabel *nickLabel;

@property(nonatomic, strong, readwrite) UIImageView *commentImageView;
@property(nonatomic, strong, readwrite) UILabel *commentLabel;

@property(nonatomic, strong, readwrite) UIImageView *likeImageView;
@property(nonatomic, strong, readwrite) UILabel *likeLabel;

@property(nonatomic, strong, readwrite) UIImageView *shareImageView;
@property(nonatomic, strong, readwrite) UILabel *shareLabel;

@end

@implementation GTVideoToolbar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];

        [self addSubview:({
            _avatorImageView = [[UIImageView alloc] initWithFrame:CGRectZero]; // 大小为0
            _avatorImageView.layer.masksToBounds = YES; // 圆角处理
            _avatorImageView.layer.cornerRadius = 15;
            _avatorImageView.translatesAutoresizingMaskIntoConstraints = NO;
            _avatorImageView;
        })];
        [self addSubview:({
            _nickLabel = [[UILabel alloc] init];
            _nickLabel.font = [UIFont systemFontOfSize:15];
            _nickLabel.textColor = [UIColor lightGrayColor];
            _nickLabel.translatesAutoresizingMaskIntoConstraints = NO;
            _nickLabel;
        })];

        [self addSubview:({
            _commentImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            _commentImageView.layer.masksToBounds = YES;
            _commentImageView.layer.cornerRadius = 15;
            _commentImageView.translatesAutoresizingMaskIntoConstraints = NO;

            _commentImageView;
        })];
        [self addSubview:({
            _commentLabel = [[UILabel alloc] init];
            _commentLabel.font = [UIFont systemFontOfSize:15];
            _commentLabel.textColor = [UIColor lightGrayColor];
            _commentLabel.translatesAutoresizingMaskIntoConstraints = NO;

            _commentLabel;
        })];

        [self addSubview:({
            _likeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            _likeImageView.layer.masksToBounds = YES;
            _likeImageView.layer.cornerRadius = 15;
            _likeImageView.translatesAutoresizingMaskIntoConstraints = NO;

            _likeImageView;
        })];
        [self addSubview:({
            _likeLabel = [[UILabel alloc] init];
            _likeLabel.font = [UIFont systemFontOfSize:15];
            _likeLabel.textColor = [UIColor lightGrayColor];
            _likeLabel.translatesAutoresizingMaskIntoConstraints = NO;

            _likeLabel;
        })];

        [self addSubview:({
            _shareImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            _shareImageView.layer.masksToBounds = YES;
            _shareImageView.layer.cornerRadius = 15;
            _shareImageView.translatesAutoresizingMaskIntoConstraints = NO;
            _shareImageView.contentMode = UIViewContentModeScaleToFill;
            _shareImageView;
        })];
        
        [self addSubview:({
            _shareLabel = [[UILabel alloc] init];
            _shareLabel.font = [UIFont systemFontOfSize:15];
            _shareLabel.textColor = [UIColor lightGrayColor];
            _shareLabel.translatesAutoresizingMaskIntoConstraints = NO;
            _shareLabel;
        })];

    }
    return self;
}

- (void)layoutWithModel:(id)model{
    // 设置文字和图标
    _avatorImageView.image = [UIImage imageNamed:@"icon.bundle/icon.png"];
    _nickLabel.text = @"极客时间";
    _commentImageView.image = [UIImage imageNamed:@"icon.bundle/comment@3x.png"];
    _commentLabel.text = @"100";
    _likeImageView.image = [UIImage imageNamed:@"icon.bundle/praise@3x.png"];
    _likeLabel.text = @"25";
    _shareImageView.image = [UIImage imageNamed:@"icon.bundle/share@3x.png"];
    _shareLabel.text = @"分享";
    
    
    // 1.使用原生autoLayout进行布局
    [NSLayoutConstraint activateConstraints:@[
        // 纵向布局，居中
        [NSLayoutConstraint constraintWithItem:_avatorImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0], // 头像纵向布局
        // 横向布局，边距15
        [NSLayoutConstraint constraintWithItem:_avatorImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:15], // 头像横向布局
        // 头像宽度约束
        [NSLayoutConstraint constraintWithItem:_avatorImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30], // 头像宽度30
        // 头像高度约束
        [NSLayoutConstraint constraintWithItem:_avatorImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30], // 头像高度30

        // 昵称纵向布局，居中
        [NSLayoutConstraint constraintWithItem:_nickLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatorImageView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0], // 昵称纵向布局
        // 昵称横向布局，边距0
        [NSLayoutConstraint constraintWithItem:_nickLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_avatorImageView attribute:NSLayoutAttributeRight multiplier:1 constant:0], // 昵称横向布局，距离头像右侧0

     ]];
    
    // 2. 使用vfl字符串进行布局
    // 这段字符串表示，左右间距是15，图标与文字之间间距是0，评论、点赞、分享之间间距是15。都是固定值
    // 昵称和评论之间的间距是自定适配的，>=0
    NSString *vflString = @"H:|-15-[_avatorImageView]-0-[_nickLabel]-(>=0)-[_commentImageView(==_avatorImageView)]-0-[_commentLabel]-15-[_likeImageView(==_avatorImageView)]-0-[_likeLabel]-15-[_shareImageView(==_avatorImageView)]-0-[_shareLabel]-15-|";

    // metrics: 动态替换vfl字符串中的数字，因为这里不用替换所以nil
    // views: 对应着vfl字符串中的变量
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflString options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_avatorImageView, _nickLabel, _commentImageView, _commentLabel, _likeImageView, _likeLabel, _shareImageView, _shareLabel)]];

}

@end
