//
//  HZYBubbleHeaderView.m
//  HZYToolBox
//
//  Created by hong  on 2018/8/31.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "HZYBubbleHeaderView.h"
#import "UIImage+ImageProcess.h"
#import "HZYBubbleCell.h"

#define TitleFontSize 12
#define SubTitleFontSize 10
@implementation HZYBubbleHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconImgView];
        [self addSubview:self.titleLB];
        [self addSubview:self.playTimeLB];
        [self addSubview:self.ratioLB];
        [self addSubview:self.fileSizeLB];
        [self addSubview:self.segementLine];
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews{
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.offset(8);
    }];

    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImgView.mas_top).offset(-2);
    make.left.mas_equalTo(self.iconImgView.mas_right).offset(8).priorityHigh();
        make.right.offset(-8).priorityHigh();
    }];

    [self.playTimeLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.titleLB.mas_bottom).offset(5);
        make.left.equalTo(self.titleLB).priorityHigh();
    }];

    [self.ratioLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.playTimeLB); make.left.mas_equalTo(self.playTimeLB.mas_right).offset(8);
    }];

    [self.fileSizeLB mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(self.ratioLB);
      make.left.mas_equalTo(self.ratioLB.mas_right).offset(8);
        make.right.offset(-8).priorityHigh();
    }];
    
    [self.segementLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.offset(1);
    }];
}

#pragma mark - Setter && Getter
- (UIImageView *)iconImgView{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bubble_mediaIcon"]];
    }
    return _iconImgView;
}

- (UILabel *)titleLB{
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.font = [UIFont systemFontOfSize:TitleFontSize];
        _titleLB.lineBreakMode = NSLineBreakByCharWrapping;
        _titleLB.numberOfLines = 2;
        _titleLB.textColor = [UIColor whiteColor];
        
    }
    return _titleLB;
}


- (UILabel *)playTimeLB{
    if (!_playTimeLB) {
        _playTimeLB = [[UILabel alloc] init];
        _playTimeLB.font = [UIFont systemFontOfSize:SubTitleFontSize];
        _playTimeLB.textColor = [UIColor whiteColor];
    }
    return _playTimeLB;
}

- (UILabel *)ratioLB{
    if (!_ratioLB) {
        _ratioLB = [[UILabel alloc] init];
        _ratioLB.font = [UIFont systemFontOfSize:SubTitleFontSize];
        _ratioLB.textColor = [UIColor whiteColor];
    }
    return _ratioLB;
}

- (UILabel *)fileSizeLB{
    if (!_fileSizeLB) {
        _fileSizeLB = [[UILabel alloc] init];
        _fileSizeLB.font = [UIFont systemFontOfSize:SubTitleFontSize];
        _fileSizeLB.textColor = [UIColor whiteColor];
    }
    return _fileSizeLB;
}

- (UIImageView *)segementLine{
    if (!_segementLine) {
        _segementLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CellWidth, 1)];
        _segementLine.image = [UIImage imageWithLineWithImageView:_segementLine color:RGB(151, 151, 151) length:3 interval:1];
    }
    return _segementLine;
}

@end
