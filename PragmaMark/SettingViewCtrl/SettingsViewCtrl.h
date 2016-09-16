//
//  SettingsViewCtrl.h
//  PragmaMark
//
//  Created by Administrator on 16/9/16.
//  Copyright © 2016年 catch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SettingsViewCtrl : NSWindowController

+(void)loadDefaultSettings;

+(NSString *)loadStrFromSettings;

@end
