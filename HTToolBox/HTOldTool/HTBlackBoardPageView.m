//
//  HTBlackBoardPageView.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/11.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTBlackBoardPageView.h"

@implementation HTBlackBoardPageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidden = true;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
//        [self addTarget:self action:@selector(showOrhideBoard)];
    }
    return self;
}

- (void)showOrhideBoard {
    self.hidden = !self.hidden;
}
@end
