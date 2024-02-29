//
//  WebViewController.m
//  GrayDealDemo
//
//  Created by zl on 2024/2/29.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WebViewController

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        _webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:wkWebConfig];
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}




@end
