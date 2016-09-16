//
//  NSString+TextGetter.m
//  PragmaMark
//
//  Created by Administrator on 16/9/16.
//  Copyright © 2016年 catch. All rights reserved.
//

#import "NSString+TextGetter.h"
#import "TextResult.h"

@implementation NSString (TextGetter)

- (TextResult *)textResultOfCurrentLineCurrentLocation:(NSInteger)location {
    NSInteger curseLocation = location;
    NSRange range = NSMakeRange(0, curseLocation);
    NSRange thisLineRange = [self rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet] options:NSBackwardsSearch range:range];
    
    NSString *line = nil;
    if (thisLineRange.location != NSNotFound) {
        NSRange lineRange = NSMakeRange(thisLineRange.location + 1, curseLocation - thisLineRange.location - 1);
        if (lineRange.location < [self length] && NSMaxRange(lineRange) < [self length]) {
            line = [self substringWithRange:lineRange];
            return [[TextResult alloc] initWithRange:lineRange string:line];
        }
    }
    
    return nil;
}

@end
