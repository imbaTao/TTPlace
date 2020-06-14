//
//  UIImage+HTEx.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/29.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "UIImage+HTEx.h"

@implementation UIImage (HTUIImage)

+ (UIImage *)name:(NSString *)name {
    if (name.length == 0) {
        return [[UIImage alloc] init];
    }else {
        return [UIImage imageNamed:name];
    }
}
@end
