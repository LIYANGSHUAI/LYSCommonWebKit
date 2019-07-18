//
//  UIView+LYSCommonWebKit.h
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/18.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LYSCommonWebKit)
- (NSMutableArray *)ly_getTopSubViews;
- (UIViewController *)ly_getRootViewController;
@end

NS_ASSUME_NONNULL_END
