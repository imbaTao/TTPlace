//
//  RCSwiftTool.m
//  TTPlace
//
//  Created by Mr.hong on 2021/2/20.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

#import "RCSwiftTool.h"

@implementation RCSwiftTool
+ (UIImageView *)getImageView:(RCMessageCell *)cell {
    RCloudImageView *imageView = cell.portraitImageView;
    return (UIImageView *)imageView;
}
@end
