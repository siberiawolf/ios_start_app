//
//  GTDetailViewController.m
//  SampleApp
//
//  Created by mac on 2020/5/5.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTDetailViewController.h"
#import <WebKit/WebKit.h>
#import "GTScreen.h"
#import "GTMediator.h"

@interface GTDetailViewController ()<WKNavigationDelegate>
@property (nonatomic, strong, readwrite) WKWebView *webView;
@property (nonatomic, strong, readwrite) UIProgressView *progressView;
@property (nonatomic, strong, readwrite) NSString *articleUrl;

@end

@implementation GTDetailViewController

+ (void)load {
    [GTMediator registerScheme:@"detail://" processBlock:^(NSDictionary *_Nonnull params) {
        NSString *url = (NSString *)[params objectForKey:@"url"];
        UINavigationController *navigationController = (UINavigationController *)[params objectForKey:@"controller"];

        GTDetailViewController *controller = [[GTDetailViewController alloc] initWithUrlString:url];
        
        [navigationController pushViewController:controller animated:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:({
        // 因为头部会有留海，所以在计算高度时候，需要将头部的高度减去
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT + 44, self.view.frame.size.width, self.view.frame.size.height - STATUSBARHEIGHT - 44)];
        self.webView.navigationDelegate = self;
        self.webView;
    })];

    // webView加载进度条
    [self.view addSubview:({
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT + 44, self.view.frame.size.width, 20)];
        self.progressView;
    })];

    // 加载极客时间的网址
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.articleUrl]]];

    // 监听：self.webview
    // 监听者： self
    // 监听属性：estimatedProgress
    // 监听状态：NSKeyValueObservingOptionNew 有新的的变化时
    // 不需要传参：nil
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

// 是否允许加载
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow); // 允许加载webview
}

// webView加载结束
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"webView加载结束");
}

// 移除监听
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

// 点击列表时，传递详情页URL
- (instancetype)initWithUrlString:(NSString *)urlString {
    self = [super init];
    if (self) {
        self.articleUrl = urlString;
    }
    return self;
}

// 监听者回调
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    // 设置webView进度条状态给progressView
    self.progressView.progress = self.webView.estimatedProgress;

//    NSLog(@"observeValueForKeyPath");
}

@end
