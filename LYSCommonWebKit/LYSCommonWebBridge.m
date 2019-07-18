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

- (void)ly_addAsynAction:(SEL)action target:(id)target name:(NSString *)name
{
    NSMethodSignature *signature = [target methodSignatureForSelector:action];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = target;
    invocation.selector = action;
    [self.actionDict setObject:invocation forKey:name];
}

- (void)ly_removeAsynActionWithName:(NSString *)name
{
    if ([[self.actionDict allKeys] containsObject:name]) {
        [self.actionDict removeObjectForKey:name];
    }
}

- (void)ly_evaluateResponse:(NSDictionary *)response success:(BOOL)success message:(NSString *)message bridge:(LYSBridgeInfo *)bridge
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray<LYSBridgeInfo *> *tempAry = [self getBridgesWith:bridge.bridgeName];
        for (LYSBridgeInfo *model in tempAry)
        {
            NSData *dictData = [NSJSONSerialization dataWithJSONObject:@{
                                                                         @"bridgeName":model.bridgeName,
                                                                         @"message":message,
                                                                         @"success":@(success),
                                                                         @"data":response,
                                                                         @"callbackId":model.callbackId
                                                                         } options:(NSJSONWritingPrettyPrinted) error:nil];
            NSString *dictStr = [[NSString alloc] initWithData:dictData encoding:NSUTF8StringEncoding];
            NSString *textJS = [NSString stringWithFormat:@"%@(%@)",LYSJsBridgeInvokeName,dictStr];
            [self.context evaluateScript:textJS];
            [self removeBridge:model];
        }
    });
}


@end
