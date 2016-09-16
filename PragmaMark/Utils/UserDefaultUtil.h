//
//  UserDefaultUtil.h
//  PragmaMark
//
//  Created by Administrator on 16/9/16.
//  Copyright © 2016年 catch. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  NSUserDefaults的封装类
 */
@interface UserDefaultUtil : NSObject

/**
 *  通过key保存值
 *
 *  @param value 值
 *  @param key   键
 */
+(void)saveValue:(id)value forKey:(NSString *)key;

/**
 *  通过key找值
 *
 *  @param key 键
 *
 *  @return 值
 */
+(id)valueWithKey:(NSString *)key;

/**
 *  通过key找BOOL值
 *
 *  @param key 键
 *
 *  @return 值
 */
+(BOOL)boolValueWithKey:(NSString *)key;

/**
 *  通过key保存BOOL值
 *
 *  @param value 值
 *  @param key 键
 */
+(void)saveBoolValue:(BOOL)value withKey:(NSString *)key;

/**
 *  通过key移除
 *
 *  @param key 键
 */
+(void)removeObjectWithKey:(NSString *)key;

/**
 *  是否有这个值
 *
 *  @param key 键
 *
 *  @return YES/NO
 */
+(BOOL)hasValueForKey:(NSString *)key;

/**
 *  是否为第一次启动程序
 *
 *  @return
 */
+(BOOL)isFirstLaunch;

/**
 *  是否为当前版本第一次启动程序
 *
 *  @return
 */
+(BOOL)isFirstLaunchCurrentVersion;

/**
 *  是否是第一次做某事
 *
 *  @param key 键
 *
 *  @return YES/NO
 */
+(BOOL)isFirstEventWithKey:(NSString *)key;

/**
 *  打印
 */
+(void)print;

@end