//
//  HTCycleViewConfigModel.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/8/19.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTCycleViewConfigModel.h"

@interface HTCycleViewConfigModel()

@end

@implementation HTCycleViewConfigModel
- (instancetype)initWithFlowLayout:(UICollectionViewFlowLayout *)flowLayout cellClassName:(NSString *)cellClassName {
    self = [super init];
    if (self) {
        self.flowLayout = flowLayout;
        self.cellClassName = cellClassName;
        self.pageEnabled = true;
        self.autoCycle = true;
        self.itemCountInOnePage = 1;
        self.allowScorllEnabel = true;
        self.showPageControl = true;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}


@end
