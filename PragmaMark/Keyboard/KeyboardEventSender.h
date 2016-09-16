//
//  KeyboardEventSender.h
//  PragmaMark
//
//  Created by Administrator on 16/9/12.
//  Copyright © 2016年 catch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>

@interface KeyboardEventSender : NSObject

- (void)beginKeyBoradEvents;

- (void)sendKeyCode:(NSInteger)keyCode;

- (void)sendKeyCode:(NSInteger)keyCode withModifierCommand:(BOOL)command
                alt:(BOOL)alt
              shift:(BOOL)shift
            control:(BOOL)control;

- (void)sendKeyCode:(NSInteger)keyCode withModifier:(NSInteger)modifierMask;

- (void)endKeyBoradEvents;

/**
 * 判断用户的键盘布局，是否使用Dvorak类型的键盘
 */
+(BOOL)useDvorakLayout;

@end
