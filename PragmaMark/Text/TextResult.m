//
//  TextResult.m
//  PragmaMark
//
//  Created by Administrator on 16/9/12.
//  Copyright © 2016年 catch. All rights reserved.
//

#import "TextResult.h"

@implementation TextResult

- (instancetype)initWithRange:(NSRange)aRange string:(NSString *)aString {
    self = [super init];
    if (self) {
        _range  = aRange;
        _string = aString;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Location:%ld, Length:%ld, String:%@", _range.location, _range.length,_string];
}

@end
