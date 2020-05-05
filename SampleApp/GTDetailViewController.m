//
//  GTDetailViewController.m
//  SampleApp
//
//  Created by mac on 2020/5/5.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTDetailViewController.h"
#import <WebKit/WebKit.h>

@interface GTDetailViewController ()<WKNavigationDelegate>
@property (nonatomic, strong, readwrite) WKWebView *webView;

@end

@implementation GTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:({
        // 因为头部会有留海，所以在计算高度时候，需要将头部的高度减去
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height - 88)];
        self.webView.navigationDelegate = self;
        self.webView;
    })];
    
    // 加载极客时间的网址
    [self.webView loadRequest: [NSURLRequest requestWithURL: [NSURL URLWithString:@"https://time.geekbang.org/"]]];
}

// 是否允许加载
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow); // 允许加载webview
}

// webView加载结束
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"webView加载结束");
}

@end
