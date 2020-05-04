//
//  GTNormalTableViewCell.h
//  SampleApp
//
//  Created by mac on 2020/5/4.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTNormalTableViewCell : UITableViewCell

- (void)layoutTableViewCell; // 暴露这个方法，每次给tableView布局时调用

@end

NS_ASSUME_NONNULL_END
