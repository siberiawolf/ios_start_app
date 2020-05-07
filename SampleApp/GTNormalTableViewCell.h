//
//  GTNormalTableViewCell.h
//  SampleApp
//
//  Created by mac on 2020/5/4.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 自定义一个delegate
@protocol GTNormalTableViewCellDelegate <NSObject>
 
// 给TableViewCell 添加一个delegate
// 同时指定是哪个cell和点击button
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton;

@end

@interface GTNormalTableViewCell : UITableViewCell

// 定义delegate属性
@property(nonatomic, weak, readwrite) id<GTNormalTableViewCellDelegate> delegate;

- (void)layoutTableViewCell; // 暴露这个方法，每次给tableView布局时调用

@end

NS_ASSUME_NONNULL_END
