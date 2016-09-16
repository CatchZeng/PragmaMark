//
//  NSString+TextGetter.h
//  PragmaMark
//
//  Created by Administrator on 16/9/16.
//  Copyright © 2016年 catch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TextResult;

@interface NSString (TextGetter)

/**
 *  获取当前鼠标光标所在行的文字，结果以TextResult形式返回
 */
- (TextResult *)textResultOfCurrentLineCurrentLocation:(NSInteger)location;

@end
