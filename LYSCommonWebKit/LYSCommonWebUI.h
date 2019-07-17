//
//  LYSCommonWebUI.h
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/17.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN

@class LYSBridgeInfo;

@protocol LYSCommonWebAPIDelegate <NSObject>

@optional
- (void)rulesWithWebView:(UIWebView *)webView;
- (void)didCallNativeBridgeApi:(LYSBridgeInfo *)bridge;

@end

@interface LYSCommonWebUI : UIView<LYSCommonWebAPIDelegate>

@property (nonatomic, strong, readonly) UIWebView *webView;
@property (nonatomic, strong, readonly) JSContext *context;

- (void)loadUrl:(NSString *)urlStr;
@end

NS_ASSUME_NONNULL_END
