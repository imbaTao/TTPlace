//
//  HTDrawerView.m
//  Jihuigou-Native
//
//  Created by hong on 2019/11/11.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTDrawerView.h"


@interface HTDrawerView()

/**
 原尺寸
 */
@property(nonatomic, readwrite, assign)CGSize sourceSize;

/**
 展开尺寸
 */
@property(nonatomic, readwrite, assign)CGSize unfoldSize;

/**
 动画时间
 */
@property(nonatomic, readwrite, assign)CGFloat duration;


@end

@implementation HTDrawerView

- (instancetype)initWithSourceSize:(CGSize)sSize unfloldSize:(CGSize)uSize duration:(CGFloat)duration {
    self = [super init];
    if (self) {
        self.layer.masksToBounds = true;
        self.backgroundColor = [UIColor whiteColor];
        self.sourceSize = sSize;
        self.unfoldSize = uSize;
        self.duration = duration;
    }
    return self;
}

- (void)unfold {
    @weakify(self);
    [UIView animateWithDuration:self.duration animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.unfoldSize);
        }];
        [self.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        @strongify(self);
        [self unflodComplet];
    }];
}

- (void)packUp {
    [UIView animateWithDuration:self.duration animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.sourceSize);
        }];
        [self.superview layoutIfNeeded];
    }];
}

- (void)unflodComplet {
    
}

- (void)changeUnflodSize:(CGSize)flodSize {
    self.unfoldSize = flodSize;
}
@end
