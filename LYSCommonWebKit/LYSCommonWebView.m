//
//  LYSCommonWebView.m
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/18.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWebView.h"
#import "UIView+LYSCommonWebKit.h"

@implementation LYSCommonWebView

- (void)webView:(LYSCommonWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect *)frame
{
    if (self.jsDelegate && [self.jsDelegate respondsToSelector:@selector(ly_webView:runJavaScriptAlertPanelWithMessage:initiatedByFrame:)]) {
        [self.jsDelegate ly_webView:sender runJavaScriptAlertPanelWithMessage:message initiatedByFrame:frame];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:nil];
        [alert addAction:action];
        [[LYSCommonWebView ly_getOuterViewController] presentViewController:alert animated:YES completion:nil];
    }
}
- (BOOL)webView:(LYSCommonWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect *)frame
{
    if (self.jsDelegate && [self.jsDelegate respondsToSelector:@selector(ly_webView:runJavaScriptConfirmPanelWithMessage:initiatedByFrame:)]) {
        return [self.jsDelegate ly_webView:sender runJavaScriptConfirmPanelWithMessage:message initiatedByFrame:frame];
    }
    return NO;
}
+ (UIViewController *)ly_getOuterViewController
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSMutableArray *array = [keyWindow ly_getTopSubViews];
    UINavigationController *nav = nil;
    UITabBarController *tab = nil;
    for (UIView *subView in array) {
        UIViewController *vc = [subView ly_getRootViewController];
        if (!([vc isKindOfClass:[UINavigationController class]] || [vc isKindOfClass:[UITabBarController class]]))
        {
            return vc;
        }
        if ([vc isKindOfClass:[UINavigationController class]])
        {
            nav = (UINavigationController *)vc;
        }
        if ([vc isKindOfClass:[UITabBarController class]])
        {
            tab = (UITabBarController *)vc;
        }
    }
    if (nav) {return nav;}
    if (tab) {return tab;}
    return nil;
}
@end
