//
//  LYSCommonWebWindow.m
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/17.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWebWindow.h"

@interface LYSCommonWebWindow ()

@property (nonatomic, strong) NSMutableDictionary *callActionDict;
@property (nonatomic, strong) NSMutableArray *extendNameArr;

@end

@implementation LYSCommonWebWindow

- (NSMutableDictionary *)callActionDict
{
    if (!_callActionDict) {
        _callActionDict = [NSMutableDictionary dictionary];
    }
    return _callActionDict;
}

- (NSMutableArray *)extendNameArr
{
    if (!_extendNameArr) {
        _extendNameArr = [NSMutableArray array];
    }
    return _extendNameArr;
}

- (void)rulesWithWebView:(UIWebView *)webView
{
    [super rulesWithWebView:webView];
    for (int i =0; i < [self.extendNameArr count]; i++) {
        NSString *key = [self.extendNameArr objectAtIndex:i];
        self.context[key] = self;
    }
    for (NSString *name in self.callActionDict) {
        NSInvocation *invocation = [self.callActionDict objectForKey:name];
        self.context[name] = ^(id obj)
        {
#ifdef DEBUG
            NSLog(@"传递参数%@",obj);
#endif
            id retrunvalue = nil;
            [invocation setArgument:&obj atIndex:2];
            [invocation invoke];
            if (invocation.methodSignature.methodReturnLength != 0) {
                [invocation getReturnValue:&retrunvalue];
            }
            return retrunvalue;
        };
    }
}

- (void)addAction:(SEL)action target:(id)target name:(NSString *)name
{
    NSMethodSignature *signature = [self methodSignatureForSelector:action];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = target;
    invocation.selector = action;
    if (self.context) {
        self.context[name] = ^(id obj)
        {
#ifdef DEBUG
            NSLog(@"传递参数%@",obj);
#endif
            id retrunvalue = nil;
            [invocation setArgument:&obj atIndex:2];
            [invocation invoke];
            if (invocation.methodSignature.methodReturnLength != 0) {
                [invocation getReturnValue:&retrunvalue];
            }
            return retrunvalue;
        };
    } else {
        [self.callActionDict setObject:invocation forKey:name];
    }
}

- (void)addExtendName:(NSString *)extendName
{
    if (self.context) {
        self.context[extendName] = self;
    } else {
        [self.extendNameArr addObject:extendName];
    }
}

@end
