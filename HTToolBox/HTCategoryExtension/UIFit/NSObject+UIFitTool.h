//
//  NSObject+UIFitTool.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/29.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define ver(value)    [NSObject verticalValue:value]
#define hor(value)    [NSObject horizontal:value]
#define square(value) [NSObject square:value]

@interface NSObject (UIFitTool)

+ (CGFloat)verticalValue:(CGFloat)value;
+ (CGFloat)horizontal:(CGFloat)value;
+ (CGSize)square:(CGFloat)value;
@end

NS_ASSUME_NONNULL_END
