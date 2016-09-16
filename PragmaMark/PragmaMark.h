//
//  PragmaMark.h
//  PragmaMark
//
//  Created by Administrator on 16/9/12.
//  Copyright © 2016年 catch. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface PragmaMark : NSObject

+ (instancetype)sharedPlugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;


@end