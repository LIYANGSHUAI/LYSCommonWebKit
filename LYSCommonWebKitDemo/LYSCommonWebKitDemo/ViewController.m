//
//  ViewController.m
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/17.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "ViewController.h"
#import "LYSCommonWeb.h"

@interface ViewController ()
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
    
    [self.webView ly_addAsynAction:@selector(addValue:) target:self name:@"addValue"];
    
}

- (void)addValue:(LYSBridgeInfo *)info
{
    NSLog(@"收到响应数据: %@",info);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webView ly_evaluateResponse:@{
                                         @"result": @"ios  to  vue!!"
                                         } success:YES message:@"success!" bridge:info];
    });
}

@end
