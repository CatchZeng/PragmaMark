//
//  KeyboardEventSender.m
//  PragmaMark
//
//  Created by Administrator on 16/9/12.
//  Copyright © 2016年 catch. All rights reserved.
//

#import "KeyboardEventSender.h"

@interface KeyboardEventSender ()
{
    CGEventSourceRef _source;
    CGEventTapLocation _location;
}
@end

@implementation KeyboardEventSender

- (void)beginKeyBoradEvents {
    _source     = CGEventSourceCreate(kCGEventSourceStateCombinedSessionState);
    _location   = kCGHIDEventTap;
}

- (void)sendKeyCode:(NSInteger)keyCode {
    [self sendKeyCode:keyCode withModifier:0];
}

- (void)sendKeyCode:(NSInteger)keyCode withModifierCommand:(BOOL)command
                alt:(BOOL)alt
              shift:(BOOL)shift
            control:(BOOL)control
{
    NSInteger modifier = 0;
    if (command) {
        modifier = modifier ^ kCGEventFlagMaskCommand;
    }
    if (alt) {
        modifier = modifier ^ kCGEventFlagMaskAlternate;
    }
    if (shift) {
        modifier = modifier ^ kCGEventFlagMaskShift;
    }
    if (control) {
        modifier = modifier ^ kCGEventFlagMaskControl;
    }
    
    [self sendKeyCode:keyCode withModifier:modifier];
}

- (void)sendKeyCode:(NSInteger)keyCode withModifier:(NSInteger)modifierMask {
    NSAssert(_source != NULL, @"You should call -beginKeyBoradEvents before sending a key event");
    CGEventRef event;
    event = CGEventCreateKeyboardEvent(_source, keyCode, true);
    CGEventSetFlags(event, modifierMask);
    CGEventPost(_location, event);
    CFRelease(event);
    
    event = CGEventCreateKeyboardEvent(_source, keyCode, false);
    CGEventSetFlags(event, modifierMask);
    CGEventPost(_location, event);
    CFRelease(event);
}

- (void)endKeyBoradEvents {
    if (_source == nil) {
        return;
    }
    
    NSAssert(_source != NULL, @"You should call -beginKeyBoradEvents before end current keyborad event");
    CFRelease(_source);
    _source = nil;
}

+(BOOL)useDvorakLayout {
    TISInputSourceRef inputSource = TISCopyCurrentKeyboardLayoutInputSource();
    NSString *layoutID = (__bridge NSString *)TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceID);
    CFRelease(inputSource);
    
    if ([layoutID rangeOfString:@"Dvorak" options:NSCaseInsensitiveSearch].location != NSNotFound) {
        return YES;
    }
    else {
        return NO;
    }
}

@end
