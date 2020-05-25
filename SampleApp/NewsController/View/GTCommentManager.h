//
//  GTCommentManager.h
//  SampleApp
//
//  Created by mac on 2020/5/25.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTCommentManager : NSObject

+ (GTCommentManager *)sharedManager;

- (void) showCommentView;

@end

NS_ASSUME_NONNULL_END
