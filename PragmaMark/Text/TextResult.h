//
//  TextResult.h
//  PragmaMark
//
//  Created by Administrator on 16/9/12.
//  Copyright © 2016年 catch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextResult : NSObject

@property (nonatomic, assign) NSRange   range;
@property (nonatomic, copy)   NSString *string;

- (instancetype)initWithRange:(NSRange)aRange string:(NSString *)aString;

@end
