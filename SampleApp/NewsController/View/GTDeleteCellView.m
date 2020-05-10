//
//  GTDeleteCellView.m
//  SampleApp
//
//  Created by mac on 2020/5/7.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTDeleteCellView.h"

@interface GTDeleteCellView()

@property(nonatomic, strong, readwrite) UIView *backgroundView; // 背景色
@property(nonatomic, strong, readwrite) UIButton *deleteButton; // 删除按钮
@property(nonatomic, copy, readwrite) dispatch_block_t deleteBlock; // 删除block

@end

@implementation GTDeleteCellView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:({
            _backgroundView = [[UIView alloc] initWithFrame:self.bounds];   // 与整个组件大小一致
            _backgroundView.backgroundColor = [UIColor blackColor];
            _backgroundView.alpha = 0.6; // 透明度
            // 点击背景层时，同样隐藏
            [_backgroundView addGestureRecognizer:({
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDeleteBiew)];
                tapGesture;
            })];
            _backgroundView;
        })];
        
        [self addSubview:({
            _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            [_deleteButton addTarget:self action:@selector(_clickButton) forControlEvents:UIControlEventTouchUpInside];
            _deleteButton.backgroundColor = [UIColor blueColor];
            _deleteButton;
        })];
    }
    return self;
}
// 显示删除View
- (void) showDeleteViewFromPoint:(CGPoint)point clicBlock:(dispatch_block_t) clickBlock{
    
    // 从点击的位置处开始
    _deleteButton.frame = CGRectMake(point.x, point.y, 0, 0);
    _deleteBlock = [clickBlock copy];
    
//    [[UIApplication sharedApplication].keyWindow addSubview:self]; // 视频中的这个方法废弃了
    [UIApplication.sharedApplication.windows.lastObject addSubview:self]; // iOS 13 以后使用
    
    // 使用系统自带的动画效果
//    [UIView animateWithDuration:1.f animations:^{
//        self.deleteButton.frame = CGRectMake((self.bounds.size.width - 200) /2, (self.bounds.size.height - 200) /2, 200, 200);
//    }];
    
    // 自定义动画效果
    // 动画时间：1.f
    // 动画延迟：0.f
    // 阻尼系数：0.5
    // 动画效果：UIViewAnimationOptionCurveEaseInOut
    [UIView animateWithDuration:1.f delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.deleteButton.frame = CGRectMake((self.bounds.size.width - 200) /2, (self.bounds.size.height - 200) /2, 200, 200);
    } completion:^(BOOL finished) { // 动画完成
        NSLog(@"animate completion");
    }];
    
}
// 隐藏删除View
- (void) dismissDeleteBiew{
    [self removeFromSuperview];
}
// 点击事件
- (void) _clickButton{
    
    if(_deleteBlock){
        _deleteBlock();
    }
    
    [self removeFromSuperview];
}

@end
