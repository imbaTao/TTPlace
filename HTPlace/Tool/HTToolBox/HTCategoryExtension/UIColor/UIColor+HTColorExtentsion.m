//
//  UIColor+HTColorExtentsion.m
//  HZYToolBox
//
//  Created by hong on 2019/11/21.
//  Copyright © 2019 HZY. All rights reserved.
//

#import "UIColor+HTColorExtentsion.h"

@implementation UIColor (HTColorExtentsion)

+ (instancetype)randomColor {
    return [UIColor colorWithRed:arc4random()%255 / 255.0 green:arc4random()%255 / 255.0 blue:arc4random()%255 / 255.0 alpha:1];
}

@end
