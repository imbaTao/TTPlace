//
//  NSString+HTPrice.m
//  Jihuigou-Native
//
//  Created by hong on 2020/4/29.
//  Copyright © 2020 xiongbenwan. All rights reserved.
//

#import "NSString+HTPrice.h"

@implementation NSString (HTPrice)

// 处理价格
+ (NSString *)disposePrice:(NSString *)value {
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                       scale:2
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    NSDecimalNumber *priceNumber = [NSDecimalNumber decimalNumberWithString:value];
    priceNumber = [priceNumber decimalNumberByRoundingAccordingToBehavior:roundUp];
    value = [NSString stringWithFormat:@"%.2f",priceNumber.doubleValue];
    
    NSArray *priceArray = [value componentsSeparatedByString:@"."];
    if (priceArray.count == 2) {
        // 浮点部分价格
        NSInteger floatPrice = [priceArray.lastObject floatValue];

        // 如果为0,截取掉.00
        if (floatPrice == 0) {
            value = [value substringToIndex:value.length - 3];
        }

        // 如果
        if (floatPrice >= 10 & floatPrice % 10 == 0) {
            value = [value substringToIndex:value.length - 1];
        }
    }
    value = [NSString stringWithFormat:@"¥%@",value];
    return value;
}

@end
