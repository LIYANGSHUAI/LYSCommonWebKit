//
//  LYSCommonWebWindow.h
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/17.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSCommonWebBridge.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYSCommonWebWindow : LYSCommonWebBridge

/**
 可以给window绑定一个对象,同时让这个对象遵循JSExport协议,协议里面的方法就能被window发现,并调用
(建议: 所有交互传参,尽量用json进行包装,避免出现意想不到的错误)
 
 // protocol WebDelegate <JSExport>   // 协议方法必须@required类型否则不触发
 // - (id)addValue:(id)obj;
 // end
 // interface ViewController : UIViewController<WebDelegate>
 // end
 // 如上,ViewController遵循WebDelegate协议,同时在.m文件里面实现- (id)addValue:(id)obj;方法,当window.extendName.addValue()就可以完成调用
 
 @param extendName 对象名
 @param target 关联对象
 */
- (void)ly_addExtendName:(NSString *)extendName target:(id)target;
- (void)ly_removeExtendName:(NSString *)extendName;

/**
 直接在window绑定一个方法,这个方法可以有返回值,(建议: 所有交互传参,尽量用json进行包装,避免出现意想不到的错误)

 @param action 事件
 @param target 对象
 @param argNum 参数个数,默认是0,1,2,3
 @param name 方法名
 */
- (void)ly_addAction:(SEL)action target:(id)target argNum:(NSInteger)argNum name:(NSString *)name;
- (void)ly_removeActionWithName:(NSString *)name;


@end

NS_ASSUME_NONNULL_END
