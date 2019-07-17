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
    
    [self.webView loadUrl:@"http://0.0.0.0:8080"];
    
    NSLog(@"%@",[NSValue valueWithCGRect:[UIScreen mainScreen].bounds]);
    
}

@end
