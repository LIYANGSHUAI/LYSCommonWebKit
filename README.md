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
问题一:

```objc

```
