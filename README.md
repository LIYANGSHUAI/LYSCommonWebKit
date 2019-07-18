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
实现alert弹窗拦截
```objc
// 实现如下协议
@protocol LYSCommonWebJavaScriptDelegate <NSObject>

- (void)ly_webView:(LYSCommonWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect *)frame;
- (BOOL)ly_webView:(LYSCommonWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect *)frame;

@end
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

方式二:
```objc
// iOS端代码
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
    
    self.webView.extendName = @"ios";
    [self.webView ly_addAsynAction:@selector(addValue:) target:self name:@"addValue"];
    
}

- (void)addValue:(LYSBridgeInfo *)info
{
    NSLog(@"收到响应数据: %@",info.allParms);
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
        console.log(JSON.stringify(res))
      }, {
        params: 'vue  to  ios!!!'
      })
```
```objc
// iOS端打印
2019-07-18 14:48:12.842 LYSCommonWebKitDemo[6503:196164] 收到响应数据: {
    bridgeName = addValue;
    callbackId = 2;
    parms =     {
        params = "vue  to  ios!!!";
    };
}
```
```js
// js端代码
{"data":{"result":"ios  to  vue!!"},"success":true,"message":"success!"}
```
方式三
```objc
// iOS 端代码
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
    
    [self.webView ly_addAction:@selector(addValue:) target:self name:@"addValue"];
    
}

- (id)addValue:(id)obj
{
    NSLog(@"收到响应数据: %@", obj);
    return @{
             @"result": @"ios  to vue!!!"
             };
}
```
```js
// js端代码
console.log(window.addValue('vue  to  ios!!'))
```
```objc
// iOS 端打印
收到响应数据: vue  to  ios!!
```

```js
// js端打印
{result: "ios  to vue!!!"}
```
方式四
```objc
// iOS 端代码
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
```
```js
// js端代码
console.log(window.ios.addValue('vue  to  ios!!'))
```
```objc
// iOS 端打印
收到响应数据: vue  to  ios!!
```
```js
// js端打印
{result: "ios  to vue!!!"}
```
bridge文件内容
```js
(function () {
  var _this = this
  var id = 1
  var callbacks = {}
  window.JsBridgeInvoke = function (result) {
    var callbackId = result.callbackId
    var data = result.data
    var success = result.success
    var message = result.message
    if (callbackId) {
      if (callbacks[callbackId]) {
        callbacks[callbackId]({data: data, success: success, message: message})
      }
    }
    return _this
  }
  window.JsBridgeBind = function (bridgeName, callback, params) {
    var msg = {success: false, data: null}
    if (typeof callback !== 'function') {
      return
    }
    if (!window.android && !window.ios) {
      msg.message = 'API不存在!!'
      callback(msg)
      return
    }
    id += 1
    callbacks[id] = callback
    var data = {bridgeName: bridgeName, data: params || {}, callbackId: id}
    if (Object.prototype.hasOwnProperty.call(window, 'ios')) {
      window.ios.callNativeBridgeApi(data)
    } else {
      if (Object.prototype.hasOwnProperty.call(window, 'android')) {
        window.android.callNativeBridgeApi(JSON.stringify(data))
      }
    }
  }
})()
```

