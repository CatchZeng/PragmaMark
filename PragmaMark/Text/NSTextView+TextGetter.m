//
//  NSString+TextGetter.m
//  PragmaMark
//
//  Created by Administrator on 16/9/16.
//  Copyright © 2016年 catch. All rights reserved.
//

#import "NSTextView+TextGetter.h"
#import "TextResult.h"
#import "NSString+TextGetter.h"

@implementation NSTextView (TextGetter)


- (NSInteger)currentCurseLocation {
    return [[self selectedRanges][0] rangeValue].location;
}

- (TextResult *)textResultOfCurrentLine {
    return [self.textStorage.string textResultOfCurrentLineCurrentLocation:[self currentCurseLocation]];
}

@end
