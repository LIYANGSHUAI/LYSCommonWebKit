//
//  LYSCommonWebView.h
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/18.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LYSCommonWebView;
@protocol LYSCommonWebJavaScriptDelegate <NSObject>

- (void)ly_webView:(LYSCommonWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect *)frame;
- (BOOL)ly_webView:(LYSCommonWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect *)frame;

@end

@interface LYSCommonWebView : UIWebView

@property (nonatomic, assign) id<LYSCommonWebJavaScriptDelegate> jsDelegate;

@end

NS_ASSUME_NONNULL_END
