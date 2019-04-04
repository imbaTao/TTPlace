//
//  UIFont+HZYFont.m
//  ChingoItemZDTY
//
//  Created by hong2 on 2019/3/7.
//  Copyright © 2019 HSKY. All rights reserved.
//

#import "UIFont+HZYFont.h"

@implementation UIFont (HZYFont)
+ (instancetype)fontSize:(CGFloat)size{
    if (KWIDTH == 320) {
        return [UIFont systemFontOfSize:(size - 1)];
    }else if (KWIDTH == 375){
        return [UIFont systemFontOfSize:size];
    }else{
        return [UIFont systemFontOfSize:(size + 1 )];
    }
}

+ (instancetype)fontSize:(CGFloat)size name:(NSString *)name {
    if (KWIDTH == 320) {
        return [UIFont fontWithName:name size:size - 1];
    }else if (KWIDTH == 375){
        return [UIFont fontWithName:name size:size];
    }else{
        return [UIFont fontWithName:name size:size + 1];
    }
}

@end
