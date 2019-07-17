//
//  LYSCommonWebAPI.m
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/17.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWebAPI.h"

@implementation LYSBridgeInfo

- (instancetype)initWithBridgeName:(NSString *)bridgeName callbackId:(NSString *)callbackId parms:(id)parms
{
    if (self = [super init]) {
        self.bridgeName = bridgeName;
        self.callbackId = callbackId;
        self.parms = parms;
    }
    return self;
}

- (NSDictionary *)allParms
{
    return @{
             @"bridgeName": self.bridgeName,
             @"callbackId": self.callbackId,
             @"parms": self.parms
             };
}

@end

@interface LYSCommonWebAPI ()

@property (nonatomic, strong) NSMutableDictionary *bridgeDict;

@end

@implementation LYSCommonWebAPI

- (NSMutableDictionary *)bridgeDict
{
    if (!_bridgeDict) {
        _bridgeDict = [NSMutableDictionary dictionary];
    }
    return _bridgeDict;
}

- (void)addBridge:(LYSBridgeInfo *)bridge
{
    if ([[self.bridgeDict allKeys] containsObject:bridge.bridgeName]) {
        NSMutableArray *ary = [NSMutableArray arrayWithArray:[self.bridgeDict objectForKey:bridge.bridgeName]];
        [ary addObject:bridge];
        [self.bridgeDict setObject:ary forKey:bridge.bridgeName];
    } else {
        NSMutableArray *ary = [NSMutableArray array];
        [ary addObject:bridge];
        [self.bridgeDict setObject:ary forKey:bridge.bridgeName];
    }
}

- (NSArray<LYSBridgeInfo *> *)getBridgesWith:(NSString *)bridgeName
{
    if ([[self.bridgeDict allKeys] containsObject:bridgeName]) {
        return [NSArray arrayWithArray:[self.bridgeDict objectForKey:bridgeName]];
    } else {
        return @[];
    }
}

- (void)removeBridge:(LYSBridgeInfo *)bridge
{
    if ([[self.bridgeDict allKeys] containsObject:bridge.bridgeName])
    {
        NSMutableArray *ary = [NSMutableArray arrayWithArray:[self.bridgeDict objectForKey:bridge.bridgeName]];
        [ary removeObject:bridge];
        if ([ary count] == 0) {
            [self.bridgeDict removeObjectForKey:bridge.bridgeName];
        } else {
            [self.bridgeDict setObject:ary forKey:bridge.bridgeName];
        }
    }
}

- (void)evaluateResponse:(NSDictionary *)resonse success:(BOOL)success message:(NSString *)message bridge:(LYSBridgeInfo *)bridge
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray<LYSBridgeInfo *> *tempAry = [self getBridgesWith:bridge.bridgeName];
        for (LYSBridgeInfo *model in tempAry)
        {
            NSData *dictData = [NSJSONSerialization dataWithJSONObject:@{
                                                                         @"bridgeName":model.bridgeName,
                                                                         @"message":message,
                                                                         @"success":@(success),
                                                                         @"data":resonse,
                                                                         @"callbackId":model.callbackId
                                                                         } options:(NSJSONWritingPrettyPrinted) error:nil];
            NSString *dictStr = [[NSString alloc] initWithData:dictData encoding:NSUTF8StringEncoding];
#ifdef DEBUG
            NSLog(@"响应参数%@",dictStr);
#endif
            NSString *textJS = [NSString stringWithFormat:@"%@(%@)",LYSJsBridgeInvokeName,dictStr];
            [self.context evaluateScript:textJS];
            [self removeBridge:model];
        }
    });
}

@end
