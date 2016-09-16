//
//  UserDefaultUtil.m
//  PragmaMark
//
//  Created by Administrator on 16/9/16.
//  Copyright © 2016年 catch. All rights reserved.
//

#import "UserDefaultUtil.h"

@implementation UserDefaultUtil

+(void)saveValue:(id)value forKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (key) {
        [userDefaults setObject:value forKey:key];
        [userDefaults synchronize];
    }
}

+(id)valueWithKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (key) {
        return [userDefaults objectForKey:key];
    }else{
        return nil;
    }
}

+(BOOL)boolValueWithKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (key) {
        return [userDefaults boolForKey:key];
    }else{
        return NO;
    }
}

+(void)saveBoolValue:(BOOL)value withKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (key) {
        [userDefaults setBool:value forKey:key];
        [userDefaults synchronize];
    }
}

+(void)removeObjectWithKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (key) {
        [userDefaults removeObjectForKey:key];
        [userDefaults synchronize];
    }
}

+(BOOL)hasValueForKey:(NSString *)key{
    if ([self valueWithKey:key]) {
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)isFirstLaunch{
    return [self isFirstEventWithKey:@"FirstLaunch"];
}

+(BOOL)isFirstLaunchCurrentVersion{
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString* key = [NSString stringWithFormat:@"FirstLaunch%@",version];
    return [self isFirstEventWithKey:key];
}

+(BOOL)isFirstEventWithKey:(NSString *)key{
    if (![self.class boolValueWithKey:key]) {
        [self.class saveBoolValue:YES withKey:key];
        return YES;
    }
    return NO;
}

+(void)print{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    NSLog(@"MBUserDefaults:/n %@",dic);
}

@end