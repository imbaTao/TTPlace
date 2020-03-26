//
//  HTCycleViewConfigModel.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/8/19.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTCycleViewConfigModel.h"

@interface HTCycleViewConfigModel()
/**
 重复几组
 */
@property(nonatomic, readwrite, assign)NSInteger repeatMutiply;

@end
#warning 倍数参数默认请不要修改
static const int RepeatMutiPly = 1000;
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
        self.scrollInterval = 3;
        self.repeatMutiply = RepeatMutiPly;
    }
    return self;
}


@end
