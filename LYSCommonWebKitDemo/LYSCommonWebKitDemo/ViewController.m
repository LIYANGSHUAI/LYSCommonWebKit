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

@interface ViewController ()<LYSCommonWebKitActionDelegate>
@property (nonatomic, strong) LYSCommonWeb *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.webView = [[LYSCommonWeb alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];

    if (@available(iOS 11.0, *)) {
        self.webView.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.webView ly_loadUrl:@"http://0.0.0.0:8080"];
    
    [self.webView ly_addExtendName:@"ios" target:self];
    
}

- (id)addValue:(id)obj
{
    NSLog(@"收到响应数据: %@", obj);
    return @{
             @"result": @"ios  to vue!!!"
             };
}

@end
