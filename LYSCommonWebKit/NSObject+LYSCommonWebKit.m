//
//  NSObject+LYSCommonWebKit.m
//  LYSCommonWebKitDemo
//
//  Created by HENAN on 2019/7/18.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "NSObject+LYSCommonWebKit.h"

@implementation NSObject (LYSCommonWebKit)
- (void)webView:(id)webView didCreateJavaScriptContext:(JSContext *)context forFrame:(id)frame
{
    NSDictionary *dict = @{
                           @"webView": webView,
                           @"context": context
                           };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lys_didCreateJavaScriptContext" object:nil userInfo:dict];
}
@end
