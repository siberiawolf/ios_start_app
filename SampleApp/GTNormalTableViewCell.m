//
//  GTNormalTableViewCell.m
//  SampleApp
//
//  Created by mac on 2020/5/4.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTNormalTableViewCell.h"

@interface GTNormalTableViewCell()

// 准备复写的布局Label
@property(nonatomic, strong, readwrite) UILabel *titleLabel;
@property(nonatomic, strong, readwrite) UILabel *sourceLabel;
@property(nonatomic, strong, readwrite) UILabel *commentLabel;
@property(nonatomic, strong, readwrite) UILabel *timeLabel;
@property(nonatomic, strong, readwrite) UIImageView *rightImageView;
@property(nonatomic, strong, readwrite) UIButton *deleteButton;

@end

@implementation GTNormalTableViewCell

// 重写初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        // 标题
        [self.contentView addSubview:({
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 300, 50)] ;
            self.titleLabel.font = [UIFont systemFontOfSize:16];
            self.titleLabel.textColor= [UIColor blackColor];
            self.titleLabel;
        })];
        
        // 来源
        [self.contentView addSubview:({
            self.sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 50, 20)] ;
            self.sourceLabel.font = [UIFont systemFontOfSize:12];
            self.sourceLabel.textColor= [UIColor grayColor];
            
            self.sourceLabel;
        })];
        
        // 评论
        [self.contentView addSubview:({
            self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 80, 50, 20)] ;
            self.commentLabel.font = [UIFont systemFontOfSize:12];
            self.commentLabel.textColor= [UIColor grayColor];
            
            self.commentLabel;
        })];
        
        // 时间
        [self.contentView addSubview:({
            self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 80, 50, 20)] ;
            self.timeLabel.font = [UIFont systemFontOfSize:12];
            self.timeLabel.textColor= [UIColor grayColor];
            
            self.timeLabel;
        })];
        
        // 右侧图片
        [self.contentView addSubview:({
            self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(330, 15, 70, 70)] ;
            self.rightImageView.contentMode = UIViewContentModeScaleAspectFit;  // 自定义填充方式
            self.rightImageView;
        })];
        
        // 删除按钮
        [self.contentView addSubview:({
            self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(290, 80, 30, 20)] ;
            self.deleteButton.backgroundColor = [UIColor blueColor];
            [self.deleteButton setTitle:@"X" forState:UIControlStateNormal];    // 正常显示时候的样式（系统自带）
            [self.deleteButton setTitle:@"V" forState:UIControlStateHighlighted]; // 点击按住时候的样式（系统自带）
            // UIControl以及Target-Action模式
            // 添加自定义点击事件
            [self.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
            self.deleteButton;
        })];
        
    }
    return self;
}

// 暴露一个函数，给外部使用
- (void)layoutTableViewCell{
    self.titleLabel.text = @"极客时间iOS开发";
    
    self.sourceLabel.text = @"极客时间";
    [self.sourceLabel sizeToFit];   // label 大小根据文字自适应
    
    self.commentLabel.text = @"1888评论";
    // 距离来源右边的位置加15
    self.commentLabel.frame = CGRectMake( self.sourceLabel.frame.origin.x +  self.sourceLabel.frame.size.width + 15,  self.commentLabel.frame.origin.y, self.commentLabel.frame.size.width, self.commentLabel.frame.size.height);
    [self.commentLabel sizeToFit];
    
    self.timeLabel.text = @"三分钟前";
    // 距离评论最右边的位置加15
    self.timeLabel.frame = CGRectMake( self.commentLabel.frame.origin.x +  self.commentLabel.frame.size.width + 15,  self.timeLabel.frame.origin.y, self.timeLabel.frame.size.width, self.timeLabel.frame.size.height);
    [self.timeLabel sizeToFit];
    
    self.rightImageView.image = [UIImage imageNamed:@"icon.bundle/icon.png"];
}

// 点击时触发函数
- (void)deleteButtonClick{
    NSLog(@"deleteButtonClick");
}

@end
