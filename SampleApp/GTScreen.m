//
//  GTScreen.m
//  SampleApp
//
//  Created by mac on 2020/5/15.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTScreen.h"

@implementation GTScreen

// iphone xs max
+ (CGSize)sizeFor65Inch{
    return CGSizeMake(414,896);
}

// iphone xr
+ (CGSize)sizeFor61Inch{
    return CGSizeMake(414,896);
}

// iphonex
+ (CGSize)sizeFor58Inch{
    return CGSizeMake(375,812);
}
@end
