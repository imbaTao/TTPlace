//
//  HTCycleViewNormalStyleCell.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/9/26.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTCycleViewNormalStyleCell.h"

@implementation HTCycleViewNormalStyleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentImageView = [[UIImageView alloc] init];
        [self addSubview:self.contentImageView];
        [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}
@end
