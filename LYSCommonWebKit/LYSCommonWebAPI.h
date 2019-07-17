//
//  LYSCommonWebAPI.h
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/17.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWebUI.h"

NS_ASSUME_NONNULL_BEGIN

#define LYScallNativeBridgeApiName @"callNativeBridgeApi"
#define LYSJsBridgeInvokeName @"JsBridgeInvoke"

@interface LYSBridgeInfo : NSObject

@property (nonatomic, copy)NSString *bridgeName;
@property (nonatomic, copy)NSString *callbackId;
@property (nonatomic, strong)id parms;

@property (nonatomic, strong, readonly)NSDictionary *allParms;

- (instancetype)initWithBridgeName:(NSString *)bridgeName callbackId:(NSString *)callbackId parms:(id)parms;

@end;

@interface LYSCommonWebAPI : LYSCommonWebUI

- (void)addBridge:(LYSBridgeInfo *)bridge;
- (NSArray<LYSBridgeInfo *> *)getBridgesWith:(NSString *)bridgeName;
- (void)removeBridge:(LYSBridgeInfo *)bridge;

@end

NS_ASSUME_NONNULL_END
