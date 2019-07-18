//
//  UIView+LYSCommonWebKit.m
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/18.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "UIView+LYSCommonWebKit.h"

@implementation UIView (LYSCommonWebKit)
- (NSMutableArray *)ly_getTopSubViews
{
    NSMutableArray *stack = [NSMutableArray array];
    NSMutableArray *leafNodes = [NSMutableArray array];
    if (self.subviews.count == 0) {return nil;}
    [stack addObjectsFromArray:self.subviews];
    while (stack.count != 0)
    {
        UIView *subView = [stack lastObject];
        [stack removeLastObject];
        if (subView.subviews.count != 0)
        {
            [stack addObjectsFromArray:subView.subviews];
        }else
        {
            [leafNodes addObject:subView];
        }
    }
    return leafNodes;
}

- (UIViewController *)ly_getRootViewController
{
    UIResponder *res = self;
    while (res) {
        if (res.nextResponder)
        {
            res = res.nextResponder;
        }
        if ([res isKindOfClass:[UIViewController class]])
        {
            UIViewController *vc = (UIViewController*)res;
            return vc;
        }
    }
    return nil;
}
@end
