//
//  ZHWKWebViewTestViewController.m
//  AppDemo
//
//  Created by Terry Chao on 2017/7/13.
//  Copyright © 2017年 czh. All rights reserved.
//

#import "ZHWKWebViewTestViewController.h"
#import <WebKit/WebKit.h>

@interface ZHWKWebViewTestViewController () <WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation ZHWKWebViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"WKWebView";
    
//    [self.navigationController setNavigationBarHidden:YES];
//    [self test];
//    [self addScriptMessageHandler];
    
    NSString *abc = @"你a好b";
    NSLog(@"字符长度 %lu, %lu", [self convertToInt:abc], abc.length);
    
    void (^DemoBlock)(void) = ^{
        NSLog(@"DemoBlock");
    };
    NSLog(@"%@",DemoBlock);
    
    int a = 6;
    //__NSStackBlock__ 栈区 (内部使用了外部变量)(MRC模式下)
    void (^DemoBlock2)(void) = ^{
        NSLog(@"DemoBlock2 %d",a);
    };
    NSLog(@"DemoBlock2 %@",DemoBlock2);
    
    //__NSMallocBlock__ 堆区 ([DemoBlock2 copy]后Block存放在堆区)
    NSLog(@"DemoBlock2.Copy %@",[DemoBlock2 copy]);
    
    void (^DemoBLock3)(void) = [DemoBlock2 copy];
    NSLog(@"DemoBlock3 %@",DemoBLock3);
    
}

- (NSInteger)convertToInt:(NSString *)strtemp
{
    NSInteger strlength = 0;
    NSInteger length = [strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding];
    char *p = (char *)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < length; i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
        
    }
    return strlength;
}

- (void)test
{
    //    [self loadRequest];
    //    [self loadHTMLString];
//    [self loadHTMLStringWithFile];
    [self loadPdf];
}

- (IBAction)buttonClick:(id)sender {
    [self test];
}

- (WKWebView *)webView
{
    if (!_webView) {
        CGRect rect = [UIScreen mainScreen].bounds;
        _webView = [[WKWebView alloc] initWithFrame:rect];
        
        // 图片缩放的js代码
//        NSString *js = @"var count = document.images.length;for (var i = 0; i < count; i++) {var image = document.images[i];image.style.width=320;};window.alert('找到' + count + '张图');";
//        // 根据JS字符串初始化WKUserScript对象
//        WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//        // 根据生成的WKUserScript对象，初始化WKWebViewConfiguration
//        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//        [config.userContentController addUserScript:script];
//        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
//        [_webView loadHTMLString:@"<head></head><imgea src='http://www.nsu.edu.cn/v/2014v3/img/background/3.jpg' />"baseURL:nil];
        
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        [self.view insertSubview:_webView atIndex:0];
    }
    return _webView;
}

#pragma mark - load html

- (void)loadRequest
{
    NSString *urlString = @"https://test.grtn.cn/web/pay/index.html?uid=40000077&token=TkRBd01EQXdOemZDcDNGeGNYRnhjY0tuTVRVd01EVTFOemd4T1RNek5BPT0=&platform=1&mobileType=iOS%2520iPhone%25206s%2520Plus%252010.3.2";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:urlRequest];
}

- (void)loadHTMLString
{
    NSString *HTMLString = @"<hn>Hello world.</hn>";
    [self.webView loadHTMLString:HTMLString baseURL:nil];
}

- (void)loadHTMLStringWithFile
{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:@"test.html"];
    NSError *error;
    NSString *HTMLString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"open file error %@", error);
        return;
    }
    [self.webView loadHTMLString:HTMLString baseURL:[[NSBundle mainBundle] bundleURL]];
}

- (void)loadPdf
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"17.编程珠玑（第二版）中文版" ofType:@"pdf"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    [self.webView loadData:fileData MIMEType:@"application/pdf" characterEncodingName:@"UTF-8" baseURL:[[NSBundle mainBundle] bundleURL]];
}

- (void)addScriptMessageHandler
{
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"zliveViewUserInfo"];
//    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"appInerPay"];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog(@"%@, webView %@, navigationAction %@, ", NSStringFromSelector(_cmd), webView, navigationAction);
    decisionHandler(WKNavigationActionPolicyAllow);
}

//开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

//当内容开始返回时调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


#pragma mark - WKScriptMessageHandler

// 支持 https
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *credential = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
    }
}


#pragma mark - WKUIDelegate

//Alert弹框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message ? : @"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"%@, message %@", NSStringFromSelector(_cmd), message.body);
}


@end
