//
//  LYSCommonWebBridge.h
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/17.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWebAPI.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LYSCommonWebBridgeDelegate <JSExport>
@required
- (void)callNativeBridgeApi:(id)obj;
@end

@interface LYSCommonWebBridge : LYSCommonWebAPI<LYSCommonWebBridgeDelegate>

@property (nonatomic, copy) NSString *extendName;
- (void)addAsynAction:(SEL)action target:(id)target name:(NSString *)name;
- (void)removeAsynActionWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
