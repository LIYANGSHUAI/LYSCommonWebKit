//
//  ViewController.m
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/17.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "ViewController.h"
#import "LYSCommonWeb.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol LYSCommonWebKitActionDelegate <JSExport>

- (id)addValue:(id)obj;

@end

@interface ViewController ()<LYSCommonWebKitActionDelegate,LYSCommonLifeDelegate>
@property (nonatomic, strong) LYSCommonWeb *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.webView = [[LYSCommonWeb alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    
    if (@available(iOS 11.0, *)) {
        self.webView.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.webView ly_loadUrl:@"http://www.baidu.com"];
    
    [self.webView ly_addExtendName:@"ios" target:self];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webView ly_loadUrl:@"http://www.baidu.com"];
    });
    
}

- (void)webViewDidFinishOnceLoad:(LYSCommonWeb *)webView
{
    NSLog(@"第一次!");
}

- (void)webViewDidFinishLoad:(LYSCommonWeb *)webView
{
    NSLog(@"成功!!!");
}

- (void)webView:(LYSCommonWeb *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (id)addValue:(id)obj
{
    NSLog(@"收到响应数据: %@", obj);
    return @{
             @"result": @"ios  to vue!!!"
             };
}

@end
