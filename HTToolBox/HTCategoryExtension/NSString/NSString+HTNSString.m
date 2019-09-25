//
//  NSString+HTNSString.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/8/15.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "NSString+HTNSString.h"

@implementation NSString (HTNSString)
+ (NSString *)fetchCountDownContentWithCountDownValue:(NSInteger)value {
    return [NSString stringWithFormat:@"剩余%02ld:%02ld:%02ld",value / 3600,(value / 60) % 60,value % 60];
}
@end
