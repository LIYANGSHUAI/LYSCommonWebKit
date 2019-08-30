//
//  LYSCommonWebUI.h
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/17.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYSCommonWebView.h"
#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN

@class LYSBridgeInfo,LYSCommonWeb;

@protocol LYSCommonLifeDelegate <NSObject>

@optional
/// 默认只监听第一次加载页面
- (void)webViewDidStartOnceLoad:(LYSCommonWeb *)webView;
- (void)webViewDidFinishOnceLoad:(LYSCommonWeb *)webView;
- (void)webView:(LYSCommonWeb *)webView didFailOnceLoadWithError:(NSError *)error;
- (BOOL)webView:(LYSCommonWeb *)webView shouldStartOnceLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
/// 监听每次页面加载
- (BOOL)webView:(LYSCommonWeb *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidStartLoad:(LYSCommonWeb *)webView;
- (void)webViewDidFinishLoad:(LYSCommonWeb *)webView;
- (void)webView:(LYSCommonWeb *)webView didFailLoadWithError:(NSError *)error;

@end

@protocol LYSCommonWebAPIDelegate <NSObject>

@optional
- (void)rulesWithWebView:(UIWebView *)webView;
- (void)didCallNativeBridgeApi:(LYSBridgeInfo *)bridge;

@end

@interface LYSCommonWebUI : UIView<LYSCommonWebAPIDelegate>

// 监听代理
@property (nonatomic, assign) id<LYSCommonLifeDelegate> delegate;

@property (nonatomic, strong, readonly) LYSCommonWebView *webView;
@property (nonatomic, assign) id<LYSCommonWebJavaScriptDelegate> jsDelegate;
@property (nonatomic, strong, readonly) JSContext *context;

/**
 加载网页地址

 @param urlStr 网页url
 */
- (void)ly_loadUrl:(NSString *)urlStr;

- (void)showHUD;
- (void)hiddenHUD;
- (void)showText:(NSString *)text time:(NSInteger)time;

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
