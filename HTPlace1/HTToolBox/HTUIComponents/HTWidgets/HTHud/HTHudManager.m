//
//  HTHudManager.m
//  Jihuigou-Native
//
//  Created by hong on 2020/1/3.
//  Copyright © 2020 xiongbenwan. All rights reserved.
//

#import "HTHudManager.h"

@implementation HTHudManager
singleM()



- (NSTimeInterval)hiddenTimeInterval {
    if (!_hiddenTimeInterval) {
        _hiddenTimeInterval = 1.2;
    }
    return _hiddenTimeInterval;
}
@end
