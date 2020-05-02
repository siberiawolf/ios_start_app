//
//  GTRecommendViewController.m
//  SampleApp
//
//  Created by mac on 2020/5/2.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTRecommendViewController.h"

@interface GTRecommendViewController ()

@end

@implementation GTRecommendViewController

- (instancetype)init{
    self = [super init];
    if(self){
        self.tabBarItem.title = @"推荐";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/like@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/like_selected@2x.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 定义一个和屏幕大小一样的scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 5, self.view.bounds.size.height); // 设置一个宽是5倍屏幕的ScrollView
    scrollView.showsHorizontalScrollIndicator = NO; // 禁止使用水平滚动条
    
    NSArray *colorArray = @[[UIColor redColor],[UIColor blueColor],[UIColor greenColor],[UIColor grayColor],[UIColor lightGrayColor]];
    
    // 实现水平分页效果
    scrollView.pagingEnabled = YES;
    for (int i = 0; i < 5; i++) {
        [scrollView addSubview:({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(scrollView.bounds.size.width * i, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
            view.backgroundColor = [colorArray objectAtIndex:i]; 
            view;
        })];
    }
    
    [self.view addSubview:scrollView];
    
}



@end
