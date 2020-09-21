//
//  YNPubulishProgressView.m
//  HTPlace
//
//  Created by Mr.hong on 2020/9/17.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "YNPubulishProgressView.h"

@interface YNPubulishProgressView()

/**
 bar
 */
@property(nonatomic, readwrite, strong) UIView *bar;

/**
 barLayer
 */
@property(nonatomic, readwrite, strong)CAGradientLayer *glayer;

@end

@implementation YNPubulishProgressView


- (instancetype)initWithIcon:(UIImage *)icon {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.bar = [[UIView alloc] init];
    //    self.bar.backgroundColor = [UIColor redColor];
        [self addSubview:self.bar];
        [self.bar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.height.offset(2);
            make.top.offset(300);
            make.width.offset(0);
        }];
        
        self.glayer =  [self.bar settingHorizontalGradientLayerWithColors:@[rgba(255, 105, 180, 1),rgba(0, 255, 255, 1)] cornerRadius:0.5];

    }
    return self;
}


- (void)showProgerss:(CGFloat)value {
    self.glayer.frame = CGRectMake(self.glayer.frame.origin.x, self.glayer.frame.origin.y, SCREEN_W * value, 2);
//    [UIView animateWithDuration:0.3 animations:^{
//
//    }];
}

@end
