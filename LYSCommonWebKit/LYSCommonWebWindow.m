//
//  LYSCommonWebWindow.m
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/17.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWebWindow.h"
#import <objc/runtime.h>

@interface LYSCommonWebWindow ()

@property (nonatomic, strong) NSMutableDictionary *callActionDict;
@property (nonatomic, strong) NSMutableDictionary *extendNameDict;
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

- (NSMutableDictionary *)extendNameDict
{
    if (!_extendNameDict) {
        _extendNameDict = [NSMutableDictionary dictionary];
    }
    return _extendNameDict;
}

- (void)rulesWithWebView:(UIWebView *)webView
{
    [super rulesWithWebView:webView];
    for (int i =0; i < [self.extendNameDict.allValues count]; i++) {
        NSDictionary *dict = [self.extendNameDict.allValues objectAtIndex:i];
        self.context[dict[@"extendName"]] = dict[@"target"];
    }
    for (NSString *name in self.callActionDict) {
        NSInvocation *invocation = [self.callActionDict objectForKey:name];
        NSInteger argNum = [objc_getAssociatedObject(invocation, (__bridge const void *)(@"argNum")) integerValue];
        switch (argNum) {
            case 0:
            {
                self.context[name] = ^()
                {
                    void *retrunValue = NULL;
                    [invocation invoke];
                    if (invocation.methodSignature.methodReturnLength != 0) {
                        [invocation getReturnValue:&retrunValue];
                    }
                    return (__bridge id)retrunValue;
                };
            }
                break;
            case 1:
            {
                self.context[name] = ^(id obj)
                {
                    void *retrunValue = NULL;
                    [invocation setArgument:&obj atIndex:2];
                    [invocation invoke];
                    if (invocation.methodSignature.methodReturnLength != 0) {
                        [invocation getReturnValue:&retrunValue];
                    }
                    return (__bridge id)retrunValue;
                };
            }
                break;
            case 2:
            {
                self.context[name] = ^(id obj1, id obj2)
                {
                    void *retrunValue = NULL;
                    [invocation setArgument:&obj1 atIndex:2];
                    [invocation setArgument:&obj2 atIndex:3];
                    [invocation invoke];
                    if (invocation.methodSignature.methodReturnLength != 0) {
                        [invocation getReturnValue:&retrunValue];
                    }
                    return (__bridge id)retrunValue;
                };
            }
                break;
            case 3:
            {
                self.context[name] = ^(id obj1, id obj2, id obj3)
                {
                    void *retrunValue = NULL;
                    [invocation setArgument:&obj1 atIndex:2];
                    [invocation setArgument:&obj2 atIndex:3];
                    [invocation setArgument:&obj3 atIndex:4];
                    [invocation invoke];
                    if (invocation.methodSignature.methodReturnLength != 0) {
                        [invocation getReturnValue:&retrunValue];
                    }
                    return (__bridge id)retrunValue;
                };
            }
                break;
            default:
                break;
        }
    }
}

- (void)ly_addAction:(SEL)action target:(id)target argNum:(NSInteger)argNum name:(NSString *)name
{
    NSMethodSignature *signature = [target methodSignatureForSelector:action];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    objc_setAssociatedObject(invocation, (__bridge const void *)(@"argNum"), @(argNum), OBJC_ASSOCIATION_ASSIGN);
    invocation.target = target;
    invocation.selector = action;
    if (self.context) {
        switch (argNum) {
            case 0:
            {
                self.context[name] = ^()
                {
                    void *retrunValue = NULL;
                    [invocation invoke];
                    if (invocation.methodSignature.methodReturnLength != 0) {
                        [invocation getReturnValue:&retrunValue];
                    }
                    return (__bridge id)retrunValue;
                };
            }
                break;
            case 1:
            {
                self.context[name] = ^(id obj)
                {
                    void *retrunValue = NULL;
                    [invocation setArgument:&obj atIndex:2];
                    [invocation invoke];
                    if (invocation.methodSignature.methodReturnLength != 0) {
                        [invocation getReturnValue:&retrunValue];
                    }
                    return (__bridge id)retrunValue;
                };
            }
                break;
            case 2:
            {
                self.context[name] = ^(id obj1, id obj2)
                {
                    void *retrunValue = NULL;
                    [invocation setArgument:&obj1 atIndex:2];
                    [invocation setArgument:&obj2 atIndex:3];
                    [invocation invoke];
                    if (invocation.methodSignature.methodReturnLength != 0) {
                        [invocation getReturnValue:&retrunValue];
                    }
                    return (__bridge id)retrunValue;
                };
            }
                break;
            case 3:
            {
                self.context[name] = ^(id obj1, id obj2, id obj3)
                {
                    void *retrunValue = NULL;
                    [invocation setArgument:&obj1 atIndex:2];
                    [invocation setArgument:&obj2 atIndex:3];
                    [invocation setArgument:&obj3 atIndex:4];
                    [invocation invoke];
                    if (invocation.methodSignature.methodReturnLength != 0) {
                        [invocation getReturnValue:&retrunValue];
                    }
                    return (__bridge id)retrunValue;
                };
            }
                break;
            default:
                break;
        }
    } else {
        [self.callActionDict setObject:invocation forKey:name];
    }
}

- (void)ly_removeActionWithName:(NSString *)name
{
    if ([[self.callActionDict allKeys] containsObject:name]) {
        self.context[name] = nil;
        [self.callActionDict removeObjectForKey:name];
    }
}

- (void)ly_addExtendName:(NSString *)extendName target:(id)target
{
    if (self.context) {
        self.context[extendName] = target;
    } else {
        [self.extendNameDict setObject:@{
                                         @"extendName": extendName,
                                         @"target": target
                                         } forKey:extendName];
    }
}

- (void)ly_removeExtendName:(NSString *)extendName
{
    if ([[self.extendNameDict allKeys] containsObject:extendName]) {
        self.context[extendName] = nil;
        [self.extendNameDict removeObjectForKey:extendName];
    }
}

- (void)ly_evaluateResponse:(NSDictionary *)response name:(NSString *)name
{
    NSData *dictData = [NSJSONSerialization dataWithJSONObject:response options:(NSJSONWritingPrettyPrinted) error:nil];
    NSString *dictStr = [[NSString alloc] initWithData:dictData encoding:NSUTF8StringEncoding];
    NSString *textJS = [NSString stringWithFormat:@"%@(%@)",name,dictStr];
    if (self.context) {
        [self.context evaluateScript:textJS];
    }
}

@end
