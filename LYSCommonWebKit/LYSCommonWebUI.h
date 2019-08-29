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

@class LYSBridgeInfo;

@protocol LYSCommonLifeDelegate <NSObject>

@optional
- (void)webViewDidLoad;
- (void)webViewDidFailWithError:(NSError *)errror;

@end

@protocol LYSCommonWebAPIDelegate <NSObject>

@optional
- (void)rulesWithWebView:(UIWebView *)webView;
- (void)didCallNativeBridgeApi:(LYSBridgeInfo *)bridge;

@end

@interface LYSCommonWebUI : UIView<LYSCommonWebAPIDelegate>

@property (nonatomic, assign) id<LYSCommonLifeDelegate> delegate;

@property (nonatomic, strong, readonly) LYSCommonWebView *webView;
@property (nonatomic, assign) id<LYSCommonWebJavaScriptDelegate> jsDelegate;
@property (nonatomic, strong, readonly) JSContext *context;

/**
 加载网页地址

 @param urlStr 网页url
 */
- (void)ly_loadUrl:(NSString *)urlStr;

@end

NS_ASSUME_NONNULL_END
