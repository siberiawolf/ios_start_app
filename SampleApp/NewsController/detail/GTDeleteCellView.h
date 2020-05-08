//
//  GTDeleteCellView.h
//  SampleApp
//
//  Created by mac on 2020/5/7.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTDeleteCellView : UIView

- (void) showDeleteViewFromPoint:(CGPoint)point clicBlock:(dispatch_block_t) clickBlock; // 保留删除视图

@end

NS_ASSUME_NONNULL_END
