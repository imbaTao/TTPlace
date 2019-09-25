//
//  TomatoCommonBoardView.m
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/25.
//  Copyright © 2019 HT. All rights reserved.
//

#import "TomatoCommonBoardView.h"

@implementation TomatoCommonBoardView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        [self settingShadowWithShadowRadius:5 offset:CGSizeMake(3, 3) color:[UIColor blackColor] opacity:0.05];
    }
    return self;
}
@end
