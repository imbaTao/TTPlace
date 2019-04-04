//
//  UIImageView+HZYImageView.m
//  ChingoItemZDTY
//
//  Created by hong  on 2019/3/6.
//  Copyright © 2019 HSKY. All rights reserved.
//

#import "UIImageView+HZYImageView.h"
@implementation UIImageView (HZYImageView)
+ (instancetype)name:(NSString *)name{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
}
@end
