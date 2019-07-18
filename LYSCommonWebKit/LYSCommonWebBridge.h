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

/**
 通过bridge文件完成交互,可以给window添加对象,然后调用window.对象.方法 模式,实现交互
 */
@property (nonatomic, copy) NSString *extendName;

/**
 通过bridge文件完成交互,在window上绑定一个办法,当window调用这个方法的时候,出发SEL事件

 @param action SEL事件
 @param target SEL事件所在对象
 @param name 方法名
 */
- (void)ly_addAsynAction:(SEL)action target:(id)target name:(NSString *)name;

/**
 通过bridge文件完成交互,如果你不想使用某个方法,可以根据方法名移除

 @param name 方法名
 */
- (void)ly_removeAsynActionWithName:(NSString *)name;

/**
 通过bridge文件完成交互时,原生完成相关操作之后,调用这个方法给H5回传数据,数据放到response
 
 @param response 数据
 @param success 状态
 @param message 信息描述
 @param bridge 桥梁对象
 */
- (void)ly_evaluateResponse:(NSDictionary *)response success:(BOOL)success message:(NSString *)message bridge:(LYSBridgeInfo *)bridge;

@end

NS_ASSUME_NONNULL_END
