# LYSCommonWebKit
解决开发中,H5与原生混合过程中,js和原生交互繁琐,逻辑复杂,频繁交换数据的问题

解决下移20像素问题:
```objc
if (@available(iOS 11.0, *)) {
self.webView.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
} else {
self.automaticallyAdjustsScrollViewInsets = NO;
}
```
方式一:

```objc
// ios 端代码
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
    // 模拟异步操作,延迟两秒回传数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webView ly_evaluateResponse:@{
                                         @"result": @"ios  to  vue!!"
                                         } success:YES message:@"success!" bridge:info];
    });
}
```
```js
// js端代码
window.JsBridgeBind('addValue', function (res) {
        alert(JSON.stringify(res))
      }, {
        params: 'vue  to  ios!!!'
      })
```

```objc
// iOS 端打印
2019-07-18 14:42:03.312 LYSCommonWebKitDemo[6458:193628] 收到响应数据: {
    bridgeName = addValue;
    callbackId = 2;
    parms =     {
        params = "vue  to  ios!!!";
    };
}
```
```js
// js端打印
{"data":{"result":"ios  to  vue!!"},"success":true,"message":"success!"}
```

