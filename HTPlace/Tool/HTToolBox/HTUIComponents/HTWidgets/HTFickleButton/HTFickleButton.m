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
 position
 */
@property(nonatomic, readwrite, assign)NSInteger position;

@end

@implementation HTFickleButton
@synthesize selected = _selected;

- (instancetype)initWithHorizontalRotationButtonWithTitle:(NSString *)title font:(UIFont *)font normalColor:(UIColor *)color imgName:(NSString *)imgName {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        // 标题
        self.content = [UILabel font:font color:color textAlignment:NSTextAlignmentLeft placeholder:title];
        [self addSubview:self.content];
        
        // 图标
        self.icon = [UIImageView name:imgName];
        [self addSubview:self.icon];
        
        // 添加点击事件
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
        
    }
    return self;
}



- (instancetype)initWithHorizontalRotationButtonWithTitle:(NSString *)title font:(UIFont *)font normalColor:(UIColor *)color imgName:(NSString *)imgName position:(NSInteger)position {
    self = [self initWithHorizontalRotationButtonWithTitle:title font:font normalColor:color imgName:imgName];
    switch (position) {
        case 0:{
            // 图左侧
            [self.content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.offset(0);
                make.centerY.equalTo(self);
            }];
            
            [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(0);
                make.centerY.equalTo(self);
            }];
        }break;
        case 1:{
            // 右侧
            [self.content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(0);
                make.centerY.equalTo(self);
            }];
            
            [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.offset(0);
                make.centerY.equalTo(self);
            }];
        }break;
        default:
            break;
    }
    self.position = position;
    [self relayoutWithPositon:self.position];
    return self;
    
}

// 子类复写
- (void)relayoutWithPositon:(NSInteger)position {
    
}


- (instancetype)initWithHorizontalRotationButtonWithTitle:(NSString *)title font:(UIFont *)font normalColor:(UIColor *)color selectedColor:(UIColor *)selectedColor imgs:(NSArray<NSString *> *)imgs angle:(CGFloat)angle{
     self = [self initWithHorizontalRotationButtonWithTitle:title font:font normalColor:color imgName:imgs.firstObject];
    self.imgs = imgs;
    self.icon.image = [UIImage imageNamed:imgs.firstObject];
    if (selectedColor) {
        self.colors = @[color,selectedColor];
    }
    self.angle = angle;
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

- (void)revertButtonStatus {
    self.icon.transform = CGAffineTransformIdentity;
    _selected = false;
}

- (void)changeNewTitle:(NSString *)newValue {
    self.content.text = newValue;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset(self.content.intrinsicContentSize.width + 6 + self.icon.size.width);
    }];
}

@end
