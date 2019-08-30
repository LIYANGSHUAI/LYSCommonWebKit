//
//  LYSCommonWeb.m
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/17.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWeb.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface LYSCommonWeb ()<UIWebViewDelegate>
@property (nonatomic, assign) BOOL monitorEnable;
@end

@implementation LYSCommonWeb

- (void)ly_loadUrl:(NSString *)urlStr
{
    [super ly_loadUrl:urlStr];
    if (self.monitorEnable==NO) {
        [self showHUD];
        self.monitorEnable = YES;
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (self.monitorEnable) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(webView:shouldStartOnceLoadWithRequest:navigationType:)]) {
            return [self.delegate webView:self shouldStartOnceLoadWithRequest:request navigationType:navigationType];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        return [self.delegate webView:self shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [super webViewDidStartLoad:webView];
    if (self.monitorEnable) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(webViewDidStartOnceLoad:)]) {
            [self.delegate webViewDidStartOnceLoad:self];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.delegate webViewDidStartLoad:self];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    [self hiddenHUD];
    NSLog(@"success load WebView!!");
    if (self.monitorEnable) {
        self.monitorEnable = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(webViewDidFinishOnceLoad:)]) {
            [self.delegate webViewDidFinishOnceLoad:self];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.delegate webViewDidFinishLoad:self];
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [super webView:webView didFailLoadWithError:error];
    NSLog(@"error, fail loadWebView");
    [self hiddenHUD];
    [self showText:error.localizedDescription time:2];
    if (self.monitorEnable) {
        self.monitorEnable = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(webView:didFailOnceLoadWithError:)]) {
            [self.delegate webView:self didFailOnceLoadWithError:error];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.delegate webView:self didFailLoadWithError:error];
    }
}

@end
