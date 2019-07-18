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
        self.context[name] = ^(id obj)
        {
            void *retrunvalue = NULL;
            [invocation setArgument:&obj atIndex:2];
            [invocation invoke];
            
            NSLog(@"%s",invocation.methodSignature.methodReturnType);
            
            if (invocation.methodSignature.methodReturnLength != 0) {
                [invocation getReturnValue:&retrunvalue];
            }
            return (__bridge id)retrunvalue;
        };
    }
}

- (void)ly_addAction:(SEL)action target:(id)target name:(NSString *)name
{
    NSMethodSignature *signature = [target methodSignatureForSelector:action];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = target;
    invocation.selector = action;
    if (self.context) {
        self.context[name] = ^(id obj)
        {
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
