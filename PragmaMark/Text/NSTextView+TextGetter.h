//
//  NSString+TextGetter.h
//  PragmaMark
//
//  Created by Administrator on 16/9/16.
//  Copyright © 2016年 catch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TextResult;

@interface NSTextView (TextGetter)

/**
 * 获取当前鼠标光标的位置 
 */
- (NSInteger)currentCurseLocation;

/**
 * 获取当前鼠标光标所在行的文字
 */
- (TextResult *)textResultOfCurrentLine;

@end
