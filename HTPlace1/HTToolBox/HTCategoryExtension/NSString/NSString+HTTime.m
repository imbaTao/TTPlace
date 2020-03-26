//
//  NSString+HTTime.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/8/15.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "NSString+HTTime.h"

@implementation NSString (HTNSString)
#pragma mark - 根据倒计时获取结束时间
+ (NSString *)fetchCountDownContentWithCountDownValue:(NSInteger)count {
    if (count >= 24 * 60 * 60) {
        return [NSString stringWithFormat:@"%02ld天%02ld:%02ld:%02ld",(NSInteger)(count / (24 * 60 * 60)) ,(NSInteger)(count / 3600.0) % 24,(NSInteger)(count / 60) % 60,(NSInteger)count % 60];
    }else {
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(NSInteger)(count / 3600.0),(NSInteger)(count / 60) % 60,(NSInteger)count % 60];
    }
}


@end
