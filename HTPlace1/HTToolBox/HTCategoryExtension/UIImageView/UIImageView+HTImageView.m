//
//  UIImageView+HTImageView.m
//  ChingoItemZDTY
//
//  Created by hong  on 2019/3/6.
//  Copyright © 2019 HSKY. All rights reserved.
//

#import "UIImageView+HTImageView.h"
@implementation UIImageView (HTImageView)
+ (instancetype)name:(NSString *)name{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
}

+ (instancetype)name:(NSString *)name superView:(UIView *)superView{
    UIImageView *v = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    [superView addSubview:v];
    return v;
}

@end
