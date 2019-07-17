//
//  LYSCommonWebBridge.m
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/17.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWebBridge.h"

@interface LYSCommonWebBridge ()

@property (nonatomic, strong) NSMutableDictionary *actionDict;

@end

@implementation LYSCommonWebBridge

- (NSMutableDictionary *)actionDict
{
    if (!_actionDict) {
        _actionDict = [NSMutableDictionary dictionary];
    }
    return _actionDict;
}

- (void)rulesWithWebView:(UIWebView *)webView
{
    [super rulesWithWebView:webView];
    if (self.extendName) {
        self.context[self.extendName] = self;
    } else {
        __weak LYSCommonWebBridge *WeakSelf = self;
        self.context[LYScallNativeBridgeApiName] = ^(id obj)
        {
#ifdef DEBUG
            NSLog(@"传递参数%@",obj);
#endif
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *bridgeName = obj[@"bridgeName"];
                NSString *callbackId = obj[@"callbackId"];
                id data = obj[@"data"];
                LYSBridgeInfo *model = [[LYSBridgeInfo alloc] initWithBridgeName:bridgeName callbackId:callbackId parms:data];
                [WeakSelf addBridge:model];
                [WeakSelf didCallNativeBridgeApi:model];
            });
        };
    }
}

- (void)callNativeBridgeApi:(id)obj
{
#ifdef DEBUG
    NSLog(@"传递参数%@",obj);
#endif
    __weak LYSCommonWebBridge *WeakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *bridgeName = obj[@"bridgeName"];
        NSString *callbackId = obj[@"callbackId"];
        id data = obj[@"data"];
        LYSBridgeInfo *model = [[LYSBridgeInfo alloc] initWithBridgeName:bridgeName callbackId:callbackId parms:data];
        [WeakSelf addBridge:model];
        [WeakSelf didCallNativeBridgeApi:model];
    });
}

- (void)didCallNativeBridgeApi:(LYSBridgeInfo *)bridge
{
    NSInvocation *invocation = [self.actionDict objectForKey:bridge.bridgeName];
    [invocation setArgument:&bridge atIndex:2];
    [invocation invoke];
}

- (void)addAsynAction:(SEL)action target:(id)target name:(NSString *)name
{
    NSMethodSignature *signature = [self methodSignatureForSelector:action];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = target;
    invocation.selector = action;
    [self.actionDict setObject:invocation forKey:name];
}

- (void)removeAsynActionWithName:(NSString *)name
{
    [self.actionDict removeObjectForKey:name];
}

@end
