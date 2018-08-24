//
//  DisCoverGuideCell.m
//  HZYToolBox
//
//  Created by hong  on 2018/7/5.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "DisCoverGuideCell.h"

@implementation DisCoverGuideCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLB];
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(12);
            make.right.offset(0);
            make.centerY.offset(0);
        }];
    }
    return self;
}

- (UILabel *)titleLB{
    if (!_titleLB) {
        _titleLB = [UILabel creatLabelWithText:@"" textColor:[UIColor whiteColor] fontSize:18];
        _titleLB.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLB;
}

@end
