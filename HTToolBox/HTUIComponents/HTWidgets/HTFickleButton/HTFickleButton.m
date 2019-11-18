//
//  HTFickleButton.m
//  Jihuigou-Native
//
//  Created by hong on 2019/11/11.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTFickleButton.h"

@interface  HTFickleButton()
/**
 content
 */
@property(nonatomic, readwrite, strong)UILabel *content;

/**
 icon
 */
@property(nonatomic, readwrite, strong)UIImageView *icon;

/**
 icon数组
 */
@property(nonatomic, readwrite, copy)NSArray *imgs;

/**
 颜色
 */
@property(nonatomic, readwrite, copy)NSArray <UIColor *>*colors;

/**
 角度
 */
@property(nonatomic, readwrite, assign)CGFloat angle;

@end

@implementation HTFickleButton
@synthesize selected = _selected;
- (instancetype)initWithHorizontalRotationButtonWithTitle:(NSString *)title font:(UIFont *)font normalColor:(UIColor *)color selectedColor:(UIColor *)selectedColor imgs:(NSArray<NSString *> *)imgs angle:(CGFloat)angle{
    
     self = [super initWithFrame:CGRectZero];
    
    
    self.imgs = imgs;
    if (selectedColor) {
        self.colors = @[color,selectedColor];
    }
    self.angle = angle;
    self.content = [UILabel font:font color:color textAlignment:NSTextAlignmentLeft placeholder:title];
    [self addSubview:self.content];
    
    self.icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgs.firstObject]];
    [self addSubview:self.icon];
    
    
    [self addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    
    // layout
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.centerY.equalTo(self);
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.centerY.equalTo(self);
    }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0)), dispatch_get_main_queue(), ^{
//        [s]
//    });
    return self;
}

- (void)clickAction {
    self.selected = !self.selected;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    self.userInteractionEnabled = false;
    [UIView animateWithDuration:0.3 animations:^{
        if (selected) {
            if (self.imgs.count > 1) {
                self.content.textColor = self.colors.lastObject;
                self.icon.image = [UIImage imageNamed:self.imgs.lastObject];
            }
            self.icon.transform = CGAffineTransformMakeRotation(self.angle);
        }else {
            if (self.imgs.count > 1) {
                self.icon.image = [UIImage imageNamed:self.imgs.firstObject];
                self.content.textColor = self.colors.firstObject;
            }
            self.icon.transform = CGAffineTransformIdentity;
        }
    }completion:^(BOOL finished) {
        self.userInteractionEnabled = true;
    }];
}

- (void)changeNewTitle:(NSString *)newValue {
    self.content.text = newValue;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset(self.content.intrinsicContentSize.width + 6 + self.icon.size.width);
    }];
}

@end
