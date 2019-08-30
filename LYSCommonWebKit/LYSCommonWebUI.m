//
//  LYSCommonWebUI.m
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/17.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWebUI.h"
#import "NSObject+LYSCommonWebKit.h"

@interface LYSCommonWebUI ()<UIWebViewDelegate>

@property (nonatomic, strong, readwrite) LYSCommonWebView *webView;
@property (nonatomic, strong, readwrite) JSContext *context;

@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIView  *hudView;

@end

@implementation LYSCommonWebUI

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCreateJavaScriptContext:) name:@"lys_didCreateJavaScriptContext" object:nil];
    }
    return self;
}

- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[LYSCommonWebView alloc] init];
        _webView.delegate = self;
        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}

- (UIView *)hudView
{
    if (!_hudView) {
        _hudView = [[UIView alloc] init];
    }
    return _hudView;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.layer.cornerRadius = 5;
        _stateLabel.layer.masksToBounds = YES;
        _stateLabel.font = [UIFont systemFontOfSize:16];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.textColor = [UIColor whiteColor];
        _stateLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    return _stateLabel;
}

- (void)setJsDelegate:(id<LYSCommonWebJavaScriptDelegate>)jsDelegate
{
    _jsDelegate = jsDelegate;
    self.webView.jsDelegate = _jsDelegate;
}

- (void)ly_loadUrl:(NSString *)urlStr
{
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    [self addSubview:self.webView];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *w = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_webView]|" options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(_webView)];
    NSArray *h = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_webView]|" options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(_webView)];
    [self addConstraints:w];
    [self addConstraints:h];
}

- (void)rulesWithWebView:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    //    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
}

- (void)didCreateJavaScriptContext:(NSNotification *)notifition
{
    self.context = notifition.userInfo[@"context"];
    [self rulesWithWebView:self.webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {}

- (void)showHUD
{
    self.hudView.alpha = 0;
    [self addSubview:self.hudView];
    [UIView animateWithDuration:0.5 animations:^{
        self.hudView.alpha = 1;
    }];
    self.hudView.translatesAutoresizingMaskIntoConstraints = NO;
    CGFloat w = CGRectGetWidth(self.bounds);
    CGFloat h = CGRectGetHeight(self.bounds);
    CGFloat hud_w = w / 375.0 * 50;
    CGFloat hud_h = w / 375.0 * 50;
    CGFloat top = (h - hud_h) / 2.0;
    CGFloat bottom = (h - hud_h) / 2.0;
    CGFloat left = (w - hud_w) / 2.0;
    CGFloat right = (w - hud_w) / 2.0;
    self.hudView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    self.hudView.layer.cornerRadius = w / 375.0 * 10;
    self.hudView.layer.masksToBounds = YES;
    NSArray *a = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[_hudView]-%f-|",left,right] options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(_hudView)];
    NSArray *b = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[_hudView]-%f-|",top,bottom] options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(_hudView)];
    [self addConstraints:a];
    [self addConstraints:b];
    {
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
        indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        [indicatorView startAnimating];
        [self.hudView addSubview:indicatorView];
        NSArray *a = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[indicatorView]-10-|" options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(indicatorView)];
        NSArray *b = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[indicatorView]-10-|" options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(indicatorView)];
        [self.hudView addConstraints:a];
        [self.hudView addConstraints:b];
    }
}

- (void)hiddenHUD
{
    [UIView animateWithDuration:0.5 animations:^{
        self.hudView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.hudView removeFromSuperview];
    }];
}

- (void)showText:(NSString *)text time:(NSInteger)time
{
    self.stateLabel.alpha = 0;
    [self addSubview:self.stateLabel];
    [UIView animateWithDuration:0.5 animations:^{
        self.stateLabel.alpha = 1;
    }];
    self.stateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *stateStr = text;
    self.stateLabel.text = stateStr;
    CGFloat w = CGRectGetWidth(self.bounds);
    CGFloat h = CGRectGetHeight(self.bounds);
    CGSize size = [stateStr boundingRectWithSize:CGSizeMake(w-40, 100) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    if (size.height < 40) {
        size.height = 40;
    }
    CGFloat bottom = h * .1;
    CGFloat top = h - size.height - bottom;
    NSArray *a = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_stateLabel]-20-|" options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(_stateLabel)];
    NSArray *b = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[_stateLabel]-%f-|",top,bottom] options:(0) metrics:@{} views:NSDictionaryOfVariableBindings(_stateLabel)];
    [self addConstraints:a];
    [self addConstraints:b];
    if (time != 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                self.stateLabel.alpha = 0;
            } completion:^(BOOL finished) {
                [self.stateLabel removeFromSuperview];
            }];
        });
    }
}
- (void)hiddenText
{
    [UIView animateWithDuration:0.5 animations:^{
        self.stateLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [self.stateLabel removeFromSuperview];
    }];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
